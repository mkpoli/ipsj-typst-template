#import "../template.typ": techrep, acknowledgement, numbering-affiliate, numbering-paffiliate, numbering-email, table, fake-bibliography
#import "@preview/tablex:0.0.8": hlinex

#set list(marker: "□")

#let affiliations = (
    "IPSJ": [情報処理学会 \ IPSJ, Chiyoda, Tokyo 101–0062, Japan],
)
#let paffiliations =  (
  "JU": [現在，情報処理大学 \ Presently with Johoshori University]
)
#let authors = (
  (
    name: "情報 太郎",
    affiliations: ("IPSJ",),
    email: "joho.taro@ipsj.or.jp"
  ),
  (
    name: "処理 花子",
    affiliations: ("IPSJ",),
    email: none
  ),
  (
    name: "学会 次郎",
    affiliations: ("IPSJ", "JU"),
    email: "gakkai.jiro@ipsj.or.jp"
  )
)

#let emails = authors.map(author => author.email).filter(it => it != none)

// #show: doc => techrep(
#techrep(
  title: [
    情報処理学会研究報告の準備方法 \
    （2018年10月29日版）
  ],
  title_en: [
    How to Prepare Your Paper for IPSJ SIG Technical Report \
    (version 2018/10/29)
  ],
  affiliations: (
    "IPSJ": [情報処理学会 \ IPSJ, Chiyoda, Tokyo 101–0062, Japan],
  ),
  paffiliations: (
    "JU": [現在，情報処理大学 \ Presently with Johoshori University]
  ),
  authors: (
    (
      name: "情報 太郎",
      affiliations: ("IPSJ",),
      email: "joho.taro@ipsj.or.jp"
    ),
    (
      name: "処理 花子",
      affiliations: ("IPSJ",),
      email: none
    ),
    (
      name: "学会 次郎",
      affiliations: ("IPSJ", "JU"),
      email: "gakkai.jiro@ipsj.or.jp"
    )
  ),
  abstract: [
    本稿は，情報処理学会研究報告に投稿する原稿を執筆する際の注意点等をまとめたものである．\
    LaTeX と専用のスタイルファイルを用いた場合の論文フォーマットに関する指針，および論文の内容に関
    してするべきこと，するべきでないことをまとめたべからずチェックリストからなる．本稿自体もLaTeX\
    と専用のスタイルファイルを用いて執筆されているため，論文執筆の際に参考になれば幸いである．
  ],
  copyright: "©  1959 Information Processing Society of Japan",
  [
    = はじめに
    <はじめに>

    情報処理学会では，研究報告の発行を行っている．

    本稿では，まずそのスタイルファイルを用いた論文のフォーマットに関して述べる．
    新たなスタイルファイルでは，
    極力特別なコマンドは使わずに，標準的なLaTeXのスタイルを踏襲している．
    論文フォーマットに関しては、@論文フォーマットの指針
    で後述する指針に従って頂くが，
    そこに規定されていること以外は標準的なLaTeXのコマンドをそのまま使うことができる．
    本稿は，そのスタイルファイルを実際に使っているので，論文執筆の際に参考にされたい．
    #place(bottom, float: true, {
      set align(top + left)
      set block(above: 0.5em, below: 0pt)
      set text(size: 0.85em)
      set par(leading: 0.5em)
      line(length: 100%, stroke: 0.5pt)
      grid(
        columns: (auto, 1fr),
        column-gutter: 1.5em,
        row-gutter: 0.5em,
        ..for (i, content) in affiliations.values().enumerate() {
          (
            super(numbering(numbering-affiliate, i + 1)),
            content
          )
        },
        ..for (i, content) in paffiliations.values().enumerate() {
          (
            super(numbering(numbering-paffiliate, i + 1)),
            content
          )
        },
        ..for (i, content) in emails.enumerate() {
          (
            super(numbering(numbering-email, i + 1)),
            content
          )
        }
      )
    })
    = 投稿の流れ
    <投稿の流れ>
    == 準備
    <準備>
    情報処理学会論文誌ジャーナルのLaTeXスタイルファイルを含む論文執筆キットは

    #quote(block: true)[
    `http://www.ipsj.or.jp/jip/submit/style.html`
    ]

    からダウンロードすることができる．論文執筆キットは以下のファイルを含んでいる．

    + `ipsj.cls      `: 最終原稿用スタイルファイル
    + `ipsjdraft.sty `: 投稿用スタイル（査読用）
    + `ipsjpref.sty  `: 序文用スタイル
    + `jsample.tex   `: 本稿のソースファイル

    + `esample.tex   `: 英文サンプルのソースファイル

    + `ipsjsort.bst  `: jBibTEX スタイル（著者名順）

    + `ipsjunsrt.bst `: jBibTEX スタイル（出現順）

    + `bibsample.bib `: 文献リストのサンプル

    + `ebibsample.bib`: 英文文献リストのサンプル

    + `tech-jsample.tex:` 研究報告（和文）のサンプル

    + `tech-esample.tex:` 研究報告（英文）のサンプル

    実行環境としてはLaTeX2eを前提としているので，準備されたい．

    \
    #v(0.5em)

    == 原稿の作成と投稿
    <原稿の作成と投稿>
    本稿に従って用意した投稿用原稿のLaTeXソースからpdfファイルを作成し，
    Adobeのpdf readerで読めることを確認した後，

    #quote(block: true)[
    `https://ipsj1.i-product.biz/ipsjsig/**`
    ]

    \(\*\*部分は研究会の略称，DBS等)の研究会投稿システムにて，指示にし従い投稿する．

    = 論文フォーマットの指針
    <論文フォーマットの指針>
    以下，情報処理学会論文誌ジャーナル用スタイルファイルを用いた論文フォーマットの指針について述べるので，
    これに従って原稿を用意頂きたい．
    LaTeXを用いた一般的な文章作成技術については，
    #cite(<okumura>);#cite(<companion>) 等を参考にされたい．

    #colbreak()

    #v(1.5em)
    = 論文の構成
    <config>
    ファイルは次のようになる．下線部は投稿時に省略可能なもの．

    ```
    \documentclass[submit,techrep,noauthor]{ipsj}
    ```

    必要ならばユーザーのマクロをここに記述

    ```
    \begin{document}
    \title{表題(和文)}
    \etitle{表題(英文)}
    \affiliate{所属ラベル}{<和文所属>\\<英文所属>}
    ```
    必要ならば `\paffiliate` により現在の所属を宣言する
    ```
    \paffiliate{現所属ラベル}{<和現所属>\\<英現所属>}
    \author{情報 太郎}{Taro Joho}
              {<所属ラベル>}[E-mail]
    \author{処理 花子}{Hanako Shori}
              {<所属ラベル2,現所属ラベル3>}

    \begin{abstract}
    <概要（和文）>
    \end{abstract}
    \begin{eabstract}
    <概要（英文）>
    \end{eabstract}
    \maketitle
    \section{`第1節の表題`}
    ……………
    <本文>
    ……………
    謝辞がある場合は
    \begin{acknowledgment}
    \end{acknowledgment}

    \begin{thebibliography}{99}%9 or 99
    \bibitem{1}
    \bibitem{2}
    \end{thebibliography}

    付録がある場合は
    \appendix
    \section{`付録1節の表題`}
    \end{document}
    ```

    #v(2em)

    == 表題・著者名等
    <表題著者名等>
    表題，著者名とその所属，および概要を前述のコマンドや環境により#strong[和文と
    英文の双方について];定義した後，`\maketitle` によって出力する．

    === 表題
    <表題>
    表題は，`\title` および `\etitle` で定義した表題はセンタリングされる．
    文字数の多いものについては，適宜 `\\` を挿入して改行する．

    === 著者名・所属
    <著者名所属>
    各著者の所属を第一著者から順に `\affiliate`
    を用いてラベル（第1引数）を付けながら定義すると，
    脚注に番号を付けて所属が出力される．
    なお，複数の著者が同じ所属である場合には， 一度定義するだけで良い．

    現在の所属は `\paffiliate` を用い，同様にラベル，所属先を記述する．
    所属先には自動で「現在」， `\\`の改行で「Presently with」が挿入される．
    著者名は `\author` で定義する．各著者名の直後に，英文著者名，
    所属ラベルとメールアドレスを記入する． 著者が複数の場合は `\author`
    を繰り返すことで， 2人，3人，…と増えていく．
    現在の所属や，複数の所属先を追加する場合には，所属ラベルをカンマで区切り，追加すればよい．

    また，メールアドレス部分は省略が可能である．

    === 概要
    <概要>
    和文の概要は `abstract` 環境の中に， 英文の概要は `eabstract`
    環境の中に，それぞれ記述する．

    == 本文
    <本文>
    === 見出し
    <見出し>
    節や小節の見出しには `\section`, `\subsection`, `\subsubsection`,
    `\paragraph` といったコマンドを使用する．

    「定義」，「定理」などについては，`\newtheorem`で適宜環境を宣言し，そ
    の環境を用いて記述する．

    === 行送り
    <行送り>
    2段組を採用しており，左右の段で行の基準線の位置が一致することを原則としている．
    また，節見出しなど，
    行の間隔を他よりたくさんとった方が読みやすい場所では，
    この原則を守るようにスタイルファイルが自動的にスペースを挿入する．
    したがって本文中では `\vspace` や `\vskip`
    を用いたスペースの調整を行なわないようにすること．

    === フォントサイズ
    <フォントサイズ>
    フォントサイズは，スタイルファイルによって自動的に設定されるため，
    基本的には著者が自分でフォントサイズを変更する必要はない．

    === 句読点
    <句読点>
    句点には全角の「．」， 読点には全角の「，」を用いる．
    ただし英文中や数式中で「.」や「,」を使う場合には，
    半角文字を使う．「。」や「、」は使わない．

    === 全角文字と半角文字
    <全角文字と半角文字>
    全角文字と半角文字の両方にある文字は次のように使い分ける．

    + 括弧は全角の「（」と「）」を用いる．但し，英文の概要，図表見出し，
      書誌データでは半角の「\(」と「)」を用いる．

    + 英数字，空白，記号類は半角文字を用いる．ただし，句読点に関しては，
      前項で述べたような例外がある．

    + カタカナは全角文字を用いる．

    + 引用符では開きと閉じを区別する． 開きには #raw("``")
      を用い，閉じには`''` を用いる．

    === 箇条書
    <箇条書>
    箇条書に関する形式を特に定めていない．場合に応じて標準的な `enumerate`,
    `itemize`, `description` の環境を用いてよい．

    === 脚注
    <脚注>
    脚注は `\footnote` コマンドを使って書くと，
    ページ単位に#footnote[脚注の例．];や#footnote[二つめの脚注．];のような参照記号とともに脚注が生成される．
    なお，ページ内に複数の脚注がある場合，参照記号はLaTeXを2回実行しないと正しくならないことに注意されたい．

    また場合によっては，
    脚注をつけた位置と脚注本体とを別の段に置く方がよいこともある．
    この場合には，`\footnotemark` コマンドや `\footnotetext`
    コマンドを使って対処していただきたい．

    なお，脚注番号は論文内で通し番号で出力される．

    === OverfullとUnderfull
    <overfullとunderfull>
    組版時にはoverfullを起こさないことを原則としている．
    従って，まず提出するソースが著者の環境でoverfullを起こさないように，
    文章を工夫するなどの最善の努力を払っていただきたい． 但し，`flushleft`
    環境，`\\`，`\linebreak`
    などによる両端揃えをしない形でのoverfullの回避は，
    できるだけ避けていただきたい．
    また著者の執筆時点では発生しないoverfullが，
    組版時の環境では発生することもある．
    このような事態をできるだけ回避するために， 文中の長い数式や `\verb`
    を避ける， パラグラフの先頭付近では長い英単語を使用しない，
    などの注意を払うようにして頂きたい．

    == 数式
    <sec:Item>
    === 本文中の数式
    <本文中の数式>
    本文中の数式は `$` と `$`, `\(` と `\)`, あるいは `math` 環境のいず
    れで囲んでもよい．

    === 別組の数式
    <別組の数式>
    別組数式\(displayed math)については `$$` と `$$` は使用せずに， `\[` と
    `\]` で囲むか， `displaymath`, `equation`, `eqnarray`
    のいずれかの環境を用いる． これらは
    $ Delta_l = sum_(i = l \| 1)^L delta_(p i) $
    のように，センタリングではなく固定字下げで数式を出力し，
    かつ背が高い数式による行送りの乱れを吸収する機能がある．

    #place(top + center, float: true, figure(
      [
        // #show raw: set block(stroke: 0.5pt + black, inset: 0.5em)
        ```
        \begin{figure}[tb]
          <図本体の指定>
        \caption{<和文見出し>}
        \ecaption{<英文見出し>}
        \label{ . . . }
        \end{figure}
        ```
      ],
      caption: [
        1段幅の図\
        *Fig. 1* Single column figure with caption \
        explicitly broken by \\\\.
      ],
      supplement: "図"
    ))

    === eqnarray環境
    <eqnarray環境>
    互いに関連する別組の数式が2行以上連続して現れる場合には， 単に`\[` と
    `\]`， あるいは `\begin{equation}` と`\end{equation}`
    で囲った数式を書き並べるのではなく， `\begin``{eqnarray}` と
    `\end{eqnarray}` を使って，
    等号（あるいは不等号）の位置で縦揃えを行なった方が読みやすい．

    === 数式のフォント
    <数式のフォント>
    LaTeXが標準的にサポートしているもの以外の特殊な数式用フォントは，
    できるだけ使わないようにされたい．
    どうしても使用しなければならない場合には， その旨申し出て頂くとともに，
    組版工程に深く関与して頂くこともあることに留意されたい．

    == 図
    <図>
    1段の幅におさまる図は， の形式で指定する． 位置の指定に `h` は使わない．
    また，図の下に和文と英文の双方の見出しを， `\caption` と `\ecaption`
    で指定する．
    文字数が多い見出しはは自動的に改行して最大幅の行を基準にセンタリングするが，
    見出しが2行になる場合には適宜 `\\`
    を挿入して改行したほうが良い結果となることがしばしばある （
    の英文見出しを参照）． 図の参照は `\figref{<`ラベル`>}` を用いて行なう．

        また紙面スペースの節約のために， 1つの `figure`（または
    `table`）環境の中に複数の図表を並べて表示したい場合には， と
    のように個々の図表と各々の `\caption`/`\ecaption` を `minipage`
    環境に入れることで実現できる． なお図と表が混在する場合， `minipage`
    環境の中で`\CaptionType{figure}` あるいは `\CaptionType` `{table}`
    を指定すれば， 外側の環境が `figure` であっても `table`
    であっても指定された見出しが得られる．

    2段の幅にまたがる図は， の形式で指定する． 位置の指定は `t`
    しか使えない．

    図の中身では本文と違い，
    どのような大きさのフォントを使用しても構わない（ 参照）．
    また図の中身として，encapsulate
    されたPostScriptファイル（いわゆるEPSファイル）を読み込むこともできる．読み込みのため
  ], (
    type: "figure",
    value: [
      #place(top + center, float: true)[
        #set block(
          width: 100%,
        )
        #show par: it => align(center, it)
        // #show raw: it => align(center, it)
        #figure(
        ```
        \begin{figure*}[t]
        <図本体の指定>
        \caption{<和文見出し>}
        \ecaption{<英文見出し>}
        \label{~$dots.h$~}
        \end{figure*}
        ```,
        caption: [2 段幅の図\ *Fig. 3* Double column figure.]
        )
        <fig:double>
      ]
    ]
  ),
  [
    
    #place(left + top, float: true, 
      [
        #grid(
          columns: 2,
          gutter: 1em,
          [
            #figure(
              ```
              \begin{minipage}[t]%
                {0.5\columnwidth}
              \CaptionType{table}
              \caption{…}
              \ecaption{…}
              \label{…}
              \makebox[\textwidth][c]{%
              \begin{tabular}[t]{lcr}
              \hline\hline
              left&center&right\\\hline
              L1&C1&R1\\
              L2&C2&R2\\\hline
              \end{tabular}}
              \end{minipage}
              ```,
              caption: [
                表1の中身
              ],
              supplement: [図]
            )<fig:left>
          ],
          figure(
            [
              #table(
                columns: 3,
                rows: (1.65em, auto, auto),
                auto-vlines: false,
                header-rows: 2,
                align: center + horizon,
                // align: center + horizon,
                "left", "center", "right",
                "L1", "C1", "R1",
                "L2", "C2", "R2"
              ) <tab:right>
            ],
            caption: [
              @fig:left で作成した表
              *Table 1* A table built by
    Fig. 2
            ],
            supplement: [表]
          ) 
        ) 
      ],
    )

    #figure(
      [
        #table(
          columns: 4,
          rows: (1.65em, auto, auto, auto),
          header-rows: 1,
          header-columns: 1,
          inset: (left: 0.75em, right: 0.75em, top: 0.5em, bottom: 0.5em),
          align: left + horizon,
          // align: center + horizon,
          [], [column1], [column2], [column3],
          [row1], [item 1,1], [item 2,1], [---],
          [row2], [---], [item 2,2], [item 3,2],
          [row3], [item 1,3], [item 2,3], [item 3,3],
          [row4], [item 1,4], [item 2,4], [item 3,4]
        ) <tab:right>
      ],
      caption: [
        表の例 \
        *Table 2* An Example of Table.
      ],
      supplement: [表]
    ) 
    には，プリアンブルで

    #quote(block: true)[
    `\usepackage{graphicx}`
    ]

    を行った上で， `\includegraphics` コマンドを図を埋め込む箇所に置き，
    その引数にファイル名（など）を指定する．

    == 表
    <表>
    表の罫線はなるべく少なくするのが，仕上がりをすっきりさせるコツである．
    罫線をつける場合には，
    一番上の罫線には二重線を使い，左右の端には縦の罫線をつけない （）．
    表中のフォントサイズのデフォルトは`\footnotesize`である．

    また，表の上に和文と英文の双方の見出しを， `\caption`と `\ecaption`
    で指定する． 表の参照は `\tabref{<`ラベル`>}` を用いて行なう．

    <tab:example> to

    == 参考文献・謝辞
    <参考文献謝辞>
    === 参考文献の参照
    <参考文献の参照>
    本文中で参考文献を参照する場合には`\cite`を使用する．
    参照されたラベルは自動的にソートされ， `[]`でそれぞれ区切られる．

    #quote(block: true)[
    文献 `\cite{companion,okumura}` はLaTeXの総合的な解説書である．
    ]

    と書くと；

    #quote(block: true)[
    文献#cite(<okumura>);#cite(<companion>);はLaTeXの総合的な解説書である．
    ]

    が得られる．

    === 参考文献リスト
    <参考文献リスト>
    参考文献リストには， 原則として本文中で引用した文献のみを列挙する．
    順序は参照順あるいは第一著者の苗字のアルファベット順とする．
    文献リストはBiBTeXと`ipsjunsrt.bst`（参照順）
    または`ipsjsort.bst`（アルファベット順）を用いて作り，
    `\bibliograhpystyle`と`\bibliography`コマンドにより
    利用することが出来る． これらを用いれば，
    規定の体裁にあったものができるので， できるだけ利用していただきたい．
    また製版用のファイル群には`.bib`ファイルではなく`.bbl`ファイルを
    必ず含めることに注意されたい．
    一方，何らかの理由でthebibliography環境で文献リストを
    「手作り」しなければならない場合は，
    このガイドの参考文献リストを注意深く見て，
    そのスタイルにしたがっていただきたい．

    === 謝辞
    <謝辞>
    謝辞がある場合には， 参考文献リストの直前に置き，
    `acknowledgment`環境の中に入れる．

    = 論文内容に関する指針
    <論文内容に関する指針>
    論文の内容について，
    論文誌ジャーナル編集委員会で作成した「べからず集」を以下に示す．
    投稿前のチェックリストとして利用頂きたい． これ以外にも，査読者用，
    メタ査読者用の「べからず集」#cite(<webpage2>);も公開しているので，
    参照されたい． また，作文技術に関する@book1;@book2;@book3;@book4;のような書籍も参考になる．

    == 書き方の基本
    <書き方の基本>
    - 研究の新規性，有用性，信頼性が読者に伝わるように記述する．

    - 読み手に，読みやすい文章を心がける（内容が前後する，背景・
      課題の設定が不明瞭などは読者にとって負担）．

    - 解決すべき問題が汎用化（一般的に記述）されていないのは再
      考を要する（XX大学の問題という記述に終始）．あるいは，
      （単に「作りました」だけで）解決すべき問題そのものの記述
      がないのは再考を要する．

    - 結論が明確に記されていない，または，範囲，限界，問題点な
      どの指摘が適切ではない，または，結論が内容にそったもので
      はないものは再考を要する．

    - 科学技術論文として不適当な表現や，分かりにくい表現がある
      のは再考を要する．

    - 極端な口語体や，長文の連続などは再考を要する．

    - 章，節のたて方，全体の構成等が適切でない文章は再考を要す る．

    - 文中の文脈から推測しないと内容の把握が困難な論文にしない．

    - 説明に飛躍した点があり，仮説等の説明が十分ではないのは再 考を要する．

    - 説明に冗長な点，逆に簡単すぎる点があるのは再考を要する．

    - 未定義語を減らす．

    == 新規性と有効性を明確に示す
    <新規性と有効性を明確に示す>
    - 在来研究との関連，研究の動機，ねらい等が明確に説明されて
      いないのは再考を要する．

    - 既知／公知の技術が何であって，何を新しいアイデアとして提
      案しているのかが書かれていないのは再考を要する．

    - 十分な参考文献は新規性の主張に欠かせない．

    - 提案内容の説明が，概念的または抽象的な水準に終始していて，
      読者が提案内容を理解できない（それだけで新規性が感じられ
      ないもの）のは再考を要する．

    - 論文で提案した方法の有効性の主張がない，またはきわめて貧
      弱なのは再考を要する．

    == 書き方に関する具体的な注意
    <書き方に関する具体的な注意>
    - 和文標題が内容を適切に表現していないのは再考を要する．

    - 英文標題が内容を適切に表現していない，または英語として適
      切でないのは再考を要する．

    - アブストラクトが主旨を適切に表現していない，または英文が
      適切ではないのは再考を要する．

    - 記号・略号等が周知のものでなく，または，用語が適切でなく，
      または，図・表の説明が適当ではないのは再考を要する．

    - 個人的あるいは非常に小さなグループ／企業だけで通用するよ
      うな用語が特別な説明もなしに多用されているのは再考を要す る．

    - 図表自体は十分に明確ではない，または誤りがあるのは再考を 要する．

    - 図表が鮮明ではないのは再考を要する．

    - 図表が大きさ，縮尺の指定が適切でないのは再考を要する.

    == 参考文献
    <参考文献>
    - 参考文献は10件以上必要（分野によっては20件以上，30件以上
      という意見もある）.

    - 十分な参考文献は新規性の主張に欠かせない．

    - 適切な文献が引用されておらず，その数も適切ではないのは再 考を要する．

    - 日本人によるしかるべき論文を引用することで日本人研究コミュ
      ニティの発展につながる．

    - 参考文献は自分のものばかりではだめ．

    == 二重投稿
    <二重投稿>
    - 二重投稿はしてはならない ─ ただし国際会議に採択された論
      文を著作権が問題にならないように投稿することは構わない．

    - 他の論文とまったく同じ図表を引用の明示なしに利用すること は禁止．

    - 既発表の論文等との間に重複があるのは再考を要する．

    == 他の人に読んでもらう
    <他の人に読んでもらう>
    - 投稿経験が少ない人は，採録された経験の豊富な人に校正して もらう．

    - 読者の立場から見て論理的な飛躍がないかに注意して記述する．

    == その他
    <その他>
    - 投稿前にチェックリストの各項目を満たしているか，必ず確認 する．

    = おわりに
    <おわりに>
    本稿では，A4縦型2段組み用に変更したスタイルファイルを用いた論文のフォー
    マット方法と，論文誌ジャーナル編集委員会がまとめた「べからず集」に基づく
    論文の書き方を示した．内容的にまだ不十分の部分が多いため，意見，要望等を

    #quote(block: true)[
    `editt@ipsj.or.jp`
    ]

    までお寄せ頂きたい．


    #acknowledgement[
    A4横型に対するガイドを基に，本稿を作成した．
    クラスファイルの作成においては，
    京都大学の中島　浩氏にさまざまなご教示を頂き，
    さらにBiBTeX関連ファイルの利用についても快諾頂いたことを深謝する．
    また，A4横型に対するガイドを作成された当時の編集委員会の担当者に深謝する．
    ]

    #bibliography("citation.yml", title: "参考文献", full: true, style: "./ipsj.csl")
    #fake-bibliography(yaml("citation.yml"))
  ]

)