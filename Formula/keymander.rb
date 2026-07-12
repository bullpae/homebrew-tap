# 자동 생성 파일 — 직접 수정하지 마세요.
# keymander-cli의 scripts/gen-homebrew-formula.sh가 릴리스마다 갱신합니다.
class Keymander < Formula
  desc "Keyboard-driven cross-platform launcher (TUI + desktop + key-remap daemon)"
  homepage "https://github.com/bullpae/keymander-cli"
  version "0.9.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.9.3/keymander-portable-aarch64-apple-darwin.tar.gz"
      sha256 "d5656c84cd5e16b6357af28921bb1694bf97893b4ff96f1bceb4195421c632d2"
    end
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.9.3/keymander-portable-x86_64-apple-darwin.tar.gz"
      sha256 "a0a9235111049b27c40c4968f972ce4291a85dd0ddd2db4855d7400edaad5336"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/bullpae/keymander-cli/releases/download/v0.9.3/keymander-portable-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c510a5a42d3c3718c44ecc5330b776a72c5f90c9c26d18b4229a6e1d565c3434"
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
