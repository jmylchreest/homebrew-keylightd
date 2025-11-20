# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.45"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_darwin_amd64.tar.gz"
      sha256 "740894bca1a68957f2372934049bdb49572b8d26b8b5813c70de8393be4e169c"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_darwin_amd64_sbom.spdx.json"
        sha256 "caf41a5beda0ef139f63d2a60b775225e604a863eb4e6cdc7b53d9cc25684999"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_darwin_arm64.tar.gz"
      sha256 "4463ae2fbd37bf215e38974825c2be592945ad92e25835de579c82ed6d57d290"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_darwin_arm64_sbom.spdx.json"
        sha256 "18a6bbc54af8a3e66100714000cb758d5dea7d3b038b7fc1ac407f65736d7d91"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_linux_amd64.tar.gz"
      sha256 "722229df740daa178a0e1047ce0ed09882a8f0e8cc3acd924fc15d6c0d4ba7b1"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_linux_amd64_sbom.spdx.json"
        sha256 "04f310e30f70dcd962c37fa6f78b1233fe401c162e4aa49b63721861c23430de"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_linux_arm64.tar.gz"
      sha256 "94e08f975ea6f469ea93c8d69eaec99a16b7d71cd1578b7f95ba4147291d5727"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd_0.0.45_linux_arm64_sbom.spdx.json"
        sha256 "dc3a7606d8b8867944e99555e67f2ad97ec50c2b3b5d946f3d02eb0698a69348"
      end
    end
  end

  def install
    bin.install "keylightd"
    bin.install "keylightctl"

    resource("sbom").stage do
      (share/"doc/keylightd").install Dir["*.spdx.json"].first => "sbom.spdx.json"
    end
  end

  service do
    run bin/"keylightd"
    keep_alive true
    restart_delay 5
    process_type :background
    run_type :immediate
  end

  test do
    system "#{bin}/keylightd", "-h"
    system "#{bin}/keylightctl", "version"
  end

  def caveats
    <<~EOS
      keylightd daemon has been installed!

      To start keylightd manually:
        keylightd

      To start automatically with Homebrew services:
        brew services start keylightd

      To stop the service:
        brew services stop keylightd

      To restart the service:
        brew services restart keylightd

      To check service status:
        brew services list | grep keylightd

      Once started, control your lights with:
        keylightctl light list
        keylightctl --help

      Configuration will be created at: ~/.config/keylightd/
      Service logs will be written to: $(brew --prefix)/var/log/keylightd.log
    EOS
  end
end
