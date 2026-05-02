# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_darwin_amd64.tar.gz"
      sha256 "706f804b6579ebf263e70bf8736119a7f832b72a2a5417566cdb0d4feea317a6"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_darwin_amd64_sbom.spdx.json"
        sha256 "a5d52099909241de473220de0d294c85cfa54da32e299bf2c5ba5e02571554f4"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_darwin_arm64.tar.gz"
      sha256 "faa4e0507f8028174c50e6871dc9b79ada34de3a2c5101948793a63a7893466c"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_darwin_arm64_sbom.spdx.json"
        sha256 "e02aea595b73ec5b8c315889a4bb7691844c7f7ad2d42059ad5d6ece8b6c62b0"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_linux_amd64.tar.gz"
      sha256 "37e39da0bffaee8f51104516d69fa6f3c892c58ed6d1f7c2c8b85e55132f22d9"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_linux_amd64_sbom.spdx.json"
        sha256 "dc0d95f577d773bf50ed7d0159778b9abe54d46e04e771f7d465c2fbe0579029"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_linux_arm64.tar.gz"
      sha256 "dc8b4770a884a3fbe09a565749997cbeeb651bfd29d7d7c944cbdebcad072a91"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd_0.1.5_linux_arm64_sbom.spdx.json"
        sha256 "7e3e02cdeffa017b53c18d2384d5a76638333cf08245168b898c1bfa563a6db1"
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
