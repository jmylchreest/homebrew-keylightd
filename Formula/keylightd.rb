# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_darwin_amd64.tar.gz"
      sha256 "33bf436c356fdcfa94d126ee4a39e822604e8419d08615456318b6a30cd28081"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_darwin_amd64_sbom.spdx.json"
        sha256 "f59479e27f7f2467cce5123cbf81eb404b91c0524902211f76d5f37104ee5958"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_darwin_arm64.tar.gz"
      sha256 "0dc3b7d1a9bc39bcd1af54af9a21f3915e22f1b45adf966a3d6e0b40bb2600ad"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_darwin_arm64_sbom.spdx.json"
        sha256 "4380ea11dcd19aa7cdddcff1e92bbe358c3145ed20f323c771b886d1164f7fd9"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_linux_amd64.tar.gz"
      sha256 "f373f4b291174b9b32caad0fa33da67513e3480c8bd960668d907def03cb32eb"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_linux_amd64_sbom.spdx.json"
        sha256 "0f9b5e1e7c784c998ff21628cc40f2de90a1bea559ce83bc018e8e1920307641"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_linux_arm64.tar.gz"
      sha256 "8b84271253d2d0c08612a09eae224a33bce25445712ff9b185e85a024ff18e89"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd_0.2.0_linux_arm64_sbom.spdx.json"
        sha256 "45bace658271b6a955afbabeab30506ab9b93798f317e6df83b7241186e514a9"
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
