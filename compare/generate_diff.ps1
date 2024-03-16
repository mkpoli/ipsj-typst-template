typst compile --root . main.typ
# diff-pdf --output-diff=.\diff\twdiff.pdf main.pdf .\word\sig-ms2023.pdf
# diff-pdf --output-diff=.\diff\tldiff.pdf main.pdf .\latex\tech-jsample.pdf
diff-pdf --output-diff=.\diff\tldiff_xchange.pdf main.pdf .\latex\tech-jsample-xchange.pdf | Out-Null
# diff-pdf --output-diff=.\diff\txdiff.pdf main.pdf .\latex\tech-jsample_xela.pdf
# diff-pdf --output-diff=.\diff\wldiff.pdf main.pdf .\word\sig-ms2023.pdf
# diff-pdf --output-diff=.\diff\wxdiff.pdf main.pdf .\word\sig-ms2023.pdf

pdftoppm latex/tech-jsample-xchange.pdf diff/latex01 -png -f 1 -singlefile
pdftoppm main.pdf diff/typst01 -png -f 1 -singlefile