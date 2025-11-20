# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.45"
  license "MIT"

  # macOS builds are not currently available due to a symbol conflict
  # between Wails and fyne.io/systray (duplicate AppDelegate).
  # See: https://github.com/wailsapp/wails/issues/3003
  # When this is resolved, uncomment the macOS sections below.
  #
  # on_macos do
  #   on_intel do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_darwin_amd64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_AMD64}}"
  #   end
  #   on_arm do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_darwin_arm64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_ARM64}}"
  #   end
  # end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_linux_amd64.tar.gz"
      sha256 "366a9ed9a2f0fad41bb17a2adcb44644cec5af52526fa7b873d76fffa6c37f26"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_linux_amd64_sbom.spdx.json"
        sha256 "4348afaaf04cd533aea7aa210c9b9e2dd3ccbca143f994da699b51d39db277ed"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_linux_arm64.tar.gz"
      sha256 "ffb4eb72803e024ddb1ab4b5955764e6932d81e334923f3bb691e81896febfe5"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.45/keylightd-tray_v0.0.45_linux_arm64_sbom.spdx.json"
        sha256 "9349a6c80f67ed3c1bdbe8c8bb635658bdb53a56da85e5f0166e38601bfa3c2d"
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
