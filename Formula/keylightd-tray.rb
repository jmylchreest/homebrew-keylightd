# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.43"
  license "MIT"

  # macOS builds are not currently available due to a symbol conflict
  # between Wails and fyne.io/systray (duplicate AppDelegate).
  # See: https://github.com/wailsapp/wails/issues/3003
  # When this is resolved, uncomment the macOS sections below.
  #
  # on_macos do
  #   on_intel do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_darwin_amd64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_AMD64}}"
  #   end
  #   on_arm do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_darwin_arm64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_ARM64}}"
  #   end
  # end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_linux_amd64.tar.gz"
      sha256 "5c123af75564110a020c6ae9343a7e65df2862d3f15050b3e66bc8067c295388"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_linux_amd64_sbom.spdx.json"
        sha256 "d9a0164b8618af76e1856dd1d9ea8660db4d9e016fd44457eac94f69c2aeef73"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_linux_arm64.tar.gz"
      sha256 "fe68b9787ace4cd5964c645cefeba0d08aabf6795e6e13a8d6c81956cb541352"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.43/keylightd-tray_v0.0.43_linux_arm64_sbom.spdx.json"
        sha256 "fb26772223608dc61f12dbf3760a76d5c97c0dd887f005cf045d08775b41f1fc"
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
