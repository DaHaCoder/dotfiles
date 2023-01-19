#!/bin/bash
# Thanks to Patrick Haußmann! -- https://github.com/PatrickHaussmann/dotfiles/blob/master/.bin/makezip

set -euf -o pipefail

# Create a ZIP archive of a file or folder.
zip -r "${1%%/}.zip" "$1"
