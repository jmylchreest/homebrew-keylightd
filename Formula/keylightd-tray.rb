# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.5"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_darwin_universal.tar.gz"
    sha256 "912afe29426c1f47cd8c4bf7bd27ac3084fc4faebaf644745e519c8df5b7cc3b"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_darwin_universal_sbom.spdx.json"
      sha256 "b38c08f220e495ab1bfc7cb7a9cd3fed7cd0a48a7d3086dbd526e77810261d27"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_linux_amd64.tar.gz"
      sha256 "197f5a8613215c551b1515de3ad3efa5ac9de86ceab34ed8498019ba6bbc61d5"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_linux_amd64_sbom.spdx.json"
        sha256 "78cb67266fa597b7ed11270ff942215ee461776539625f126237c19d88745f16"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_linux_arm64.tar.gz"
      sha256 "9194a272fff64cdd2292add5a69d52311192ded76991cd525c4895163975e149"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.5/keylightd-tray_0.1.5_linux_arm64_sbom.spdx.json"
        sha256 "6de60c92d51e28e4efc0702d9581ad29fa42c9d7ed29dd2872743d4e3934311f"
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
