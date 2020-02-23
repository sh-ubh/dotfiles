#!/bin/bash

# This script will Stow all the dotfiles located in the ~/dotfiles folder.
# The -R flag is used to force a 'restow' which will remove any existing symlinks before attempting to Stow.

echo "Stowing Dotfiles...";

cd ~/dotfiles
for file in ~/dotfiles/*; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name. 
  if [ -d ${file} ]; then
    stow -R $(basename $file)
    echo "$(basename $file) stowed."; 
  fi
done

# Return back to the your PWD from before you ran the script
cd ~- 

echo 'All stowed';
