#!/usr/bin/env bash

set -e

# Install command from brew.sh
function get_brew {
    echo "Installing brew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
git --version > /dev/null

# Check if the JDK has been installed
echo "Checking if the JDK has been installed..."
java -version &> /dev/null

# Get brew if not installed
which brew > /dev/null || get_brew

# Install packages
brew_install cloc
brew_install cmake
brew_install coreutils
brew_install dos2unix
brew_install findutils --with-default-names
brew_install gawk
brew_install git
brew_install htop
brew_install maven
brew_install mysql
brew_install perl
brew_install python
brew_install python3
brew_install reattach-to-user-namespace
brew_install rename
brew_install sbt
brew_install scala
brew_install tmux
brew_install tree
brew_install wget

