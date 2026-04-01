# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_darwin_amd64.tar.gz"
      sha256 "e4c1c7db47456105a4f01ae0fa8057e3cc9efc7a3ba491871b099da6e3971a54"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_darwin_amd64_sbom.spdx.json"
        sha256 "025e0d9d9d93d4192e18def364dab617fdaf8df80f6c3e17d624046f39a47c32"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_darwin_arm64.tar.gz"
      sha256 "2772a504a0ff55d000b1aba4a03e43cf8339b9d03bb8e9a4164b45b81d5420d4"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_darwin_arm64_sbom.spdx.json"
        sha256 "f6be99692afb91bf99010ed3b8a4ef41a0f080fc8f9846a9cb0a0ac9f62f5f13"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_linux_amd64.tar.gz"
      sha256 "c2b6f19f1f6bb9a5dee9de81c733197332cd51fe2413abe458967d7b67301701"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_linux_amd64_sbom.spdx.json"
        sha256 "100bfba19abf09842df5dddebb51ec20cf3e399327ac0dc421226bb0a7400e28"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_linux_arm64.tar.gz"
      sha256 "9b69a1c489ea9427eec0b160daddc1bf8befc50ef6dccf5e08b3803177779b5e"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.4/keylightd_0.1.4_linux_arm64_sbom.spdx.json"
        sha256 "f761e41f10d8120d49b213f7c9c5ee5fabc8b403cf729e41287360b6a5533a0d"
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
