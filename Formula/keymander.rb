# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander-cli의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander-cli"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.0/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "e49db9a60e8f943cae6013fbbf6bba901b97ff60e25f3b041ffad49df1df6bd9"
    end
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.0/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "bf3cbe2f9c726d216764d150239c0156263a5d0a4597ab81fbdcce14c95c4b81"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.0/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1301ac06d9ac05915416886eda9de629c05b064a239431a50bd1d27a41533d6b"
    end
  end

  def install
    bin.install "kmd", "kmd-desktop", "kmd-daemon"
    pkgshare.install "kmd-data/config.toml" => "config.example.toml"
  end

  def caveats
    config_dir = OS.mac? ? "~/Library/Application Support/kmd" : "~/.config/kmd"
    <<~TEXT
      기본 설정으로 바로 동작합니다. 번들 예시 설정에서 시작하려면:
        mkdir -p "#{config_dir}"
        cp "#{opt_pkgshare}/config.example.toml" "#{config_dir}/config.toml"

      키 리맵 데몬을 쓰려면: kmd daemon start
      macOS에서는 시스템 설정 → 개인정보 보호 및 보안에서
      손쉬운 사용/입력 모니터링 권한을 kmd-daemon에 허용해야 합니다.
    TEXT
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kmd --version")
  end
end
