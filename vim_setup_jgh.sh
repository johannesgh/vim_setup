#!/bin/bash
# Script created by: Jóhannes G. Halldórsson
printf "About to install several vim extentions..."
printf "\nPrerequisites: vim wget git\n"
printf "\nYCM Auto-Complete: build-essential cmake python3-dev nodejs npm"
printf "\nYCM Auto-Complete extra: mono-complete (C#) golang (Go) default-jdk (Java)\n"
printf "\nPython (3): python3-jedi python3-flake8 flake8 python3-flake8-docstrings"
printf "\nBash: python3-bashate python-bashate-doc"

printf "\nDo you want to continue (Y/n)?"
read user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

printf "\nInstalling Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# GUI and Git

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

# YouCompleteMe Auto-Complete

printf "\nInstalling YouCompleteMe Auto-Complete"
git clone https://github.com/ycm-core/YouCompleteMe ~/.vim/bundle/YouCompleteMe
working_dir=`pwd`
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
python3 install.py --clangd-completer --ts-completer --rust-completer
# Add to above for additional Auto-complete: --cs-completer --go-completer --java-completer
# Or --all for everything enabled.
cd $working_dir

# Ale Linter

printf "\nInstalling Ale Linter"
git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale
# ESLint for JavaScript
npm -i -g eslint eslint-plugin-vue

# Python

# Python Auto-Complete, replaced by YCM
# printf "\nInstalling jedi-vim"
# git clone https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim

# Python linter, replaced by Ale
# printf "\nInstalling vim-flake8"
# git clone https://github.com/nvie/vim-flake8.git ~/.vim/bundle/vim-flake8

printf "\nInstalling Python PEP-8 line length guide script and folding script."
mkdir -p ~/.vim/ftplugin
cp ./python.vim ~/.vim/ftplugin/python.vim
wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492

# Web development

printf "\nInstalling Emmet-vim for HTML and CSS abbreviations"
git clone https://github.com/mattn/emmet-vim.git ~/.vim/bundle/emmet-vim

printf "\nInstalling vim-css-color"
git clone https://github.com/ap/vim-css-color.git ~/.vim/bundle/vim-css-color

printf "\nInstalling typescript-vim"
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/bundle/typescript-vim

printf "\nInstalling vim-vue"
git clone https://github.com/posva/vim-vue.git ~/.vim/bundle/vim-vue

# Rust

printf "\nInstalling rust.vim"
git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim

# Font

printf "\nDownloading powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
printf "\nInstalling powerline fonts"
~/fonts/install.sh
printf "\nCleaning up after fonts install"
rm -rf ~/fonts

printf "End of script"
