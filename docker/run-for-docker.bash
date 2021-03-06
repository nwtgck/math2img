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
elif [ $out_ext = "jpg" ]; then
    # Use convert command for jpg with "-alpha Remove" (from: http://risibletons.net/?Blog%2F2013-05-22)
    convert -density 600 hoge-crop.pdf -quality 100 -resize 300% -alpha Remove hoge.$out_ext
else
    # Use convert command to convert
    convert -density 600 hoge-crop.pdf -quality 100 -resize 300% hoge.$out_ext
fi