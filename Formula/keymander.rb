# 자동 생성 파일 — 직접 수정하지 마세요.
# bullpae/keymander의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander"
  version "0.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander/releases/download/v0.17.0/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "ab6fc06d1e0e511a2e7e21b9d14f1ef7d972eb149a03526106e1c3185275d6ed"
    end
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.17.0/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "bb37b424cd3ed2079fb75b9403c949cb3d50c806398d37b574c47342c0abb775"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander/releases/download/v0.17.0/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a078189e8fcf9dc9a27157590dcc0200a284434d78289cead17d55a87394f0c0"
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
