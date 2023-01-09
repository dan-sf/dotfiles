#----------------------
# Bash profile dot file
#----------------------

export EDITOR=vim
export PATH="/usr/local/sbin:$PATH"

# Big history, ignore duplicate entries
export HISTCONTROL=ignoredups;
export HISTSIZE=500000;
export HISTFILESIZE=500000;

# Give ls color
export LSCOLORS="gxgxcxcxbxcxbxbxbxgxgx";
export LS_COLORS="di=36;40:ln=36;40:so=32;40:pi=32;40:ex=31;40:bd=32;40:cd=32;40:su=31;40:sg=31;40:tw=36;40:ow=36;40:"

# Get the aliases and functions
[[ -f ~/.bashrc ]] && source ~/.bashrc;
[[ -f ~/.homerc ]] && source ~/.homerc;
[[ -f ~/.workrc ]] && source ~/.workrc;
[[ -f ~/.git-prompt.sh ]] && source ~/.git-prompt.sh;

# Set the PS1
Black='\e[0;30m'; Red='\e[0;31m'; Green='\e[0;32m'; Yellow='\e[0;33m';
Blue='\e[0;34m'; Purple='\e[0;35m'; Cyan='\e[0;36m'; White='\e[0;37m';
PS1="\[$Green\][\@] (\[$Cyan\]\w\[$White\]\$(__git_ps1 ":%s")\[$Green\]) \[$White\]"

#----------
# Functions
#----------

function rgf {
    rg -l . | rg $@
}

# Print the columns of a tab delimitated files
function topline {
     row=${1:-1}
     awk -v row=$row 'BEGIN{OFS="\t";FS="\t"}{if (NR==row) { print ""; for(i=1;i<=NF;i++) print i,$i; print "";}}'
}

# Print input all on the same line
function sl {
    awk 'BEGIN{ORS=" "}{print $0}' | awk '{print}'
}

# Check running processes
function psme {
    ps auxww | grep $USER
}

# Make a new dir and cd to it
function mkcd {
     mkdir -p $1; cd $1
}

# Compile and run small java programs
function jrun {
    code=$1
    name=`echo $1 | rev | cut -f2- -d"." | rev`
    class=${2:-$name}
    javac $code && java $class
}

# Grep for python code in current dir tree
function findpy {
    term=${1}
    find . -type f -name '*.py' | xargs grep ${term}
}

# Start a python venv
function venv {
    project=$1
    if [[ $project == "" ]]
    then
        if [[ ! -f venv/bin/activate ]] && [[ ! -f .venv/bin/activate ]]
        then
            echo "ERROR: venv/.venv dirs do not exist and no project name was given"
            return 1
        fi

        if [[ -f venv/bin/activate ]] && [[ -f .venv/bin/activate ]]
        then
            echo "ERROR: both venv and .venv dirs exist"
            return 1
        fi

        if [[ -f venv/bin/activate ]]; then source venv/bin/activate; fi
        if [[ -f .venv/bin/activate ]]; then source .venv/bin/activate; fi
    else
        source ~/.virtualenv/${project}/bin/activate
    fi
}

# Grep for text in launchd plist files
function findld {
    term=${1}
    launchd_dirs="/Users/$USER/Library/LaunchAgents
                  /Library/LaunchAgents
                  /Library/LaunchDaemons
                  /System/Library/LaunchAgents
                  /System/Library/LaunchDaemons"
    find ${launchd_dirs} -type f | xargs grep ${term}
}

# Function for extracting archived files (found this code somewhere, not sure who originally wrote it)
function extract {
     file="$1";
     if [ -f "$file" ] ; then
          case "$file" in
               *.tar.bz2)   tar xvjf "$file"     ;;
               *.tar.gz)    tar xvzf "$file"     ;;
               *.bz2)       bunzip2 "$file"      ;;
               *.rar)       unrar x "$file"      ;;
               *.gz)        gunzip "$file"       ;;
               *.tar)       tar xvf "$file"      ;;
               *.tbz2)      tar xvjf "$file"     ;;
               *.tgz)       tar xvzf "$file"     ;;
               *.zip)       unzip "$file"        ;;
               *.Z)         uncompress "$file"   ;;
               *.7z)        7z x "$file"         ;;
               *)           echo "$file cannot be extracted via extract" ;;
          esac
     else
          echo "$file is not a valid file!"
     fi
}

# Function used to run Processing scripts
function prun {
     if [[ $1 != *'/..'* && $1 != *'../'* && $1 != '.'* && $1 != '/'* ]]
     then
          [[ $1 == "" ]] && sketch=`pwd`;
          [[ $1 != "" ]] && sketch=`pwd`"/"`echo $1 | sed 's;/$;;'`;

          processing-java --sketch="$sketch" --output="$sketch/.tmp_output" --run;
          rm -r "$sketch/.tmp_output";
     else
          echo 'ERROR: Please enter the path to your sketch relative to your current location, ".", "..", "~", and full paths will not work with this function';
          echo '       If you are in the sketch folder you want to run it, simply exicute prun with no arguments';
     fi
}

# Set up Processing scripts
function psetup {
     sketch=$1;
     mkdir $sketch; touch $sketch/$sketch.pde; cd $sketch;
}

# Set the title of the terminal window
function set_title {
     mytitle="$1";
     echo -en '\033k'$mytitle'\033\\';
}

# Use pyenv to manage python versions
if command -v pyenv &> /dev/null
then
    # Export vars so pyenv is enabled
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PATH="/Users/$USER/.pyenv/shims:${PATH}"

    # This command runs 'pyenv rehash' which takes longer than I'd like for
    # opening new terminal windows, just need to run this command when
    # installing any packages with pyenv, sigh

    # eval "$(pyenv init -)"
    eval "$(pyenv init - | grep -v 'pyenv.rehash\|^echo')"
fi

# Enable brew auto complete
if which brew &> /dev/null; then
    brew_prefix=$(brew --prefix)
    if [[ -f ${brew_prefix}/etc/bash_completion ]];
    then
        source ${brew_prefix}/etc/bash_completion &> /dev/null
    fi
    # for comp in ${brew_prefix}/etc/bash_completion.d/*
    # do
    #     [[ -f $comp ]] && source $comp
    # done
    # if [[ -f ${brew_prefix}/etc/profile.d/bash_completion.sh ]];
    # then
    #     source ${brew_prefix}/etc/profile.d/bash_completion.sh
    # fi
fi

# Start tmux on login - Move to homerc with an if $1 == 'tmux' and exit in that if
if which tmux &> /dev/null
then
    [[ ! $TERM =~ screen ]] && exec tmux
fi

