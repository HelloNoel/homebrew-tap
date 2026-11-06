"""Update the formula from a published AIexandria release and its checksums."""
import argparse
import json
from pathlib import Path
import re
from urllib.request import Request, urlopen


def fetch(url):
    request = Request(url, headers={"User-Agent": "HelloNoel-homebrew-tap"})
    with urlopen(request, timeout=30) as response:
        return response.read().decode("utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("version", help="Published stable version, such as 0.4.0")
    args = parser.parse_args()
    version = args.version.removeprefix("v")
    if not re.fullmatch(r"(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)", version):
        parser.error("expected a stable version such as 0.4.0")

    tag = f"v{version}"
    repository = "HelloNoel/aiexandria"
    release = json.loads(fetch(f"https://api.github.com/repos/{repository}/releases/tags/{tag}"))
    if release["draft"] or release["prerelease"] or release["tag_name"] != tag:
        raise SystemExit("Expected a published stable release with the requested tag")
    base = f"https://github.com/{repository}/releases/download/{tag}"
    checksums = {}
    for line in fetch(f"{base}/SHA256SUMS").splitlines():
        match = re.fullmatch(r"([0-9a-f]{64})  ([A-Za-z0-9_.-]+)", line)
        if not match or match[2] in checksums:
            raise SystemExit("Invalid or duplicate SHA256SUMS entry")
        checksums[match[2]] = match[1]
    assets = {asset["name"]: asset for asset in release["assets"]}
    targets = {
        "macos_arm": "aarch64-apple-darwin",
        "macos_intel": "x86_64-apple-darwin",
        "linux_arm": "aarch64-unknown-linux-gnu",
        "linux_intel": "x86_64-unknown-linux-gnu",
    }
    values = {"version": version, "base": base}
    for key, target in targets.items():
        name = f"aiexandria-{tag}-{target}.tar.gz"
        if name not in checksums or name not in assets:
            raise SystemExit(f"Missing release archive or checksum: {name}")
        if assets[name].get("state") != "uploaded":
            raise SystemExit(f"Release archive is not uploaded: {name}")
        digest = assets[name].get("digest")
        if digest and digest != f"sha256:{checksums[name]}":
            raise SystemExit(f"Release asset digest disagrees with SHA256SUMS: {name}")
        values[f"{key}_sha256"] = checksums[name]

    root = Path(__file__).resolve().parents[1]
    template = (root / "scripts/aiexandria.rb.in").read_text()
    for key, value in values.items():
        template = template.replace(f"@{key}@", value)
    if re.search(r"@[a-z_]+@", template):
        raise SystemExit("Unresolved formula template placeholder")
    (root / "Formula/aiexandria.rb").write_text(template)
    print(f"Updated Formula/aiexandria.rb to {tag}; review and test before pushing.")


if __name__ == "__main__":
    main()
