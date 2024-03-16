/// グループ化された脚注を作成する
///
/// - numbering (string, func): 脚注番号の形式
/// -> func
#let grouped-footnote(numbering) = {
  let series = if (type(numbering) == str) {
    numbering
  } else if (type(numbering) == function) {
    numbering(1)
  } else {
    panic("numbering must be a string or a function")
  }
  let ctr = counter("footnote-group-" + series)

  (body) => {
    locate(loc => {
      ctr.step()
      let value = ctr.at(loc).at(0)
      counter(footnote).update(value)
      return footnote(body, numbering: numbering)
    })
  }
}

#let footnote-arabic = grouped-footnote("1") // For Society
#let footnote-alphabetic = grouped-footnote("a)") // For Email
#let footnote-dagger = grouped-footnote((..args) => { args.pos().at(0) * "†"}) // For University

#let footnotes(..footnotes) = {
  for (i, footnote) in footnotes.pos().enumerate() {
    footnote
    if i != footnotes.pos().len() - 1 {
      [#super(",")]
    }
  }
}