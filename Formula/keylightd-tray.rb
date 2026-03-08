# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.49"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_darwin_universal.tar.gz"
    sha256 "a015016d6f4c20d23fcc2ebcf0215504f34a891e0da035b4d3a10e0180b99cdb"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_darwin_universal_sbom.spdx.json"
      sha256 "abe84a0b23eac52aaf7807d69437ff7e70552a44c8b7b669295d4d0b3c6c4160"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_linux_amd64.tar.gz"
      sha256 "a89b4219329048be4527e2963163f3610499a7af56e35bab01d19a63ab003db5"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_linux_amd64_sbom.spdx.json"
        sha256 "b9a4e35467a0c993c7581c981f7d63997e642a3d7ce3803cc882b221bfcd6232"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_linux_arm64.tar.gz"
      sha256 "8516f2038e74815b384e8d108e9bcc92bd69d6183015cb141676a43c5c53d38d"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd-tray_0.0.49_linux_arm64_sbom.spdx.json"
        sha256 "ffdd067b5a1097cb1aa7d00be7d8f050cd3da33dc612513240bd1183385475d0"
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
