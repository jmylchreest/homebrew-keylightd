# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.46"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_darwin_universal.tar.gz"
    sha256 "7c77debbf3e273e80849da062d93de21c36e97a6a69c81cda05d1f3485d1a044"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_darwin_universal_sbom.spdx.json"
      sha256 "a04f9221f474fa9a209fd2f9f88163504db1203ccc7b418ec6644bdc45f64f05"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_linux_amd64.tar.gz"
      sha256 "69e0965544be6072dcc3cbadd51b8d328744f4739838c5d825eeea5fb0388e12"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_linux_amd64_sbom.spdx.json"
        sha256 "0e0a2f2a89a4cac6ca04d872b776818e47273c59504a725ef5f7551578667fd0"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_linux_arm64.tar.gz"
      sha256 "b93c1fcf5972ff7e058a02e89715a9f66e59b307e738a43dcb6609cec59ea543"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd-tray_v0.0.46_linux_arm64_sbom.spdx.json"
        sha256 "979913478262f6ac74f89e24195556c22ed95ddc100ba1ba3850c6f71fa63ee1"
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
