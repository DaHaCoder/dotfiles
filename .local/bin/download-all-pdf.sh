#! /bin/bash

echo "Is a user login for PDF access required ? [y/n]"
read answer
echo -e "\n"

if [[ $answer = "y" ]];
then

    echo "Please input the username that is required for the PDF access."
    read USER
    echo -e "\n"

    echo "Please input the password that is required for the PDF access."
    read -s PASSWORD
    echo -e "\n"

    echo "Please input the URL that contains the PDF files you want to download."
    read URL
    echo -e "\n"

    mkdir downloaded-pdf-files-from-website
    cd downloaded-pdf-files-from-website

    wget --user=$USER --password=$PASSWORD -r -l 1 -nd -nH -A *.pdf $URL

else [[ $answer = "n" ]]

    echo "Please input the URL that contains the PDF files you want to download."
    read URL
    echo -e "\n"

    mkdir downloaded-pdf-files-from-website
    cd downloaded-pdf-files-from-website

    wget -r -l 1 -nd -nH -A *.pdf $URL
fi
