#!/usr/bin/env bash

set -e

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
    brew list $program &> /dev/null || brew install $args
}

# Check if apple command line tools have been installed (this command will fail
# if the command line tools have not been installed)
echo "Checking if Apple's command line tools have been installed..."
if git --version &> /dev/null
then
    echo "Command line tools installed, continuing"
else
    echo "Apple's command line tools have not been installed (install with 'xcode-select —install'), exiting"
    exit 1
fi

# Check if the JDK has been installed
echo "Checking if the JDK has been installed..."
if java -version &> /dev/null
then
    echo "JDK has been installed, continuing"
else
    echo "The JDK needs to be installed, exiting"
    exit 1
fi

# Get brew if not installed
which brew > /dev/null || get_brew
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
brew_install cmake
brew_install coreutils
brew_install dos2unix
brew_install findutils --with-default-names
brew_install fzf
brew_install gawk
brew_install git
brew_install gnu-sed
brew_install grip
brew_install htop
brew_install jq
brew_install maven
brew_install perl
brew_install pyenv
brew_install python
brew_install reattach-to-user-namespace
brew_install rename
brew_install ripgrep
brew_install tmux
brew_install tokei
brew_install tree
brew_install vim
brew_install neovim
brew_install wget

# Notable packages that we may want to also install:
# docker
# ctags
# ctop
# gcc/gdb
# rust (via rustup)

