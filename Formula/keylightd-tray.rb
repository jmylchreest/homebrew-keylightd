# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.3"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_darwin_universal.tar.gz"
    sha256 "f719676120c086e84726bd2c7c577f758674d161798d46baec99b4b8791dd9b0"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_darwin_universal_sbom.spdx.json"
      sha256 "898a5bb01af0abe3873d7a705ff9eeb81700e43aa2a02738be7a48c825baad28"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_linux_amd64.tar.gz"
      sha256 "5144a1fc660f361d79fbe093f0f17181668a5ae5da6be91679ac5297b7c04e87"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_linux_amd64_sbom.spdx.json"
        sha256 "09ac0f5855946e51cd7143c8ee9a99ebf250441ffe1a6adeeb22ef399de402eb"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_linux_arm64.tar.gz"
      sha256 "537fa66602755d3f40e0efa8df29ea498f8775dabf8fed5f93d9ee5fbd51f555"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd-tray_0.1.3_linux_arm64_sbom.spdx.json"
        sha256 "86587f1924e31d899abaa197f63aa571f406b156a923cc9199f2529e517613e1"
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
