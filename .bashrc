#----------------
# Bashrc dot file
#----------------

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
alias findnonascii="perl -ane '{ if(m/[[:^ascii:]]/) { print  } }'"
alias removenonascii="perl -ane '{ if(!m/[[:^ascii:]]/) { print  } }'"
alias deletenonascii="tr -cd '[:print:]\t\n'"
alias vim='vim -np'
alias cdl='cd $OLDPWD'
alias oddcolor="awk '{if (NR % 2 == 0) printf \"\033[1;31m%s\033[0m\n\",\$0; else print \$0;}'"
alias t="tmux"
alias lo="logout"
alias stoe="sed 's/ /\\\ /g'"

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

