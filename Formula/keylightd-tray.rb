# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.44"
  license "MIT"

  # macOS builds are not currently available due to a symbol conflict
  # between Wails and fyne.io/systray (duplicate AppDelegate).
  # See: https://github.com/wailsapp/wails/issues/3003
  # When this is resolved, uncomment the macOS sections below.
  #
  # on_macos do
  #   on_intel do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_darwin_amd64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_AMD64}}"
  #   end
  #   on_arm do
  #     url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_darwin_arm64.tar.gz"
  #     sha256 "{{SHA256_DARWIN_ARM64}}"
  #   end
  # end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_linux_amd64.tar.gz"
      sha256 "c2e71111984de5a4eed2d337d0fbbc72b9bf4de71401a39380e833c43dc14c51"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_linux_amd64_sbom.spdx.json"
        sha256 "2d1684d94a899454517dd737ed49e05f4ff0257127b6dedb9bccac132ab36ddf"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_linux_arm64.tar.gz"
      sha256 "566939b4f567d44beefec30a39c09838f25c7b4d30e130f982a2e7858e9e5388"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd-tray_v0.0.44_linux_arm64_sbom.spdx.json"
        sha256 "a153782e41deb7d88f0b27bc253689a84e40b0b73866a4fa3a8f5fe53db7f9a5"
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
