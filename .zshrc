# set prompt
autoload colors
colors

setup_prompt () {

if [[ -n "${SSH_CONNECTION}" ]]; then
  PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]')%{${reset_color}%} %{${fg[yellow]}%}%/%%%{${reset_color}%} "
else
  PROMPT="%{${fg[yellow]}%}%/%%%{${reset_color}%} "
fi

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)%  %{${fg[yellow]}%}%*%{${reset_color}%}"
}

# auto change directory
#
setopt auto_cd

# auto push directory
setopt auto_pushd
setopt pushd_ignore_dups

# use #, ~, ^ as regexp in filename
#
setopt extended_glob

# expand {a-c} to a b c
#
setopt brace_ccl

# auto fill braket
#
setopt auto_param_keys

# when complement a directory name auto append /
#
setopt auto_param_slash

# auto remove / if unnecessary
#
setopt auto_remove_slash

# when expand filename append / if it's a directory
#
setopt mark_dirs

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

# when exec same name as suspended process, resume it
setopt auto_resume
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
#setopt hist_ignore_all_dups
setopt hist_ignore_space   # ignore command start with space
setopt share_history        # share command history data
setopt hist_reduce_blanks
setopt extended_history     # write time when login/logout to history file

WORDCHARS='*?_-[]~&;!#$%^(){}<>'

## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload zed

#zstyle ':completion:*:default' menu select=1

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
setopt long_list_jobs

case "${OSTYPE}" in
    *bsd*|darwin*)
        alias ls="ls -GFh"
        ;;
    linux*)
        alias ls="ls --color=auto -Fh"
        ;;
esac

alias la="ls -A"
alias ll="ls -l"

alias h=history

alias du="du -h"
alias df="df -h"

alias pstree="pstree -h"

alias su="su -l"

alias stop="kill -TSTP"

alias jman="LC_ALL=ja_JP.UTF-8 MANPATH=/usr/share/man/ja man"

# Global aliases -- These don't have to be at the beginning of the command line
#
alias -g L='|less'
alias -g G='|grep'
alias -g X='|xargs'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc'
alias -g S='|sort'
#alias -g S='|sed'
#alias -g A='|awk'


# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*|linux)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        export LSCOLORS=gxfxcxdxbxegedabagacad
        export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac

# make less more friendly
export LESS_TERMCAP_md="${terminfo[bold]}${fg_bold[white]}"     # bold/ bright
export LESS_TERMCAP_mh="${fg[white]}"           # dim/ half
export LESS_TERMCAP_me="${terminfo[sgr0]}"      # normal (turn off all attributes)
export LESS_TERMCAP_mr="${terminfo[rev]}"       # reverse
export LESS_TERMCAP_mp="${fg[white]}"           # protected
export LESS_TERMCAP_mk="${fg[white]}"           # blank/ invisible
export LESS_TERMCAP_se="${terminfo[sgr0]}"      # standout end
export LESS_TERMCAP_so="${terminfo[rev]}"       # standout
export LESS_TERMCAP_ue="${terminfo[sgr0]}"      # end underline
export LESS_TERMCAP_us="${fg_bold[cyan]}"       # underline

precmd () {
    setup_prompt
}

preexec () {
    [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

alias emacs="emacs24-nox"
