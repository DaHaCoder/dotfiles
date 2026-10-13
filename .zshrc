# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/danial/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/git/powerlevel10k/powerlevel10k.zsh-theme
source ~/git/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export TERM=konsole-256color
export TERM=xterm-kitty

if [[ -f "$HOME/.config/aliasrc" ]]; then
    source "$HOME/.config/aliasrc"
fi

# My aliases
# alias ll='ls -lFh'
# alias lla='ls -lAh'
# alias lld='ls -lAdh .*'
# alias la='ls -a'
# alias ld='ls -d .*'
# alias l='ls -CF'
# alias c='clear'
# alias phbox='cd ~/Nextcloud\ -\ LMU\ Physik/physixbox/physixbox'

# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

# adding `.local/bin` to $PATH for bash scripts
if ! [[ "$PATH" =~ "$HOME/.local/bin" ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

### Some configurations recommended on askubuntu.com -- https://askubuntu.com/questions/1577/moving-from-bash-to-zsh ###
# This gives you more extensive tab completion
autoload -U compinit
compinit

# Tab completion from both ends
setopt completeinword

# Tab completion should be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Better completion for killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

### plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh-history-substring-search

# anti-body setup
#source ~/.zsh_plugins.sh

### vi mode from Luke Smith -- https://www.youtube.com/watch?v=eLEo4OQ-cuQ ###
# vi mode
bindkey -v
#export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect '^h' vi-backward-char
# bindkey -M menuselect '^j' vi-down-line-or-history
# bindkey -M menuselect '^k' vi-up-line-or-history
# bindkey -M menuselect '^l' vi-forward-char


# Remove delay when entering normal mode (vi)
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Start with beam shape cursor on zsh startup and after every command.
zle-line-init() { zle-keymap-select 'beam'}

# # Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         source "$BASE16_SHELL/profile_helper.sh"

# base16_default

### gnuplot kitty integration -- https://sw.kovidgoyal.net/kitty/integrations/  ###
function iplot {
    cat <<EOF | gnuplot
set terminal pngcairo enhanced size 1920, 1080 font 'Latin Modern Sans Regular,40'
set style line 50 lt 1 lc rgb "white" lw 5
set grid dashtype (1.0, 2.0) lc rgb "white" lw 0.5
set border ls 50 rgb "white"
set tics textcolor rgb "white"
set key textcolor variable
set autoscale
set samples 1000
set output '|kitty +kitten icat --stdin yes'
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#131a24" behind noborder
plot $@
set output '/dev/null'
EOF

}


### 'Unblurry' QT-apps by forcing them to use Wayland instead of XWayland -- https://www.reddit.com/r/gnome/comments/16wfkkb/xwayland_apps_blurry_with_fractional_scaling/
# export QT_QPA_PLATFORM=wayland export SDL_VIDEODRIVER=wayland
# APP --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland
#
#


### ANACONDA
export PATH="/home/danial/anaconda3/bin:$PATH"  # commented out by conda initialize


### MINICONDA
export PATH="/home/danial/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/danial/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/danial/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/danial/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/danial/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

unset SSH_ASKPASS

### CREATE LATEX PROJECT FROM TEMPLATE, FOR EAMPLE, EXERCISE SHEET
texnew_sheet() {
    if [ -z "$1" ]; then
        echo "Error: Please type a projectname (i.e. texnew_sheet my_sheet)"
        return 1
    fi

    # path to directory of template for my exercise sheets: $HOME/Documents/TeX-Dokumente/Templates/Studium/sheet-template
    local TEMPLATE_DIR="$HOME/Documents/TeX-Dokumente/Templates/Studium/sheet-template"
    local TARGET_DIR="./$1"
    local PROJ_NAME="$1"

    # check if template exists
    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo "Error: Template directory '$TEMPLATE_DIR' not found."
        return 1
    fi

    # create directory and copy template
    mkdir -p "$TARGET_DIR"

    # copy template files and rename according to PROJ_NAME
    cp "$TEMPLATE_DIR/main_sheet-template.tex" "$TARGET_DIR/main_$PROJ_NAME.tex"
    cp "$TEMPLATE_DIR/preamble_sheet-template.tex" "$TARGET_DIR/preamble_$PROJ_NAME.tex"

    # ignore other files aside of `main_sheet-template.tex` and `preamble_sheet-template.tex`:
    # rsync -a --exclude='main_sheet-template.tex' --exclude='preamble_sheet-template.tex' "$TEMPLATE_DIR/" "$TARGET_DIR/"

    # change to new directory
    cd "$TARGET_DIR" || return

    # change `\input{preamble_sheet-template.tex}` in main_PROJ_NAME.tex file:
    sed -i "" "s/preamble_sheet-template/preamble_$PROJ_NAME/g" "main_$PROJ_NAME.tex" 2>/dev/null || \
        sed -i "s/preamble_sheet-template/preamble_$PROJ_NAME/g" "main_$PROJ_NAME.tex"

    # open main.tex and preamble.tex in neovim
    # :chec::checq
    nvim -O "main_$PROJ_NAME.tex" "preamble_$PROJ_NAME.tex"
}
# let g:python3_host_prog = '/home/danial/anaconda3/bin/python3'
