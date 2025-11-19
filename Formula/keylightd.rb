# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.43"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_darwin_amd64.tar.gz"
      sha256 "5551893a56bba8a0c39727a3e1c15d31b9bcf06e763471595537790671c23978"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_darwin_amd64_sbom.spdx.json"
        sha256 "43c5956b9ef3929b2211d4020da98cdce318a445cd00f0885d0ab3559a664573"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_darwin_arm64.tar.gz"
      sha256 "681e36040e93aaf1303250d455a4cbc28bc73129cd54371a8a1b5a8a188405ff"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_darwin_arm64_sbom.spdx.json"
        sha256 "65acc93e8f2cc5aaf6790c06d208033e584bead81283380725453b3a5a392fee"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_linux_amd64.tar.gz"
      sha256 "0bf275b7c2ea3c35a729420892388749674d407fbc1a3cd49c4fe6eb052c7caf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_linux_amd64_sbom.spdx.json"
        sha256 "b58ae4088f5ed03b099e4afd0b79d68ccec5af3ad50e48d68575019b9447e3e8"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_linux_arm64.tar.gz"
      sha256 "c3f1f97202ed82e9d518982093097de92a7261edce174f7fb85ebdd869a441b6"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd_0.0.43_linux_arm64_sbom.spdx.json"
        sha256 "e2c3fc0afc76b8b9f8f3045edf51e3b407a35c2927b09a1296c945e81f81a36a"
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
