#!/usr/bin/env bash

set -eo pipefail

# Chezmoi can run this file but since its only run once on new machines, I'd
# rather just run this manually when needed

# Install command from brew.sh
function get_brew {
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Install brew program if not already installed
function brew_install {
    program=$1
    args=$*
    echo "Brew: Installing '$program' if not already installed. Otherwise continue..."
    #brew list $program &> /dev/null || brew install $args
    if brew list $program &> /dev/null
    then
        echo "'$program' already installed"
    else
        echo "'$program' not installed, installing..."
        brew install $args
    fi
}

# # Note: Looks like brew will now install these if they haven't been installed yet
# # - https://www.freecodecamp.org/news/install-xcode-command-line-tools/
# # - To verify: 'xcode-select -p' -> '/Library/Developer/CommandLineTools'
# # Check if apple command line tools have been installed (this command will fail
# # if the command line tools have not been installed)
# echo "Checking if Apple's command line tools have been installed..."
# if git --version &> /dev/null
# then
#     echo "Command line tools installed, continuing"
# else
#     echo "Apple's command line tools have not been installed (install with 'xcode-select —install'), exiting"
#     exit 1
# fi

# @Note: I don't think this is needed anymore
# # Check if the JDK has been installed
# echo "Checking if the JDK has been installed..."
# if java -version &> /dev/null
# then
#     echo "JDK has been installed, continuing"
# else
#     echo "The JDK needs to be installed, exiting"
#     exit 1
# fi

# Get brew if not installed
#which brew > /dev/null || get_brew
echo "Checking if brew has been installed..."
if which brew &> /dev/null
then
    echo "Brew has been installed, continuing"
else
    echo "Brew not installed, installing brew..."
    get_brew
fi

# Install packages
brew_install bash
brew_install git
brew_install coreutils
brew_install findutils
brew_install fd
brew_install fzf
brew_install gawk
brew_install gnu-sed
brew_install grip
brew_install jq
brew_install pyenv
brew_install python
#brew_install reattach-to-user-namespace # I don't think this is needed with newer versions of tmux
brew_install rename
brew_install ripgrep
brew_install tmux
brew_install tokei
brew_install tree
brew_install vim
brew_install neovim
brew_install wget

echo

# Notable packages/programs that we may want to also install
echo "Finished installing base packages. You may want to optionally install the following:
UI/non-brew installs:
- Docker desktop
- iTerm2
- Slack
- Intellij/Pycharm
- Zoom
- Spotify

Other optional cli/brew packages you may want to install:
- rust (via rustup)
- gcc/gdb
- cmake
- dos2unix
- htop
- k9s
- go
- lua
- nmap
- asdf
- exa
- bat
- git-delta"

echo
echo "Done"
echo

