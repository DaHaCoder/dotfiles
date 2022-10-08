# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

##### --- Paths for XDG base directory, see https://wiki.archlinux.org/index.php/XDG_Base_Directory --- #####
### -- A -- ###

## anaconda
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"

## Anki
#anki -b "$XDG_DATA_HOME"/Anki

## atom
export ATOM_HOME="$XDG_DATA_HOME"/atom

### -- B -- ###

## bash-completion
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

## bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

### -- C -- ###

## Rust#Cargo
#export CARGO_HOME="$XDG_DATA_HOME"/cargo

## cinelerra
#export CIN_CONFIG="$XDG_CONFIG_HOME"/bcast5

### -- D -- ###

## dvdcss
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss

### -- E -- ###

### -- F -- ###

## FFmpeg
export FFMPEG_DATADIR="XDG_CONFIG_HOME"/ffmpeg

### -- G -- ###

## gem
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

## gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

## gtk
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

### -- H -- ###

### -- I -- ###

### -- J -- ###

## java
export _JAVA_OPTIONS="-Djava.utilprefs.userRoot=$XDG_CONFIG_HOME"/java

## jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter


### -- K -- ###

## kde
export KDEHOME="$XDG_CONFIG_HOME"/kde

## kodi
KODI_DATA=$XDG_DATA_HOME/kodi

### -- L -- ###

## latexmk
XDG_CONFIG_HOME/latexmk/latexmkrc

### -- M -- ###

## Mathematica
export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME"/mathematica

## maxima
export MAXIMA_USERDIR="$XDG_CONFIG_HOME"/maxima

## MOC
mocp -M "$XDG_CONFIG_HOME"/moc,
mocp -O MOCDir="$XDG_CONFIG_HOME"/moc

## mplayer
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer

### -- N -- ###

## npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

## nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### -- O -- ###

## octave
export OCTAVE_HISTFILE="$XDG_CACHE_HOME"/octave-hsts
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME"/octave/octaverc

#XDG_CONFIG_HOME/octave/octaverc
source /usr/share/octave/site/m/startup/octaverc;
pkg prefix ~/.local/share/octave/packages ~/.local/share/octave/packages;
pkg local_list /home/danial/.local/share/octave/octave_packages;


### -- P -- ###

### -- Q -- ###

### -- R -- ###

## Rust#Rustup
#export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

### -- S -- ###

## sage
#export DOT_SAGE="$XDG_CONFIG_HOME"/sage

### -- T -- ###

## TeamSpeak
#export TS3_CONFIG_DIR="$XDG_CONFIG_HOME"/ts3client

## texmf
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

### -- U -- ###

## units
units --history "$XDG_CACHE_HOME"/units_history

### -- V -- ###

### -- W -- ###

## wget
export WGETRC="$XDG_CONFIG_HOME"/wgetrc

## wine
mkdir -p "$XDG_DATA_HOME"/wineprefixes
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

### -- X -- ###

## x2goclient
#alias x2goclient="x2goclient --home=$HOME/.config

## xbindkeys
#xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config

## xinit
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverr
startx "$XDG_CONFIG_HOME"/X11/xinitrc -- "$XDG_CONFIG_HOME"/X11/xserverrc vt1

## xorg-xauth
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

## xorg-xrdb
#xdb -load ~/.config/X11/xresources

### -- Y -- ###

## yarn
#alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config

### -- Z -- ###

## z
#export _Z_DATA="$XDG_DATA_HOME"/z


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
eval $(/bin/brew shellenv)
. "$HOME/.cargo/env"
