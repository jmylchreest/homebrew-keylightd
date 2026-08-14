# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_darwin_amd64.tar.gz"
      sha256 "3657634730db71cc34bbfedfe3cba96dfd50068435a901e542a229343b795f32"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_darwin_amd64_sbom.spdx.json"
        sha256 "f5dd8df1016729f56498609907ac71771f5cf98df3e1aa6bb78710859cdfa357"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_darwin_arm64.tar.gz"
      sha256 "18c2268bcd26c7f871f07dbebbf9423bf19ebfdd5ab6b5736f9bcc8067663300"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_darwin_arm64_sbom.spdx.json"
        sha256 "5ff783f1f0a2ce7c47b2836c9ad4b88642dea7ee9efc3bf14d5386eb3171ab54"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_linux_amd64.tar.gz"
      sha256 "44b37c2dca4556803818f209632dbeba6b54a34492d32c6cf6d9a665472a15bf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_linux_amd64_sbom.spdx.json"
        sha256 "430b49e9b6aab27effb81fa26d7e6de9c775b5f80f9c6969e359f74ea7cf156a"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_linux_arm64.tar.gz"
      sha256 "5be74405cb6552d773a6f2383e71c1ca2e5f3039f9dcdeb9049cd7ea3a2be653"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd_0.1.9_linux_arm64_sbom.spdx.json"
        sha256 "24d1bc5e247e2ca2592c5e3111a931dfe2b61d9ee63821cf05e182f7cf47ca77"
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
