# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.4"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_darwin_universal.tar.gz"
    sha256 "24c92e7de195d9d7498eb269586fcbe2499da68af9583d1da0a0907ab442459e"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_darwin_universal_sbom.spdx.json"
      sha256 "2c4f34a624be6e9427753f4e75ddf908cf0f4474bce0b7dbe41f17ec6033e992"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_linux_amd64.tar.gz"
      sha256 "a464c936fb85c7dffc2f6f30e386ebcc036952045637c2896f8c2d4daa36d157"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_linux_amd64_sbom.spdx.json"
        sha256 "a1e81c7576beb6320eb49853d16a2fb54aee2b1e9cb596c43664f920791ca816"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_linux_arm64.tar.gz"
      sha256 "d590c736a10606b2cdc8d0384099da57b0d4711e0d0535c15163fb935fec62e1"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd-tray_0.1.4_linux_arm64_sbom.spdx.json"
        sha256 "ef76b784eeca7252147bc979ad714886ad84305b79f14c4100f12d81da756723"
      end
    end
  end

  on_linux do
    depends_on "gtk+3"
    depends_on "webkit2gtk"
  end

  def install
    if OS.mac?
      prefix.install "keylightd-tray.app"
      bin.write_exec_script "#{prefix}/keylightd-tray.app/Contents/MacOS/keylightd-tray"
    else
      bin.install "keylightd-tray"
    end

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
    EOS
  end
end
