# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.47"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_darwin_amd64.tar.gz"
      sha256 "3a6483f50fe16f4a2b4df8cceb9f697f90213af2437b441ab31868cda0493aae"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_darwin_amd64_sbom.spdx.json"
        sha256 "22f65adf88f097d6237a4bb221a5e9c60861a3024e74ef8825b17cd1fc6eed98"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_darwin_arm64.tar.gz"
      sha256 "103573c36381b5a70288b10c2586e603809bc0811ef2dca6e76dc65abc89bc5e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_darwin_arm64_sbom.spdx.json"
        sha256 "fbab2f0e3c5e8f71aeb5e00da889bb6167b62cea6d3bf8ef113c96cd78a89ec0"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_linux_amd64.tar.gz"
      sha256 "8e2b79cbe608a54b5cede0f482ed14bd6f321feec090f9c6b80f5dea33815440"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_linux_amd64_sbom.spdx.json"
        sha256 "6045a7330ffc3ad9b8b1b2969cefe136b15220b7f311ddaed4d7db4d3bcc58a2"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_linux_arm64.tar.gz"
      sha256 "b24a3146c83d27550607428f2f326454bdcd516424ac74858e7cd529d2a4c89e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd_0.0.47_linux_arm64_sbom.spdx.json"
        sha256 "748b28f71384d836822ad8f88ec26ec588dabd6f5d67652de1e7db050545a39b"
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
