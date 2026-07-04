# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_darwin_amd64.tar.gz"
      sha256 "9cb8d6057992ebeafb86a489186f82b828ec2d59df9880f71791a60319094991"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_darwin_amd64_sbom.spdx.json"
        sha256 "222fb640178d686e2cdb1aec74520f246aee9f828cc281c61123624f4cadfc5b"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_darwin_arm64.tar.gz"
      sha256 "b678f28b6e7ed0c67912890f2b08c8b0ab8bcec56dc6ec175ac20f6e2c7cf4e1"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_darwin_arm64_sbom.spdx.json"
        sha256 "8729a7cdccca7742375fbf0da3e55f20f2390a80e42c39ceca478476fed9ffc4"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_linux_amd64.tar.gz"
      sha256 "c59e6036e1f94b5db6b00bb8a0318e03ad429525cd8d775fb70735b0b5c02270"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_linux_amd64_sbom.spdx.json"
        sha256 "8b707f14fd9b355ad1d880070144cdf0fa7fd511ae10c22d15cf2b53422cac91"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_linux_arm64.tar.gz"
      sha256 "6f12f4cb329c914aa7ba21395e94512ea1c5babe4d6d926ecc049e7bf938c7bd"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd_0.1.8_linux_arm64_sbom.spdx.json"
        sha256 "cf45dc0dbd995f88eed5caeac40666f6dc76f4c3684582621213a94dfab53086"
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
