# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.42"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_darwin_amd64.tar.gz"
      sha256 "a7b2731a4a98446bb45a98deabda981970547667f6d98e6fd03236bb0a8b141d"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_darwin_amd64_sbom.spdx.json"
        sha256 "63459ca114b7611afa7c6e90d0efe93a3f8b584d4748e6a79e72b9746b7fa2cf"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_darwin_arm64.tar.gz"
      sha256 "5c0360be3d96461cb1d27226bae7e5265a209dcf30b780956ba3429f83c71633"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_darwin_arm64_sbom.spdx.json"
        sha256 "ad11524b105b22b5fae03b9d9d15ece4cbb127f0e122fead6d3248c403f0d367"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_linux_amd64.tar.gz"
      sha256 "f9d712e29d09c6eed61237473ea14c07ea9f1c9592336c7fb83aa7835d751258"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_linux_amd64_sbom.spdx.json"
        sha256 "7ad5b26cf5927be530cda7e63f49f5ea357ab3edd4ea5f6aeebe237500b85bec"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_linux_arm64.tar.gz"
      sha256 "23046d73878879337e2ef818ebf38e3fc5c8ff1356c15a8d987f5bfee7fffb7c"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.42/keylightd_0.0.42_linux_arm64_sbom.spdx.json"
        sha256 "81eab130cce050f90be1b7ba6117384c755e227e305b28b7b0fe2efcbcb2ffca"
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
