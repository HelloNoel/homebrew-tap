class Aiexandria < Formula
  desc "MCP server for Git documentation with optional semantic search"
  homepage "https://hellonoel.github.io/aiexandria/"
  license "Apache-2.0"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.5.0/aiexandria-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "4faff2b3428570d48cac942203a833e725aaab974d65bc86f99754d35b75cbb3"
    end
    on_intel do
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.5.0/aiexandria-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "e179b2039623fa7534027c1e68dee4cdbc8fe257adf6f8daa5b3e462061544b2"
    end
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.5.0/aiexandria-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ab324a49f91dd1a1e2ccc40b6ea0c6f314e76d45622a19c5ba0c15772ea0b05"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.5.0/aiexandria-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4535fe0cf6a1d67f6dd01dc605a243e30147556fbd2b9581587519b3c4532e55"
    end
  end

  def install
    bin.install "aiexandria"
  end

  test do
    assert_match "aiexandria #{version}", shell_output("#{bin}/aiexandria --version")
    (testpath/"README.md").write("# Homebrew test\n\nDocumentation for a local source.\n")
    output = shell_output("#{bin}/aiexandria generate --repo #{testpath} --no-search --no-nested")
    assert_match "README.md", output
    assert_match "kind: doc", output
  end
end
