#!/usr/bin/env bash

# Small script for diff'ing these dot files with those located in the home dir

# Colors
red='\033[0;31m'
none='\033[0m'

function diff_it {
    path=$1
    file_name=`basename $path`

    # Run the diff if both files exist and they are different
    if [ -e ${path} ] && [ -e ${file_name} ] && ! diff $file_name $path &> /dev/null
    then
        echo -e "${red}-------------------------${none}"
        echo -e "${red}Running diff:"
        echo -e "${red}diff $file_name $path"
        echo -e "${red}-------------------------${none}"
        diff $file_name $path
    fi

    if ! [ -e ${path} ]
    then
        echo -e "WARNING: '${path}' does not exist locally"
    fi
}

diff_it ~/.bashrc
diff_it ~/.bash_profile
diff_it ~/.tmux.conf
diff_it ~/.config/nvim/init.vim

