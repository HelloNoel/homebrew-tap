class Aiexandria < Formula
  desc "MCP server for Git documentation with optional semantic search"
  homepage "https://hellonoel.github.io/aiexandria/"
  license "Apache-2.0"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.4.0/aiexandria-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "34a0e37d9b047fd2a59d317a69b389bd6e41e91220820bac55793267b299e496"
    end
    on_intel do
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.4.0/aiexandria-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "ed13e10ac2253fda34f5646363e30aea33f8523563a1704a79c03133aa089575"
    end
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.4.0/aiexandria-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3002aa747e0522554687334b7a91db827cab46c4da98879f70541f93e9917f04"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/HelloNoel/aiexandria/releases/download/v0.4.0/aiexandria-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18e14de9628b2fea19248e748f5cb7cb2a83ee79c5466695fc8a248bca5a71c6"
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
