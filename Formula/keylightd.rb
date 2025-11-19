# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.44"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_darwin_amd64.tar.gz"
      sha256 "d815782a94e85985be2654f94fbf4c65b01358c7aad2bcd345be53581fc568e0"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_darwin_amd64_sbom.spdx.json"
        sha256 "fd1e5a9bacc8ee3e87a6ed4fafd1654d2c181721987e22d7c2278337ccf0818a"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_darwin_arm64.tar.gz"
      sha256 "c85c8fb592c547d3c236686a0721903ec8bb9913f69d9bdcfcc1e4b4dc3a2ad0"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_darwin_arm64_sbom.spdx.json"
        sha256 "db074fcbfa2ce2e9eb01cbe15a4fb6ba84cdaaf6e771199281a8213c1f65be39"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_linux_amd64.tar.gz"
      sha256 "3cb22d4f93cdfe20ce77d4e3fe7e9c0db07ae65441c990b1818c2d0b3949437e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_linux_amd64_sbom.spdx.json"
        sha256 "fa60e11f0995624e991b33280695895e674340ac7cdad6cb5788f0410a407724"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_linux_arm64.tar.gz"
      sha256 "f757f91a70917a75b5892cc29fb89bde36bf665e494249bd2ce8b47907e47b92"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.44/keylightd_0.0.44_linux_arm64_sbom.spdx.json"
        sha256 "fbf50b00c4ef18eaca25a540899f3eb78625f766d026f07bdf4b911b5316715f"
      end
    end
  end

  def install
    bin.install "keylightd"
    bin.install "keylightctl"

    resource("sbom").stage do
      (share/"doc/keylightd").install Dir["*.spdx.json"].first => "sbom.spdx.json"
    end
  end

  service do
    run bin/"keylightd"
    keep_alive true
    restart_delay 5
    process_type :background
    run_type :immediate
  end

  test do
    system "#{bin}/keylightd", "-h"
    system "#{bin}/keylightctl", "version"
  end

  def caveats
    <<~EOS
      keylightd daemon has been installed!

      To start keylightd manually:
        keylightd

      To start automatically with Homebrew services:
        brew services start keylightd

      To stop the service:
        brew services stop keylightd

      To restart the service:
        brew services restart keylightd

      To check service status:
        brew services list | grep keylightd

      Once started, control your lights with:
        keylightctl light list
        keylightctl --help

      Configuration will be created at: ~/.config/keylightd/
      Service logs will be written to: $(brew --prefix)/var/log/keylightd.log
    EOS
  end
end
