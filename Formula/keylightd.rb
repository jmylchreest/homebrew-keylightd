# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.48"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_amd64.tar.gz"
      sha256 "26b8f4bb3c52e89d2ca0dd472acfbec3a42cbb5782d0d3cf003f3b2a57d08d36"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_amd64_sbom.spdx.json"
        sha256 "c4602ad7438936c94cbefdd2d08512699c230e00f276f6608bd0346582a03474"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_arm64.tar.gz"
      sha256 "68220f2417539ec4fda67ebd1227cf27ca1df6111f2aeb793bbb0cc800f38db0"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_arm64_sbom.spdx.json"
        sha256 "e47c93b49d7b411c4ad0379d5fc70cc816b491e6d99d8d53ff90e360354ab7be"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_amd64.tar.gz"
      sha256 "73572365aa23c6f20a4f19c934271c8dd0fc8f640600a1f576efe2db34f73e5e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_amd64_sbom.spdx.json"
        sha256 "335e6d5be2bfd0fa72c30e3b78729f427218720f7b888b3397cb6f7f1a4a8b4e"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_arm64.tar.gz"
      sha256 "5ead29d45b0b3220cafa0cdec1b114bfcf66dd45f7e7a1f89b533e3080bba9f2"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_arm64_sbom.spdx.json"
        sha256 "8fb8465e133084f226eb91d1cbc5010d35e9c652684784fa1ed9b3d6b0cbe5b6"
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
