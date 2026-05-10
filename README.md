# 情報処理学会テンプレート (IPSJ Typst Templates)

情報処理学会（Information Processing Society of Japan, IPSJ）で利用される各種文書のための Typst テンプレート集です。現時点では **研究報告（Technical Report）** のみをサポートしています。今後、論文誌・全国大会など他の文書形式への対応も予定しています。

> [!WARNING]
> **本テンプレートはプレビュー段階です。**
>
> 動作はしますが、組版細部や検証は十分ではありません。**学会への正式な提出には[公式テンプレート](https://www.ipsj.or.jp/journal/submit/style.html)を必ずご利用ください。** 本テンプレートは下書き・プレビュー用途に留めることを強く推奨します。

## サポート状況

| ドキュメント種別 | 状態 | 備考 |
|---|---|---|
| 研究報告（Technical Report） | ✅ プレビュー | 本リポジトリで提供 |
| 論文誌・全国大会・その他 | ⏳ 未対応 | 今後対応予定 |

## 注意事項

* 本テンプレートは **非公式** であり、情報処理学会と一切関係ありません。
* 開発中につき、仕様・出力は予告なく変更される可能性があります。
* 学会から承認されたものではないため、利用は自己責任となります。本テンプレートを利用したことによる一切の損害について責任を負いません。
* 正式な提出時は必ず[公式テンプレート](https://www.ipsj.or.jp/journal/submit/style.html)で再組版・確認してください。

## 使い方

本テンプレートは [Tyler](https://github.com/mkpoli/tyler) で管理されています。Tyler を使ってローカル Typst パッケージとしてインストール・利用するのが推奨フローです。

### 1. Tyler のインストール

```bash
bun i -g @mkpoli/tyler
# または
npm install -g @mkpoli/tyler
```

### 2. 本テンプレートをローカルにインストール

リポジトリのルートで:

```bash
tyler build -i
```

これでビルド成果物が `@local/ipsj-template:<version>` としてローカル Typst パッケージに登録されます。

### 3. 利用

新しい原稿ディレクトリを作成:

```bash
typst init @local/ipsj-template:0.0.0 my-report
```

## 参照用ファイル

* [情報処理学会研究報告テンプレート](https://www.ipsj.or.jp/journal/submit/style.html)
* [研究報告原稿（PDFファイル）作成について](https://www.ipsj.or.jp/kenkyukai/genko.html)
* [ken1row/IPSJ-techrep-xelatex](https://github.com/ken1row/IPSJ-techrep-xelatex/)
