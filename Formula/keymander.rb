# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander-cli의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander-cli"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.14.0/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "665d8308c26882c4fd30bcc9edc35086b8c47c44dd73310e7ffb7c6dc002254b"
    end
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.14.0/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "8a0a2b49f1061769eaaab70ba109dbdba920ab125521c524581fdfbcf8ac9364"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.14.0/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7609d7f9b03c2fa292aed97cda98a1d6cb7153d49805611ad6b4908fe5c55316"
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
