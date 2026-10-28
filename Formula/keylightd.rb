# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_darwin_amd64.tar.gz"
      sha256 "22bf1ca1b66cca944a89305906cce9b054561a200fe85ad71934bd804cae2ffe"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_darwin_amd64_sbom.spdx.json"
        sha256 "fcf174d6946090ac4b327e45ddad24a0c14e4fb6652a6b5d90f5206a31960ff2"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_darwin_arm64.tar.gz"
      sha256 "41da12925252a92179368bc1ff5eb67b338033e50aace1df3655759a079e2f35"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_darwin_arm64_sbom.spdx.json"
        sha256 "7044e5fcea0222f470643d8aae00da0413a05d2b48747fa99c30786c76131ad5"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_linux_amd64.tar.gz"
      sha256 "d40fdc18217cfc69cea3a915245bb02592a15d5b60708aec47c31cc53c581754"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_linux_amd64_sbom.spdx.json"
        sha256 "9c96614ce6df0ddee07e3ecde6ac911a19f03718b648a42232c424c167d886ac"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_linux_arm64.tar.gz"
      sha256 "0271ed28ace038d7e1df49df36c7c57f15234508e5ec5df7cb0eb977140d70e8"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd_0.2.1_linux_arm64_sbom.spdx.json"
        sha256 "8b25cb5cdb8515b07381f2ce351418db4441c197a655f40d7794f0142222cac1"
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
