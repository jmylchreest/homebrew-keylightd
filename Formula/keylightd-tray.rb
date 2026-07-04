# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.7"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_darwin_universal.tar.gz"
    sha256 "626f3bf1db1db7b24a1d0c80235f942191ec702208acc4fc30820b342dfc203d"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_darwin_universal_sbom.spdx.json"
      sha256 "f27d7245a8fb401536c237c92e01e5f341012d53af4dfca5a09e5297131229c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_linux_amd64.tar.gz"
      sha256 "00f5c08df9701d943c68e64630075fee07d156f85df6918000b667be1963e6e6"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_linux_amd64_sbom.spdx.json"
        sha256 "a8bc433c4e4c8e40a5a3097d0c36d9513d2108a4e44e86307377a499736e6faa"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_linux_arm64.tar.gz"
      sha256 "90fbefea3f16d2f20275e65f7a7759c131ddea4c2047e548af1521372fec7048"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd-tray_0.1.7_linux_arm64_sbom.spdx.json"
        sha256 "db7e8d5866bee38a653e13506d1ea5191859e1f4b5348ff6c1a92b9d47236fc2"
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
