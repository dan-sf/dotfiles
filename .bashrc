#------------------------------------------
# Bashrc dot file: Maintained by Dan Fowler
# Website: dsfcode.com
# Version 1.0.0
#------------------------------------------

umask 000

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc; 

#----------------
# General aliases
#----------------

if [[ `uname` == "Darwin" ]]; then alias ls='ls -G';
else alias ls='ls --color'; fi
alias where='which'
alias ll='ls -lht'
alias la="ls -la"
alias lsd='ls -l | grep ^d'
alias b='bc -lq'
alias awks='awk -v OFS="\t" -v FS="\t" -v OFMT="%f"'
alias srt="sort -t$'\t'"
alias ..='cd ..'
alias .='echo $PWD'
alias grep='grep --color'
alias zcat='gunzip -c';
alias tl=topline
alias sl="sed '{:q;N;s/\\n/ /g;t q}'"
alias findnonascii="perl -ane '{ if(m/[[:^ascii:]]/) { print  } }'"
mkdir='mkdir -p'
alias vim='vim -np'

# Miss spellings
alias ehad=head
alias headd=head
alias haed=head
alias had=head
alias ead=head
alias jhead=head
alias grpe=grep
alias les=less

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

