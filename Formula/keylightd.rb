# typed: false
# frozen_string_literal: true

class Keylightd < Formula
  desc "Daemon and CLI tool for managing HTTP-based Key Lights, including Elgato models"
  homepage "https://github.com/jmylchreest/keylightd"
  version "0.0.49"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_darwin_amd64.tar.gz"
      sha256 "01a0378c5d17b1ad957aa6e51880bfa42587da98da98ecb76c43e5bab06e09e2"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_darwin_amd64_sbom.spdx.json"
        sha256 "c5f9e996bbe5edd2cdf98c88604d20d0e25b262abbf61afa47d6db0a2ce6dddb"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_darwin_arm64.tar.gz"
      sha256 "10408bf44218cfd38580d22755665e8d8245b658a948ed048553ec3bd34daa67"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_darwin_arm64_sbom.spdx.json"
        sha256 "f0a6cfda7ebfb9788d1702f5d91ed729ce2c62508cf8dd2320983e67b5bc7812"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_linux_amd64.tar.gz"
      sha256 "75682a8de2666dbeb08880afc78594338af712d8eaa1b9105ce5c505b043fe50"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_linux_amd64_sbom.spdx.json"
        sha256 "bc5da3ed6ff776d1deb70f21b4514408cfbc7bdc3251c737fa3f54e96df1b768"
      end
    end
    on_arm do
      url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_linux_arm64.tar.gz"
      sha256 "f32c156cd759075bf16eafb34698320174481877d7f60e197582111434fb204b"

      resource "sbom" do
        url "https://github.com/jmylchreest/keylightd/releases/download/v0.0.49/keylightd_0.0.49_linux_arm64_sbom.spdx.json"
        sha256 "d5f0608e488087c39c0caf4a0725dbb337ebc4372c6922bce8abe9b5b9bbdad9"
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
