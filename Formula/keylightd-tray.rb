# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.48"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_darwin_universal.tar.gz"
    sha256 "e65152103b5ac92c3ef3c0c4af050d2911f91efacd347f50c532dd91f8494cf7"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_darwin_universal_sbom.spdx.json"
      sha256 "679c2b7a885dc6ad3d6c6fd3f017d3892b17abb556bcbfa432a2f814b182aeaf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_amd64.tar.gz"
      sha256 "60c1cce1a611e0bf7612eac1528942997672be2d056bbcc9b0d6d14ae2e679a8"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_amd64_sbom.spdx.json"
        sha256 "9abd83ca497e46281137954a7fde69ec8d4bc0de4c9c5a2f36fbf80fd2637a6b"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_arm64.tar.gz"
      sha256 "3495b102919957d3ca5df38dd83c444e10d627307508e64a2221f44fb87a1f89"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd-tray_0.0.48_linux_arm64_sbom.spdx.json"
        sha256 "2966eefe400cfbfb5328a0b0f534e12cf8fb11aaf2c419754728169c2d1f1fe7"
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
