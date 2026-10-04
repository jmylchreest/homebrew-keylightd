# typed: false
# frozen_string_literal: true

class KeylightdTray < Formula
  desc "System tray application for controlling Key Lights via keylightd"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.2.0"
  license "MIT"

  on_macos do
    url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_darwin_universal.tar.gz"
    sha256 "b019c8ee0a62f2b6272638e3dcce11cd4963e37d4ac4f1d7b157f830404df72d"

    resource "sbom" do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_darwin_universal_sbom.spdx.json"
      sha256 "812ea58ed460038c361f3273ef7ecd488e0f89ec6553ddf75517716a32f463d2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_linux_amd64.tar.gz"
      sha256 "54fec30dad78259757e37a7c177f529cb8e474276d951003864b6afd3ca14eaf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_linux_amd64_sbom.spdx.json"
        sha256 "ae9b6995ee40c590e3d90bbdfd48bb082322109db325a0162cf2f18bb913c173"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_linux_arm64.tar.gz"
      sha256 "3a3d83db1d008711f22b95c20f7ff13a9b010a92de27addca0339c138b157ecc"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.2.0/keylightd-tray_0.2.0_linux_arm64_sbom.spdx.json"
        sha256 "433188f214a71ba428ef12fea808f512d09e7fc3eabdb5e1615b92e51ce387e4"
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
