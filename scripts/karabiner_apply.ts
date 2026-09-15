// dotfiles/.config/karabiner/rules/*.json のルールを karabiner.json の選択中プロファイルへ反映する。
// karabiner.json 自体を symlink にしないのは、Karabiner が GUI 操作で実ファイルを書き換え
// symlink を壊すうえ、手作りのかな配列ルール (数 MB) を dotfiles に抱えたくないため。
// 使い方: node ~/dotfiles/scripts/karabiner_apply.ts
import { copyFileSync, readdirSync, readFileSync, writeFileSync } from 'node:fs'
import { homedir } from 'node:os'
import { join } from 'node:path'

type Rule = { description: string; manipulators: unknown[] }
type Profile = { name: string; selected?: boolean; complex_modifications?: { rules?: Rule[] } }
type KarabinerConfig = { profiles: Profile[] }

// この prefix を持つルールは dotfiles 管理下とみなし、毎回まるごと置き換える
const MANAGED_PREFIX = 'dotfiles: '
const RULES_DIR = join(import.meta.dirname, '..', '.config', 'karabiner', 'rules')
const CONFIG_PATH = join(homedir(), '.config', 'karabiner', 'karabiner.json')

const loadManagedRules = (): Rule[] => {
  const files = readdirSync(RULES_DIR).filter((f) => f.endsWith('.json')).sort()
  const rules = files.flatMap((f) => JSON.parse(readFileSync(join(RULES_DIR, f), 'utf8')).rules as Rule[])
  const unprefixed = rules.filter((r) => !r.description.startsWith(MANAGED_PREFIX))
  if (unprefixed.length > 0) {
    throw new Error(`description は "${MANAGED_PREFIX}" で始めてください: ${unprefixed.map((r) => r.description).join(', ')}`)
  }
  return rules
}

// 管理ルールは先頭に置く。Karabiner は上のルールから評価するので、かな配列ルールより優先させる
const applyToProfile = (profile: Profile, managed: Rule[]): Profile => {
  const others = (profile.complex_modifications?.rules ?? []).filter((r) => !r.description.startsWith(MANAGED_PREFIX))
  return { ...profile, complex_modifications: { ...profile.complex_modifications, rules: [...managed, ...others] } }
}

const main = () => {
  const managed = loadManagedRules()
  const config: KarabinerConfig = JSON.parse(readFileSync(CONFIG_PATH, 'utf8'))
  const selected = config.profiles.find((p) => p.selected)
  if (selected === undefined) throw new Error(`選択中のプロファイルがありません: ${CONFIG_PATH}`)

  const backupPath = `${CONFIG_PATH}.bak.dotfiles`
  copyFileSync(CONFIG_PATH, backupPath)
  const next = { ...config, profiles: config.profiles.map((p) => (p === selected ? applyToProfile(p, managed) : p)) }
  // Karabiner の出力と同じ 4 スペース。短い object を 1 行に畳む Karabiner 独自の整形までは再現しないので、
  // 反映直後はファイルが 1MB ほど膨らむが、次に GUI で保存したとき Karabiner が整形し直す
  writeFileSync(CONFIG_PATH, `${JSON.stringify(next, null, 4)}\n`)

  console.log(`profile "${selected.name}" に ${managed.length} 件反映 (backup: ${backupPath})`)
  managed.forEach((r) => console.log(`  - ${r.description}`))
}

main()
