# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.9"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_darwin_universal.tar.gz"
    sha256 "a2593205070e6f28e6bc2193eb5a1bdda6e16dd640d039ae71ccb60d858d700a"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_darwin_universal_sbom.spdx.json"
      sha256 "9b83912e04c10048954a4a61bc2f1acc612a943230f36393830ca8b996521a87"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_linux_amd64.tar.gz"
      sha256 "ed890768e597322da3ad1de2f6320083bb2d90708fc303113ef28c8950ad1b37"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_linux_amd64_sbom.spdx.json"
        sha256 "9e59b9059d10a39dff3636684cff5c2fdf4410cc97065daa00f3352cd380619a"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_linux_arm64.tar.gz"
      sha256 "82dcc98418550e2a7eeddc839e9cdad270e0fd4ebe648be32f18c072b6b3beb2"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.9/keylightd-tray_0.1.9_linux_arm64_sbom.spdx.json"
        sha256 "355f80507050098ddda6a1bcf5465c0905a6373485a898bc55ce94f4c4aa3511"
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
