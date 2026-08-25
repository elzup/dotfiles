# この PC の主要リポジトリ

この Mac の環境・運用を支える自作リポジトリの一覧。すべて `~/.ghq/github.com/elzup/` 配下
(dotfiles のみ `~/dotfiles`)。

## 主

| repo | パス | remote | 役割 |
| --- | --- | --- | --- |
| `dotfiles` | `~/dotfiles` | `elzup/dotfiles` | シェル・git・エディタ等の設定本体。ここ |
| `agent-setup` | `~/.ghq/github.com/elzup/agent-setup` | `elzup/agent-setup` | **事前** — 全 agent (ccka) 共通の rules / skills を全端末に配る。`rules/` と `skills/` が super global |
| `forge` | `~/.ghq/github.com/elzup/forge` | (ローカルのみ) | **常時** — マシンと外部環境を 1 分周期で計測し続ける工房。現状は README の設計方針のみで実装なし |
| `quota` | `~/.ghq/github.com/elzup/quota` | `elzup/quota` | 捨てられる直前の Claude / Codex クォータを検知して創作生成に焚き、ライブラリとして貯める (5% は常に残す) |
| `pc-help-report` | `~/.ghq/github.com/elzup/pc-help-report` | (ローカルのみ) | **事後** — PC / 周辺機器 / Agent × マシンのトラブル事後レポート。旧 `machine-report` + `pc-help` を 2026-08-24 に統合 |
| `daily-report-ai` | `~/.ghq/github.com/elzup/daily-report-ai` | `elzup/daily-report-ai` | `.ghq` 配下の活動を毎日 0:00 に収集し、Claude Code CLI で分析した日報を生成・push |

## サブ

| repo | パス | remote | 役割 |
| --- | --- | --- | --- |
| `shprof` | `~/.ghq/github.com/elzup/shprof` | (ローカルのみ) | zsh / bash の起動が遅いとき、どの行が何 ms 使っているかを出す |

## 時間軸での役割分担

`forge` の README が定義している関係。

| repo | 時間軸 | 役割 |
| --- | --- | --- |
| `agent-setup` | 事前 | 設定・ルール・skill を全端末に**配る** |
| `forge` | 常時 | マシンと外部環境の状態を**測り続ける** |
| `pc-help-report` | 事後 | 起きたトラブルを**記録・分析する** |

## メモ

- `forge` / `pc-help-report` / `shprof` は remote 未設定 (このマシンにしか無い)。消えたら復旧できない。
- `pc-help-report` が記録 (prose) 側、挙動の再現・検証テストは別リポジトリ `elzup/git-doctor` が担う。
