# HelloNoel Homebrew tap

Install [AIexandria](https://github.com/HelloNoel/aiexandria), an MCP server for
documentation in Git repositories:

```sh
brew install HelloNoel/tap/aiexandria
```

Homebrew selects the release archive for your platform, verifies its SHA-256
checksum, and installs Git as a dependency. No Rust toolchain is needed.

The formula supports macOS 11 or newer and Linux with glibc 2.35 or newer, on
ARM64 and x86-64. Homebrew itself may require a newer operating system; see its
[supported configurations](https://docs.brew.sh/Support-Tiers). For Windows, use
the
[release downloads](https://github.com/HelloNoel/aiexandria/releases/latest).

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
update. CI checks installation and the formula test on all four supported
platform/architecture combinations.

The formula is generated from `scripts/aiexandria.rb.in`; make structural
changes there before running the updater. Release archives are maintained by
AIexandria's release workflow.
