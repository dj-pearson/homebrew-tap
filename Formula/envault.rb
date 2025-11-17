# Homebrew Formula for EnvVault CLI
# Template version - will be updated with actual values during release

class Envault < Formula
  desc "Secure, local-first environment variable management"
  homepage "https://envault.net"
  version "VERSION_PLACEHOLDER"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dj-pearson/vault-verse/releases/download/vVERSION_PLACEHOLDER/envault-darwin-arm64"
      sha256 "SHA256_ARM64_PLACEHOLDER"
    else
      url "https://github.com/dj-pearson/vault-verse/releases/download/vVERSION_PLACEHOLDER/envault-darwin-amd64"
      sha256 "SHA256_AMD64_PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dj-pearson/vault-verse/releases/download/vVERSION_PLACEHOLDER/envault-linux-arm64"
      sha256 "SHA256_LINUX_ARM64_PLACEHOLDER"
    else
      url "https://github.com/dj-pearson/vault-verse/releases/download/vVERSION_PLACEHOLDER/envault-linux-amd64"
      sha256 "SHA256_LINUX_AMD64_PLACEHOLDER"
    end
  end

  def install
    bin.install "envault-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}" => "envault"

    # Generate shell completions
    output = Utils.safe_popen_read("#{bin}/envault", "completion", "bash")
    (bash_completion/"envault").write output

    output = Utils.safe_popen_read("#{bin}/envault", "completion", "zsh")
    (zsh_completion/"_envault").write output

    output = Utils.safe_popen_read("#{bin}/envault", "completion", "fish")
    (fish_completion/"envault.fish").write output
  end

  test do
    system "#{bin}/envault", "--version"
    assert_match "envault version", shell_output("#{bin}/envault --version")
  end
end
