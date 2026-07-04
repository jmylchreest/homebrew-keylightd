# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.8"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_darwin_universal.tar.gz"
    sha256 "7fcd3a32edc940a7885cae74d21f1fa74672bf00b308e8e1bd7406a65dd5a420"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_darwin_universal_sbom.spdx.json"
      sha256 "209ef6defad2268a30f43f2ae630a6f45a629bf58209554620fb73a5843df7e5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_linux_amd64.tar.gz"
      sha256 "381028e8172e7d6b609ee2e2200480175dcf9f6c9ed5355d4db773323e538f05"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_linux_amd64_sbom.spdx.json"
        sha256 "d066f717f478271198aba4d029c25093772331c7f0c95acc955e9862effccf7f"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_linux_arm64.tar.gz"
      sha256 "9818d5817d854909bd7b3e847b52075e1e1addd63af2e93d08814b2e2cc0c867"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.8/keylightd-tray_0.1.8_linux_arm64_sbom.spdx.json"
        sha256 "eafc42b04e7ee8b75459beeae3150a295710b802cbdd2e99c78d3ef60e86cf5e"
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
