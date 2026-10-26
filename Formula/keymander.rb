# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander"
  version "0.18.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander/releases/download/v0.18.1/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "cffca09a728ac3475bff7d04e087453ac9a1a27d5b0338d6733c6fe4218674b6"
    end
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.18.1/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "dc64af86333c1eeff6543d56a6935271132f6ffcc1ae704c257d9d45fe0de1ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.18.1/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87aa4e28a0bef389dfb0228a9cb378954c05821bb4f48cdc8025f09a2385d458"
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
