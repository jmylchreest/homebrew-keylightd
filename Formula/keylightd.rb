# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_darwin_amd64.tar.gz"
      sha256 "0080d81554f30d45ad402097198885d9fe9c74e8270150157a4f78546df001cf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_darwin_amd64_sbom.spdx.json"
        sha256 "1e4fa5fa54afc5285a78ff17237b73595b34c16a6b88b62a4ac38e063b24c2f2"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_darwin_arm64.tar.gz"
      sha256 "f738508873fe821c350892a193feb146e3ae298c8645f5c7285dec8ac75dba7c"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_darwin_arm64_sbom.spdx.json"
        sha256 "c408bea54f010d01b52e38c89fa1d8891ae6fa1f5678616b048336b4e3646d8f"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_linux_amd64.tar.gz"
      sha256 "e9a09a3e4c49952d37553354e5471f8d7579ed33ca8df95b28ca4292bac92b6a"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_linux_amd64_sbom.spdx.json"
        sha256 "43104483fde51cf73ef92dc405e493dde2a80dc76bfac5430ab35c298572d9a9"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_linux_arm64.tar.gz"
      sha256 "6b49832f7ecba4b6c2516fffad2784bb26f0a6f1cffd606cd9fa7655fc6c35bf"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.7/keylightd_0.1.7_linux_arm64_sbom.spdx.json"
        sha256 "77e79429bd8f64f26ac82db212fe88aa51a90e692c291e6b5d9ed9f3764da6c8"
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
