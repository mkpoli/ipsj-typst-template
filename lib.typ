#import "lib/footnote.typ": footnotes, grouped-footnote
#import "lib/mixed-font.typ": mixed as mixed-font
#import "lib/latex.typ": draw-TeX
#import "lib/bibliography.typ": fake-bibliography
#import "lib/number.typ": n
#import "@preview/tablex:0.0.8": tablex

#let numbering-affiliate = "1"
#let numbering-paffiliate = "†1"
#let numbering-email = "a)"

#let footnote-affiliate = grouped-footnote.with("1")
#let footnote-paffiliate = grouped-footnote.with("†1")
#let footnote-email = grouped-footnote.with("a)")

// TODO: 2段組を採用しており，左右の段で行の基準線の位置が一致することを原則としている．

// TODO: また，節見出しなど，
// 行の間隔を他よりたくさんとった方が読みやすい場所では，
// この原則を守るようにスタイルファイルが自動的にスペースを挿入する．

#let table(..args) = {
  // set text(size: 0.85em, fill: blue)
  let named = args.named()

  let columns = if "columns" in named {
    if type(named.columns) == array {
      named.columns.len()
    } else if type(named.columns) == int {
      named.columns
    } else {
      panic("Invalid argument: columns")
    }
  } else {
    2
  }

  let rows = calc.floor(args.pos().len() / columns)

  tablex(
    ..range(columns).map(it => []),
    map-hlines: h => (..h, stroke: if (
      type(named.at("header-rows", default: none)) == int and h.y <= named.header-rows + 1
    ) or h.y == rows + 1 { 0.5pt } else {}),
    map-vlines: v => (..v, stroke: if v.x == named.at("header-columns", default: none) { 0.5pt } else {}),
    ..args,
    rows: (1pt, ..{
      if "rows" not in named or type(named.rows) == int {
        range(rows).map(it => auto)
      } else if type(named.rows) == array {
        named.rows
      } else {
        panic("Invalid argument: rows")
      }
    })
  )
}

#let is-empty(it) = {
  it == none or it == "" or it == [] or it == ("",)
}

// #let LaTeX = {
//   set text(font: "New Computer Modern")
//   box(width: 2.55em, {
//     [L]
//     place(top, dx: 0.3em, text(size: 0.7em)[A])
//     place(top, dx: 0.7em)[T]
//     place(top, dx: 1.26em, dy: 0.22em)[E]
//     place(top, dx: 1.8em)[X]
//   })
// }


// #locate(query(selector(footnote).where(footnote.entry == "joho.taro@ipsj.or.jp"))

#let abstract-block(abstract) = {
  set text(size: 8.5pt)
  align(center)[#block(width: 47em)[
    // #set text(size: 8.5pt)
    #set par(justify: true, leading: 0.75em)
    #set align(left)
    *概要*：#abstract
  ]]
}

#let abstract-block-en(abstract, sans-font) = {
  set text(size: 8.5pt)
  align(center)[#block(width: 47em)[
    #set par(justify: true, leading: 0.5em)
    #set align(left)
    #text(style: "italic", font: sans-font, weight: "bold")[Abstract:] #abstract
  ]]
}

#let acknowledgement(body) = {
  [*謝辞*#h(1em, weak: true)#body]
}



