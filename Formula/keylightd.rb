# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_darwin_amd64.tar.gz"
      sha256 "ffc47614233fe6016ad3df4b1a2117dedd2d6b6ab57f3c0b7e915dcefac54dee"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_darwin_amd64_sbom.spdx.json"
        sha256 "170d7ea69eb975caa28a439606832374fde58f81d47a6d28ccb1f44b738c08bd"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_darwin_arm64.tar.gz"
      sha256 "70029dd9c056b47f3ad393881815fbe729844b683100ff456c71fa2119f58dee"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_darwin_arm64_sbom.spdx.json"
        sha256 "4d54363296f461ba43938b2347a17891b39feca492a3185770cd4ab394e41f26"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_linux_amd64.tar.gz"
      sha256 "de3e62e09518e44a3e83f254239e8bec3e83a0b5c77cf7681e9795067a12b944"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_linux_amd64_sbom.spdx.json"
        sha256 "3ccf55d6a7d2e2bf54a05bf0683ee3405c3259844a1e9460ce3bdebc24d84bdd"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_linux_arm64.tar.gz"
      sha256 "d96afe183d65a7a0587096f1733489c6b17f41601e145506513874aa9de19427"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.6/keylightd_0.1.6_linux_arm64_sbom.spdx.json"
        sha256 "dd82c2f354b12119c6892cdc398fc6ac2f36261649e87a7432d69ffb5820987e"
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
