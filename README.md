# Dotfiles

This repo is for tracking/syncing my dotfiles accross various machines. I am
currently using [chezmoi](https://github.com/twpayne/chezmoi) to manage these
files.

## Bootstrap

These dotfiles can be bootstraped one of two ways. Copy the `install.sh` file
from this repo root and run it. Or run the equvalent commands manually. Here are
the commands for manual copy/paste use (the below commands assume `chezmoi` is
not installed):

```
bin_dir="$HOME/.local/bin"
chezmoi="$bin_dir/chezmoi"
# Download via curl
sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
# Dowload via wget if curl not installed (uncomment to use)
#sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
"$chezmoi" init dan-sf
"$chezmoi" apply
```

The apply command will copy all dotfiles from this repo into the proper places.
If on a mac, it will also run an install script that installs `brew` + various
packages locally.

## Usage

Common usage commands:

```
# Add a file for chezmoi to start tracking
chezmoi add /path/to/file

# Update chezmoi files after local file changes
chezmoi re-add

# Check changes
chezmoi diff

# Apply changes from chezmoi to local files
chezmoi apply -v -n # Run first in verbose/dry-run mode
chezmoi apply -v # Run for real if the above looks okay

# See docs or use --help for more options
```