/// 情報処理学会研究報告テンプレート
///
/// - lang (string): 言語
/// - title (string): 和文タイトル
/// - title-en (string): 英文タイトル
/// - affiliations (dictionary): 所属
/// - paffiliations (dictionary): 現所属
/// - replace-punctuations (bool): 句読点（、。）をコンマ・ピリオド「，．」に置き換えるかどうか
/// - authors (array): 著者情報
/// - fonts (dictionary): フォントの設定 ```Typst
///     serif-ja // 和文フォント（明朝体）
///     sans-ja // 和文フォント（ゴシック体）
///     serif // 欧文フォント（セリフ体）
///     sans // 欧文フォント（サンセリフ体）
/// ```
/// - abstract (string): 和文概要
/// - abstract-en (string): 英文概要
/// - keywords (array): 和文キーワード
/// - keywords-en (array): 英文キーワード
/// - date (auto, string): 日付
/// - volume (string): 巻数
/// - number (int): 号数
/// - copyright (auto, string): コピーライト表記
/// - appendix (array): 付録
/// -> content
#let techrep(
  lang: "ja",
  title: none,
  // title: "Typstによる情報処理研究報告の作成法",
  title-en: none,
  // title-en: "How to write IPSJ SIG Technical Report with Typst",
  affiliations: (:),
  paffiliations: (:),
  authors: ((
    name: "情報 太郎",
    affiliations: ("IPSJ",),
    email: "joho.taro@ipsj.or.jp"
  ),),
  fonts: (
    sans-ja: "Noto Sans CJK JP",
    serif-ja: "Noto Serif CJK JP",
    mono-ja: "Noto Sans Mono CJK JP",
    sans: "Noto Sans",
    // serif: "Noto Serif"
    serif: "New Computer Modern",
    // mono: "Noto Sans Mono"
    mono: "New Computer Modern Mono"
  ),
  abstract: "",
  abstract-en: "",
  keywords: ("",),
  keywords-en: ("",),
  date: auto,
  volume: str(datetime.today().year()) + "-XX-1XX",
  number: 0,
  copyright: auto,
  replace-punctuations: true,
  appendix: [],
  ..doc
) = {
  // メタデータ
  set document(
    title: title,
    author: authors.map(it => it.name).join(", "),
    keywords: keywords.join(", "),
  )

  if date == auto {
    date = datetime.today()
  }

  if copyright == auto {
    copyright = "©  " + str(date.year()) + " Information Processing Society of Japan"
  }

  // 書体設定
  set text(
    font: (fonts.serif, fonts.serif-ja),
    size: 9.2pt,
    lang: lang
  )
  show raw: it => {
    set text(font: (fonts.mono, fonts.mono-ja), size: 1.25em)
    it
  }
  show raw.where(block: true): it => {
    set par(leading: 0.85em)
    it
  }
  let mixed(body) = {
    mixed-font(fonts.sans-ja, fonts.serif, body)
  }
  show strong: it => mixed(it)
  show heading: it => {
    mixed(it)
  }
  set super(typographic: false)

  // 間隔設定
  // #set page(margin: 1.75in)
  // #set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
  show par: set block(spacing: 1em)
  set par(leading: 0.55em, justify: true)
  // #set text(font: "New Computer Modern")
  // #show raw: set text(font: "New Computer Modern Mono")

  show quote: set block(above: 1em, below: 1em)
  show quote: set pad(left: 2em)
  set list(spacing: 0.85em, indent: 1em)
  set enum(spacing: 0.85em, numbering: "( 1 )")
  // show raw: block.with(above: 0pt, below: 0pt)

  set page(
    margin: (top: 22.5mm, bottom: 22.5mm, left: 16.65mm, right: 16.65mm),
    header: [
      #grid(
        columns: (auto, auto),
        gutter: 1fr,
        [
          #set par(leading: 0.65em)
          #text(size: 8.5pt, font: fonts.sans-ja)[情報処理学会研究報告] \
          #text(size: 8pt, stretch: 175%, spacing: 175%)[IPSJ SIG Technical Report]
        ],
        [
          #set text(size: 8pt)
          #set align(right)
          Vol.#volume No.#number \ #date.display("[year]/[month]/[day]")
        ]
      )
    ],
    header-ascent: 1.4em,
    footer: grid(
      columns: 2,
      gutter: 1fr,
      {
        set text(size: 8pt)
        copyright
      },
      counter(page).display("1")
    //   #copyright
    ),
    footer-descent: 2.4em
  )

  set par(first-line-indent: 1em)
  set heading(numbering: (..params) => {
    let numbers = params.pos()
    return numbering(
      if numbers.len() == 1 { "1." } else { "1.1.1" } + "  ",
      ..numbers
    )
  })
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading {
      numbering(  
        "1.1",
        ..counter(heading).at(el.location())
      )
      [章]
      h(0pt, weak: true)
    } else {
      it
    }
  }
  // show ref

  // 最初の段落の字下げを修正
  show heading: it =>  {
    it
    par()[#text(size:0.5em)[#h(0.0em)]]
  }

  /// タイトル
  let title-block(body, en: false) = {
    set align(center)
    set text(size: if en {1.5em} else {2em})
    set par(leading: if en { 0.35em } else { 0.55em })
    v(if en { 2em } else { 2.45em })
    mixed(body) // タイトルへ応用
  } // タイトルのスタイル設定

  show figure.where(
    kind: raw
  ): it => {
    show raw: set block(stroke: 0.5pt + black, inset: 0.5em, above: 1em, below: 1em)
    set figure(supplement: "1")
    it
  }
  show figure.where(
    supplement: [表]
  ): set figure.caption(position: top)
  show figure.caption: set text(size: 0.85em)

  /// Debug
  let l(tag, value) = raw(tag + " = " + repr(value), lang: "typst", block: true)
    
  // let author-item(author, affiliation-map: (), paffiliation-map: (), already-used: ()) = {
  //   set super(typographic: false)
  //   let (name, affiliations, email) = author

  //   let footnotes = ()

  //   let already-used = ()


  //   l(affiliations, affiliations)
  //   repr(affiliations)

  //   // dictionary<ref-key: string, affliation: string>
  //   let footnotes-map = (:)
  //   for affiliation in affiliations {
  //     l("CURRENT-AFFILIATION", affiliation)

  //     l("already-used", already-used)
  //     already-used.push(affiliation)
  //     // if affiliation in already-used {
  //     //   "Seen"
  //     //   continue
  //     // }

  //     // let affiliation-content = if affiliation in paffiliation-map {
  //     //   paffiliation-map.at(affiliation)
  //     // } else if affiliation in affiliation-map {
  //     //   affiliation-map.at(affiliation)
  //     // } else {
  //     //   panic("Unknown affiliation: " + affiliation)
  //     // }




  //       // footnotes-map.at(affiliation)
  //   }

  //   // repr(footnotes-map)

  //   // for affiliation in affiliations {
  //   //   if affiliation in affiliation-map {
  //   //     if affiliation in paffiliation-map {
  //   //       panic("Affiliation " + affiliation + " is duplicated")
  //   //     }
  //   //     footnotes.push(footnote-affiliate(affiliation-map.at(affiliation)))
  //   //   } else if affiliation in paffiliation-map {
  //   //     footnotes.push(footnote-paffiliate(paffiliation-map.at(affiliation)))
  //   //   } else {
  //   //     panic("Unknown affiliation: " + affiliation)
  //   //   }
  //   // }
    
  //   // for (k, v) in affiliations.pairs() {
  //   //   footnotes.push(footnote-affiliate(v))
  //   // }
  //   // let affiliation-footnotes = affiliations.map(footnote-affiliate)


  //   if email != none and email != "" {
  //     footnotes.push(footnote-email(email))
  //   }
  //   // #affiliations
  //   set text(cjk-latin-spacing: none)
  //   [#name#h(0pt, weak: true)#footnotes.join[#super[,]]]
  // }

  let emails = authors.map(author => author.email).filter(it => it != none)
  let author-block(authors) = {
    set align(center)
    set text(size: 1.25em)
    v(1.25em)
    
    let label-map = (:)

    // for author in authors {
    //   // l("CURRENT-AUTHOR", author)
    //   // let (name, affiliations, email) = author
    //   author.name


    //   // l("CURRENT-AFFILIATIONS", affiliations)
    //   // for affiliation in author.affiliations {
    //   //   l("CURRENT-AFFILIATION", affiliation)

    //   //   if affiliation in label-map {
    //   //     l("label-map.at(affiliation)", label-map.at(affiliation))
    //   //     // ref(label-map.at(affiliation))
    //   //     let the-label = label-map.at(affiliation)
    //   //     locate(loc => query(the-label, loc).first())
    //   //   } else {
    //   //     let new-label = label("aff:" + affiliation)
    //   //     label-map.insert(affiliation, new-label)
    //   //     [#footnote-affiliate()(affiliation) #new-label]
    //   //   }


    //   //   l("label-map", label-map)

    //   //   // if affiliation in already-used {
    //   //   //   // ref(label("aff:" + affiliation))
    //   //   //   ref(label-map.at(affiliation))
    //   //   // } else {
        
    //   //   //   label-map.at(affiliation) = label("aff:" + affiliation)
    //   //   // }

    //   //   // already-used.push(affiliation)

    //   // }

    //   // author-item(author, affiliation-map: affiliations, paffiliation-map: paffiliations)
    //   h(1em)
    // }
    for (i, author) in authors.enumerate() {
      author.name
      h(0pt, weak: true)
      let footnote-markers = ()

      let current-affiliations = affiliations
        .keys()
        .filter(affiliation => affiliation in author.affiliations)

      for (key, affiliation) in current-affiliations.enumerate() {
        let footnote-marker = super(numbering(numbering-affiliate, key + 1))
        footnote-markers.push(footnote-marker)
      }

      let current-paffiliations = paffiliations
        .keys()
        .filter(affiliation => affiliation in author.affiliations)

      for (key, affiliation) in current-paffiliations.enumerate() {
        let footnote-marker = super(numbering(numbering-paffiliate, key + 1))
        footnote-markers.push(footnote-marker)
      }

      if author.email != none {
        footnote-markers.push(super(numbering(numbering-email, emails.position(it => it == author.email) + 1)))
      }

      for (i, footnote-marker) in footnote-markers.enumerate() {
        footnote-marker
        if (i < footnote-markers.len() - 1) {
          super(",")
        }
      }

      // for affiliation in author.affiliations {
        // repr(affiliations.keys().position()
        // repr(affiliations.keys().position(it => it == affiliation))
      // }
      h(1em)
      // link(super(authors),
    }

    v(2.8em)
  }
  set footnote.entry(
    separator: line(length: 50%, stroke: 0.5pt)
  )

  set footnote.entry(indent: 0pt)
  // show footnote: it => {
  // }
  show footnote.entry: entry => {
    grid(
      columns: (3em, 1fr),
      numbering(
        "1",
        ..counter(footnote).at(entry.note.location())
      ),
      entry.note.body
    )
  }
  // it

  // TODO:
  // if replace-punctuations {
  //   show "、": "，"
  //   show "。": "．"
  // }
  show "、": "，"
  show "。": "．"


  show regex(" ?(Lua|Xe|BiB|pdf|p|up)?(La)?TeX(2e)? ?"): it => {
    [ ]
    draw-TeX(it.text.trim())
    [ ]
  }

  // 見出し設定
  show heading.where(level: 1): it => {
    set block(above: 1.5em, below: 0.5em)
    set text(size: 11.3pt)
    it
  }
  show heading.where(level: 2): it => {
    set block(above: 0.9em, below: 0.15em)
    set text(size: 9.2pt)
    it
  }
  show heading.where(level: 3): it => {
    set block(above: 0.9em, below: 0em)
    set text(size: 9.2pt)
    it
  }
  show bibliography: it => {
    {
      // set text(fill: green)
      set text(size: 0pt)
      it
    }
  }

  // 前付け
  title-block(title)
  author-block(authors)
  // v(3em)
  abstract-block(abstract)
  if not is-empty(keywords) {
    v(0.85em)
    align(center, block(width: 8.5pt * 47)[
      #align(left)[
        *キーワード*：#keywords.join(", ")
      ]
    ])
  }
  if not is-empty(title-en) {
    set text(lang: "en")
    title-block(title-en, en: true)
    // author-block(authors)
    v(2em)
  } else {
    v(1em)
  }
  let author-names-en = authors.map(it => it.at("name-en", default: it.name))
  if not is-empty(author-names-en) {
    set text(size: 1.05em, lang: "en")
    align(center,
      author-names-en
        .map(it => upper(it))
        .join(h(1em))
    )
    v(2em)
  }
  if not is-empty(abstract-en) {
    set text(lang: "en")
    abstract-block-en(abstract-en, fonts.sans)
  }
  if not is-empty(keywords-en) {
    set text(lang: "en")
    v(0.85em)
    align(center, block(width: 8.5pt * 47)[
      #align(left)[
        #text(style: "italic", font: fonts.sans, weight: "bold")[Keywords:]
        #keywords-en.join(", ")
      ]
    ])
  }
  v(2em)
  { // 本文
    set par(leading: 8pt)
    show par: set block(spacing: 8pt)
    // show par: set block(spacing: 1em, above: 0.5em, below: 0.5em)

    for part in doc.pos() {
      if type(part) == content {
        columns(2, gutter: 5%, [
          #v(5pt)
          #part
        ])
      } else {
        part.value
      }
    }

  }
  
  if appendix != [] {
    pagebreak()
    counter(heading).update(0)
    set heading(numbering: "付録1.1")
    appendix
  }
}

