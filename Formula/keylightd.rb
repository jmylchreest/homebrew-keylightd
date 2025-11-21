# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.46"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_darwin_amd64.tar.gz"
      sha256 "80cef166219fbfc500b1009104b03f388498c7980a18137443206ea095c2f874"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_darwin_amd64_sbom.spdx.json"
        sha256 "0d6937b60850935205aa19bee6959a0d9c6605b291e23f9fb13b53d0f1e520a6"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_darwin_arm64.tar.gz"
      sha256 "db9d5762ebae25bdfb6a97f31edc4d9b2db6f5d1bac5e0659e96b5b0f1318803"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_darwin_arm64_sbom.spdx.json"
        sha256 "48bef93dcb9a65d9d9173e33c0377b270a392c04261de059a9a44c7c182a2c29"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_linux_amd64.tar.gz"
      sha256 "8b19170920996bbc508c08ba8d14f20507057c809577bdb6db6cd32651701e7c"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_linux_amd64_sbom.spdx.json"
        sha256 "9a8ff2b82c683fb3b1cb5f1819c54f86935c80159d7dbe32f9de410b49e9ef75"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_linux_arm64.tar.gz"
      sha256 "815a5c722c96563e4fffecea01f5738c722d515d4c11274a720ca17646743268"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.46/keylightd_0.0.46_linux_arm64_sbom.spdx.json"
        sha256 "cc2f9d8293a67d2e5fbfae40f17bfb6bccfb8d8e47c89d70d5da22a961fd4cce"
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
