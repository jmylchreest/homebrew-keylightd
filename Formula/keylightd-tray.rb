# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.47"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_darwin_universal.tar.gz"
    sha256 "a48a1e55836e6277fa2cd66ea7155aa857cf2a36900804ec1a517569b6cdabdc"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_darwin_universal_sbom.spdx.json"
      sha256 "a4365b2eb31b6e2b4c21afc8d4f283e227af51f61e91da5be092711bbe1495c0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_linux_amd64.tar.gz"
      sha256 "3291466d5fae4b6abba0ff4d34425bbc0069fed39b5cdddeb6f9e04e4203c558"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_linux_amd64_sbom.spdx.json"
        sha256 "e340fbae2595b272f2efc218acebee7028c7299261f2ff2d861fd887cd81f754"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_linux_arm64.tar.gz"
      sha256 "5764062c946b29039c0f1eaa542b25b737d97bce899f66bc04e0994dc90de261"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.47/keylightd-tray_v0.0.47_linux_arm64_sbom.spdx.json"
        sha256 "98049ae5c9006f21e42b307131b43dc614e9be12dc6258d217f0283576e05681"
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
