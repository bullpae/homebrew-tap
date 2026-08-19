# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander-cli의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander-cli"
  version "0.15.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.1/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "b340ab4d0f2f050ced5f8413649dad0f65469dc7f8dcc5dacfe460d02fb80293"
    end
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.1/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "66c2e58dcdec2e1b61262f8955efd70ee25b8379d3cd1337af08d282f0749959"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.15.1/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa5bcfa4321d9ea2eac2cc8cf8fb61a0b07dd222a2e122a6bd566a25d190a66b"
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
