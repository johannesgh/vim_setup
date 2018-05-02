#!/bin/bash
# Script created by: Jóhannes G. Halldórsson
# Last modified by: No One Yet
printf "About to install several vim extentions..."
printf "Prerequesites: vim wget git python3-jedi python3-flake8 flake8"
printf "Recommended: python3-flake8-docstrings"
printf "Do you want to continue (Y/n)?"
read user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

printf "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

printf "Installing Wombat256Mod"
git clone https://github.com/michalbachowski/vim-wombat256mod ~/.vim/bundle/vim-wombat256mod
export TERM=xterm-256color

printf "Installing vim-gitgutter"
git clone git://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

printf "Installing vim-airline"
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
printf "Installing vim-airline-themes"
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
printf "Downloading powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
printf "Installing powerline fonts"
~/fonts/install.sh
printf "Cleaning up after fonts install"
rm -rf ~/fonts

printf "Installing nerdtree"
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
printf "Installing nerdtree-git-plugin"
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim/bundle/nerdtree-git-plugin

printf "Installing jedi-vim"
git clone git://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
printf "Installing vim-flake8"
git clone git://github.com/nvie/vim-flake8.git ~/.vim/bundle/vim-flake8
printf "Installing ftplugin"
mkdir -p ~/.vim/ftplugin
wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492

printf "End of script"
