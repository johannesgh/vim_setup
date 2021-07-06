#!/bin/bash
# Script created by: Jóhannes G. Halldórsson
printf "About to install several vim extentions..."
printf "\nPrerequisites: vim wget git\n"
printf "\nYCM Auto-Complete: build-essential cmake python3-dev nodejs npm"
printf "\nYCM Auto-Complete extra: mono-complete (C#) golang (Go)"
printf " default-jdk (Java)\n"
printf "\nPython (3): python3-jedi python3-flake8 flake8"
printf " python3-flake8-docstrings"
printf "\nBash: python3-bashate python-bashate-doc"

printf "\nDo you want to continue (Y/n)?"
read user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

VIM_DIR="$HOME/.vim"

function pathogen_install {
        if [[ $# -eq 2 || $# -eq 3 ]]; then
                local gh_user=$1
                local gh_repo=$2
                if [[ $# -eq 3 ]]; then
                        local n_levels=$3
                else
                        local n_levels=""
                fi
        else
                printf "\nThis function accepts 2 or 3 arguments"
                printf "not $#.\n"
                exit 2
        fi
        local source_url="https://github.com/$gh_user/$gh_repo.git"
        local dest_dir="$VIM_DIR/bundle/$gh_repo"
        if [[ -z "$n_levels" ]]; then
                git clone $source_url $dest_dir
        else
                git clone --depth=$n_levels $source_url $dest_dir
        fi
}

printf "\nInstalling Pathogen\n"
mkdir -p $VIM_DIR/autoload $VIM_DIR/bundle
wget -O $VIM_DIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# GUI and Git

# Back-up color scheme
printf "\nInstalling Wombat256Mod\n"
pathogen_install michalbachowski vim-wombat256mod
export TERM=xterm-256color

# Main Color Scheme
printf "\nInstalling onedark\n"
pathogen_install joshdick onedark.vim

# Other GUI plugins
printf "\nInstalling vim-gitgutter\n"
pathogen_install airblade vim-gitgutter
printf "\nInstalling vim-airline\n"
pathogen_install vim-airline vim-airline
printf "\nInstalling vim-airline-themes\n"
pathogen_install vim-airline vim-airline-themes
printf "\nInstalling nerdtree\n"
pathogen_install scrooloose nerdtree
printf "\nInstalling nerdtree-git-plugin\n"
pathogen_install Xuyuanp nerdtree-git-plugin

# YouCompleteMe Auto-Complete

printf "\nInstalling YouCompleteMe Auto-Complete\n"

if [[ -d "$VIM_DIR/bundle/YouCompleteMe" ]]; then
        ALREADY_INSTALLED=1
else
        ALREADY_INSTALLED=0
fi

if [[ $ALREADY_INSTALLED -eq 0 ]]; then
        pathogen_install ycm-core YouCompleteMe
        working_dir=`pwd`
        cd $VIM_DIR/bundle/YouCompleteMe
        git submodule update --init --recursive
        python3 install.py --clangd-completer --ts-completer --rust-completer
        # Add to above for additional Auto-complete:
        # --cs-completer --go-completer --java-completer
        # Or --all for everything enabled.
        cd $working_dir
fi

# Ale Linter

printf "\nInstalling Ale Linter\n"
pathogen_install dense-analysis ale
# ESLint for JavaScript
npm -i -g eslint eslint-plugin-vue

# Python

printf "\nInstalling Python PEP-8 line length guide script and folding script.\n"
mkdir -p $VIM_DIR/ftplugin
cp ./python.vim $VIM_DIR/ftplugin/python.vim
source_url="http://www.vim.org/scripts/download_script.php?src_id=5492"
dest_dir="$VIM_DIR/ftplugin/python_editing.vim"
wget -O $dest_dir $source_url

# Web development

printf "\nInstalling Emmet-vim for HTML and CSS abbreviations\n"
pathogen_install mattn emmet-vim

printf "\nInstalling vim-css-color\n"
pathogen_install ap vim-css-color

printf "\nInstalling typescript-vim\n"
pathogen_install leafgarland typescript-vim

printf "\nInstalling vim-vue\n"
pathogen_install posva vim-vue

# Rust

printf "\nInstalling rust.vim\n"
pathogen_install rust_lang rust.vim 1

# Font

printf "\nDownloading powerline fonts\n"
git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
printf "\nInstalling powerline fonts\n"
~/fonts/install.sh
printf "\nCleaning up after fonts install\n"
rm -rf ~/fonts

printf "\nEnd of script\n"
