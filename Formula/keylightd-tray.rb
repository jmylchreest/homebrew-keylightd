# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.2.1"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_darwin_universal.tar.gz"
    sha256 "efe49d0a063d8f6a9d9b33e5b0918f3fa99d21cfb78934f86857f613d4787ad9"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_darwin_universal_sbom.spdx.json"
      sha256 "21922d2fca3fc5a357b698fa4224b114cf3d5f6781c370a3639c8a534f3ad431"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_linux_amd64.tar.gz"
      sha256 "ecf14571587166143e1b9db77828e75b0db08e9272b83e0c06a0fe3a9ab40be5"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_linux_amd64_sbom.spdx.json"
        sha256 "3aaf944f0aa7a18a3d390725e1f874e53773b42a3b052222c9249193c1bc60cc"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_linux_arm64.tar.gz"
      sha256 "8c56b9557cb260939eb15e5013039759c6616660299c6e717d3fc9a604d2842e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.1/keylightd-tray_0.2.1_linux_arm64_sbom.spdx.json"
        sha256 "872d24061546b425f8b9f8070613ddd866a390e6dcbbce60f797cdcaa529c8e1"
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
