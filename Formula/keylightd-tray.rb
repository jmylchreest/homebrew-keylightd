# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.6"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_darwin_universal.tar.gz"
    sha256 "8f5ed1b5964eeec133df55b4d05f93f1797346cad9b09e1099f077a1c16070db"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_darwin_universal_sbom.spdx.json"
      sha256 "6cbe4399d8a3ede1dd5ba10d5bf82abef3292fe989d4a7b000e89f4617fea02c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_linux_amd64.tar.gz"
      sha256 "a28c4243e961036120da280a1c9f064ef8d3d731a009da83d850b7c40f822eb6"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_linux_amd64_sbom.spdx.json"
        sha256 "0cc0e3085e4f6f8982dc59915c1e7e4702128bef4f41908842e3174ccc7b7e88"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_linux_arm64.tar.gz"
      sha256 "96be7a5e1300bd10cd87bdd9586d3d3f4c5b684de650a5e538a1dd02a6cd105d"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd-tray_0.1.6_linux_arm64_sbom.spdx.json"
        sha256 "f3aae9c4ae0e0fc842c670e9039255c01cca1a71b47af78a456f7dfadd17ecc8"
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
