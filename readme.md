# elzup's dotfiles

[setup](https://github.com/elzup/dotfiles/wiki)

# Related

[Brewfile](https://github.com/elzup/Brewfile)

[この PC の主要リポジトリ](docs/repos.md)

## Karabiner-Elements

`karabiner.json` は数 MB あり GUI も書き換えるため丸ごとは管理しない。追加ルールだけ `.config/karabiner/rules/*.json` に置き、次で選択中プロファイルの先頭へ反映する (description が `dotfiles: ` で始まるルールを置き換え)。

```sh
node ~/dotfiles/scripts/karabiner_apply.ts
```

- `right-command-hyper.json`: 右 cmd → cmd+option+shift
