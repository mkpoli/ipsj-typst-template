#import "@preview/tidy:0.2.0"
#import "./custom-style.typ"
#set text(font: "Noto Serif CJK JP", size: 10pt)
#show raw: set text(font: ("Fira Code", "Noto Sans Mono CJK JP"))
#set heading(numbering: "1.1")
#set page(paper: "jis-b5")
#outline(title: "目次")

#let show-module = tidy.show-module.with(
  style: custom-style,
)

= テンプレート
#let docs = tidy.parse-module(read("../template.typ"))
#show-module(docs)

= ライブラリー

== 脚注
#let doc-footnote = tidy.parse-module(read("../lib/footnote.typ"))
#show-module(doc-footnote)

== フォント
#let doc-font = tidy.parse-module(read("../lib/mixed-font.typ"))
#show-module(doc-font)

