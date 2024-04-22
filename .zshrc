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
set terminal pngcairo enhanced font 'Fira Sans,10'
set autoscale
set samples 1000
set output '|kitty +kitten icat --stdin yes'
set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
plot $@
set output '/dev/null'
EOF

}
