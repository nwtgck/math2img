# /bin/bash
cd /latex    # NOTE: Hard cording: /latex
latexmk -pdf
pdfcrop hoge.pdf # HOTE: Hard cording: hoge.pdf

