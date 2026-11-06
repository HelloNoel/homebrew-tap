# HelloNoel Homebrew tap

On Apple Silicon macOS or Linux, install
[AIexandria](https://github.com/HelloNoel/aiexandria), an MCP server for
documentation in Git repositories:

```sh
brew install HelloNoel/tap/aiexandria
```

Homebrew selects the release archive for your platform, verifies its SHA-256
checksum, and installs Git as a dependency. No Rust toolchain is needed. Ripgrep
is optional and is not installed by this formula; use `brew install ripgrep` for
sources whose search commands invoke `rg`.

The release binaries support macOS 11 or newer and Linux with glibc 2.35 or
newer, on ARM64 and x86-64. Homebrew itself may require a newer operating
system; see its [supported configurations](https://docs.brew.sh/Support-Tiers).
For Windows, use the
[release downloads](https://github.com/HelloNoel/aiexandria/releases/latest).

Homebrew no longer provides prebuilt dependency packages for Intel macOS. An
Intel installation can therefore compile Git and its dependency chain from
source, even though AIexandria itself is prebuilt. For Intel Macs, we recommend
the macOS x86-64 release archive with an existing Git 2.43.7 or newer.

## Connect your MCP client

See the
[installation guide](https://hellonoel.github.io/aiexandria/installation.html)
for client configuration. AIexandria is a stdio server started by your client;
it does not need a background service.

## Upgrade

```sh
brew update
brew upgrade HelloNoel/tap/aiexandria
```

Restart your MCP client after upgrading.

## Maintain the formula

After publishing an AIexandria release, work in Homebrew's tap checkout and
generate the formula from the release's published `SHA256SUMS` and asset
metadata:

```sh
cd "$(brew --repository HelloNoel/tap)"
python3 scripts/update.py 0.4.0
brew style HelloNoel/tap/aiexandria
brew install HelloNoel/tap/aiexandria
brew test HelloNoel/tap/aiexandria
```

Use `brew reinstall HelloNoel/tap/aiexandria` if it is already installed. Review
the version, archive URLs and checksums, then commit and push the formula
update. CI checks installation, the formula test, style and audit on Apple
Silicon macOS and Linux ARM64/x86-64. Intel macOS users should use the release
archive; the Intel formula remains available without a required tap CI job.

The formula is generated from `scripts/aiexandria.rb.in`; make structural
changes there before running the updater. Release archives are maintained by
AIexandria's release workflow.
