# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.48"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_darwin_universal.tar.gz"
    sha256 "0088bc56b4e9c74976783abe23977b5a006e9fcf55fcdd3bb1d89d1162d6136e"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_darwin_universal_sbom.spdx.json"
      sha256 "5c97c2f94904dcc9de648da142cf8bce6a0f7a7a2594773a043522f1651d7e4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_amd64.tar.gz"
      sha256 "d05ff1f2d785e83476716e2eb00b818239ed76a6380fd27f8be9ace1e475c4ca"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_amd64_sbom.spdx.json"
        sha256 "efc98cc001607ade10c6eb022ae316e9f9e1c5e600532e39f85b361eddd1374f"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_arm64.tar.gz"
      sha256 "b19885059f7d44776aa03f6767bce7ae90068786e89b15755d24cc180b29571a"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_arm64_sbom.spdx.json"
        sha256 "6ee877354561ee122a0bfee260fe943a702f7f15d9c6294ab1010af45cb9f09c"
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
