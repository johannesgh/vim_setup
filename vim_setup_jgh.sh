#!/bin/bash
# Script created by: Jóhannes G. Halldórsson
printf "About to install several vim extentions..."
printf "\nPrerequisites: vim wget git python3-jedi python3-flake8 flake8"
printf "\nRecommended: python3-flake8-docstrings"
printf "\nDo you want to continue (Y/n)?"
read user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

printf "\nInstalling Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

printf "\nInstalling Wombat256Mod"
git clone https://github.com/michalbachowski/vim-wombat256mod ~/.vim/bundle/vim-wombat256mod
export TERM=xterm-256color

printf "\nInstalling vim-gitgutter"
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

printf "\nInstalling vim-airline"
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
printf "\nInstalling vim-airline-themes"
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes

printf "\nInstalling nerdtree"
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
printf "\nInstalling nerdtree-git-plugin"
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim/bundle/nerdtree-git-plugin

printf "\nInstalling jedi-vim"
git clone git://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
printf "\nInstalling vim-flake8"
git clone git://github.com/nvie/vim-flake8.git ~/.vim/bundle/vim-flake8

printf "\nInstalling Python PEP-8 line length guide script."
mkdir -p ~/.vim/ftplugin
cp ./python.vim ~/.vim/ftplugin/python.vim

printf "\nDownloading powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
printf "\nInstalling powerline fonts"
~/fonts/install.sh
printf "\nCleaning up after fonts install"
rm -rf ~/fonts

printf "End of script"
