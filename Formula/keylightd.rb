# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_darwin_amd64.tar.gz"
      sha256 "de8632ec032aed5c5a47da2162bf81462bda3603a73fcfa1e2434f8b947fd0dd"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_darwin_amd64_sbom.spdx.json"
        sha256 "9d2b33f7dfdfce62e14392903d34471f7842e169ef5735d4ea9e2912b4729c00"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_darwin_arm64.tar.gz"
      sha256 "c7a18a9383081d65209b1aa959491b1d8bccade813cfcb7291ae9a47df3081d3"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_darwin_arm64_sbom.spdx.json"
        sha256 "4994a1b7471c374ab05a18f02283539bf6203aca0464c167b6eff4d62bd79fd6"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_linux_amd64.tar.gz"
      sha256 "478a8ba2bb458e0448b4625b18b720332971cbce64732337f3da9f0e476dda72"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_linux_amd64_sbom.spdx.json"
        sha256 "726013717ad88c7f15bd15e5bcee5cd4f2042784f485db744143f033f0bd42c4"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_linux_arm64.tar.gz"
      sha256 "cec37c5bc36d28a33e1b5c51ddbc3410ebd3a5d0d53fe4fc8d481cd36cbd0eeb"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.1.3/keylightd_0.1.3_linux_arm64_sbom.spdx.json"
        sha256 "45ee01dcd5935851bebb6665455c10719efd6863e19b0ca3efbecd12e7b672c4"
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
