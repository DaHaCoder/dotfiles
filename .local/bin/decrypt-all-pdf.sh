#! /bin/bash

echo "Input dirname: "
read dirname

mkdir $dirname

echo "Input password: "
read password

for pdfname in *.pdf
do

    decryption=$(qpdf --password="$password" --decrypt "$pdfname" "$dirname"/decrypted_"$pdfname")

done
exit 0
