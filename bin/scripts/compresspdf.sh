#!/usr/bin/env bash
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -q -o $1_output $1
