#! /bin/bash

# Extension of output file
out_ext=$1

cd /latex    # NOTE: Hard cording: /latex

# Generate .pdf
latexmk -pdf

# Crop margen
pdfcrop hoge.pdf # HOTE: Hard cording: hoge.pdf


if   [ $out_ext = "pdf" ]; then
    # Use original PDF
    cp hoge-crop.pdf hoge.pdf
elif [ $out_ext = "svg" ]; then
    # Convert .pdf to .svg
    pdf2svg hoge-crop.pdf hoge.svg
else
    # Use convert command to convert
    convert -density 600 hoge-crop.pdf -quality 100 -resize 300% hoge.$out_ext
fi