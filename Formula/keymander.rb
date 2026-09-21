# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander"
  version "0.16.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander/releases/download/v0.16.7/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "6afb9ee086adb26dda91abea0dcf038ec79d437c33115f5c01181a9082735c54"
    end
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.16.7/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "df0954f0f905e6c99af088d38f69ad03aec5d15cfb55a2015b6ae8507f6fd5e6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.16.7/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b97b3104ce0650a35d83ebca5800e2e11105daf523dec0267c32d371df4576d"
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
