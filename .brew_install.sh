# Get brew if not installed
[[ `which brew &> /dev/null; echo $?` != 0 ]] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install packages
brew install dos2unix
brew install findutils --with-default-names
brew install gawk
brew install maven
brew install mysql
brew install perl
brew install python
brew install python3
brew install rename
brew install tmux
brew install reattach-to-user-namespace
brew install tree
brew install wget
brew install coreutils

