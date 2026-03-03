# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.48"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_amd64.tar.gz"
      sha256 "ea9bb5c930223db80e37eca46ce0548aeae2fe4c05806b964d3ddcf9aa49604d"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_amd64_sbom.spdx.json"
        sha256 "05a3d4786e40d2c7131c3b349f45c9f329e1b931f514171a2aa17c783539f86c"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_arm64.tar.gz"
      sha256 "cfa6d6d073fe08f9d82459f903bd841fc79299d01b11fa04c7d5185876acb791"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_darwin_arm64_sbom.spdx.json"
        sha256 "4e705135e0d05e8b6024bfb29340f1e9925a9048b30793475d40e6b8727555ef"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_amd64.tar.gz"
      sha256 "648269332935017731bba7b10606ae1c924cdb0382a23ddf999720c737d9027f"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_amd64_sbom.spdx.json"
        sha256 "31e48a56b61aa3ccdd625cfc88626444bc3638fad3a0ad092981c5f3c450c1b9"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_arm64.tar.gz"
      sha256 "5cb2131244573fd15ab1a0e2ceb4e2166239e56c0754a603960dea67df7075cf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.48/keylightd_0.0.48_linux_arm64_sbom.spdx.json"
        sha256 "3d6d9c400d7ab53c0b20cef7a543c21751dc91447631832a2a9f4ef2d0d58946"
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
