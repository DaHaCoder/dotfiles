#!/bin/bash
if [ -z "$1" ]; then
    echo "usage: $0 <tex-file> [options]"
    exit 1
fi

texfile=$1

# Some defaults...
fillcolor="white"
linecolor="black"
fontsize="50pt"
linewidth="0.02em"
samples="200"

# Parse any remaining arguments
if [ -n "$1" ]; then
    options="$(getopt --long fillcolor:,linecolor:,fontsize:,linewidth:,samples: -- $@)"
    eval set -- "$options"

    while [ -n "$1" ]; do
        case "$1" in
            --fillcolor) fillcolor=$2; shift;;
            --linecolor) linecolor=$2; shift;;
            --fontsize)  fontsize=$2;  shift;;
            --linewidth) linewidth=$2; shift;;
            --samples)   samples=$2;   shift;;
            --) shift; break;;
            *) echo "Unrecognized option '$1'"; exit 1;;
        esac
        shift
    done
fi

echo "Insert LaTeX code: "
read -r latexcode
latexcode="$(printf "%s" "$latexcode" | sed 's|\\\\|\\\\\\\\|g')"

echo "Input filename: "
read filename 

pdflatex -shell-escape -jobname=formula <<EOF
\\def\\myfillcolor{$fillcolor}
\\def\\mylinecolor{$linecolor}
\\def\\myfontsize{$fontsize}
\\def\\mylinewidth{$linewidth}
\\def\\mysamples{$samples}
\\def\\formula{$latexcode}
\\input{$texfile}
EOF
convert -density 10000 -quality 15000 formula.pdf $filename.png

rm *.aux *.log *.pdf
