# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.42"
  license "MIT"

  # macOS builds are not currently available due to a symbol conflict
  # between Wails and fyne.io/systray (duplicate AppDelegate).
  # See: https://github.com/wailsapp/wails/issues/3003
  # When this is resolved, uncomment the macOS sections below.
  #
  # on_macos do
  #   on_intel do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_darwin_amd64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_AMD64}}"
  #   end
  #   on_arm do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_darwin_arm64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_ARM64}}"
  #   end
  # end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_linux_amd64.tar.gz"
      sha256 "7a7066bdb4267792d9f663d9382737faeab3512563bc00cd155774240509e3e1"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_linux_amd64_sbom.spdx.json"
        sha256 "367f6f9f4a5c1385989bf652b5bc912c214d5e2444fcd62800cda2078989e22b"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_linux_arm64.tar.gz"
      sha256 "4f6b7ebfcf230318320580b217c164fce4f066fcc2a40fd46dac212b74dfd4ce"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd-tray_v0.0.42_linux_arm64_sbom.spdx.json"
        sha256 "9c77052c1214d1030214f9ece407f3f5c13a6e34ff0b46b9589dbaeecf22e7eb"
      end
    end
  end

  depends_on "gtk+3"
  depends_on "webkit2gtk"

  def install
    bin.install "keylightd-tray"

    resource("sbom").stage do
      (share/"doc/keylightd-tray").install Dir["*.spdx.json"].first => "sbom.spdx.json"
    end
  end

  test do
    system "#{bin}/keylightd-tray", "--version"
  end

  def caveats
    <<~EOS
      keylightd-tray has been installed!

      This is a system tray application for controlling Key Lights.
      It requires keylightd to be running.

      To start:
        keylightd-tray

      Note: macOS support is not currently available due to a build conflict.
      See: https://github.com/wailsapp/wails/issues/3003
    EOS
  end
end
