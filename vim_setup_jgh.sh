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
printf "\nPlantUML: graphviz (and java)"

printf "\nDo you want to continue (Y/n)?"
read user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

printf "\nAre you using Ubuntu-on-Windows to install for Windows(y/N)?"
read user_answer
if echo "$user_answer" | grep -iq "^y" ;then
    VIM_DIR="$HOME/vimfiles"
    FOR_WIN=1
    printf "You'll have to install YouCompleteMe, if you want "
    printf "it to work on Windows itself, manually, see URL:\n"
    printf "https://github.com/ycm-core/YouCompleteMe#windows "
    printf "\nSome additional work is needed, like installing "
    printf "fonts.\n\nDownloads will be placed in:\n$VIM_DIR\n"
    printf "You may need to copy them to your Windows home dir"
    printf "ectory, something like: \"C:\\Users\\<username>\" "
else
    VIM_DIR="$HOME/.vim"
fi

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
    if [[ -d "$dest_dir" ]]; then
        printf "\t\t$gh_repo seems to be already installed."
        return 0
    fi
    if [[ -z "$n_levels" ]]; then
        git clone $source_url $dest_dir
    else
        git clone --depth=$n_levels $source_url $dest_dir
    fi
}

printf "\nInstalling Pathogen\n"

PATHOGEN_PATH="$VIM_DIR/autoload/pathogen.vim"

if [[ -f $PATHOGEN_PATH ]]; then
    printf "\t\tPathogen seems to be already installed."
else
    mkdir -p $VIM_DIR/autoload $VIM_DIR/bundle
    wget -O $PATHOGEN_PATH https://tpo.pe/pathogen.vim
fi

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

# Color schemes
export TERM=xterm-256color

printf "\nInstalling Wombat256Mod\n"
pathogen_install michalbachowski vim-wombat256mod

printf "\nInstalling onedark\n"
pathogen_install joshdick onedark.vim

printf "\nInstalling wombat256grf\n"
pathogen_install gryf wombat256grf

printf "\nInstalling tokyonight-vim\n"
pathogen_install ghifarit53 tokyonight-vim

printf "\nInstalling vim-neon-dark\n"
pathogen_install nonetallt vim-neon-dark

printf "\nInstalling vim-monokai\n"
pathogen_install crusoexia vim-monokai

# YouCompleteMe Auto-Complete

printf "\nInstalling YouCompleteMe auto-complete\n"

if [[ -d "$VIM_DIR/bundle/YouCompleteMe" ]]; then
    YCM_ALREADY_INSTALLED=1
else
    YCM_ALREADY_INSTALLED=0
fi

pathogen_install ycm-core YouCompleteMe
if [[ $YCM_ALREADY_INSTALLED -eq 0 ]]; then
    working_dir=`pwd`
    cd $VIM_DIR/bundle/YouCompleteMe
    git submodule update --init --recursive
    python3 install.py --clangd-completer --ts-completer --rust-completer
    # Add to above for additional Auto-complete:
    # --cs-completer --go-completer --java-completer
    # Or --all for everything enabled.
    cd $working_dir
fi

# Syntastic syntax checker
printf "\nInstalling syntastic syntax checker\n"
pathogen_install vim-syntastic syntastic 1

# Ale Linter

printf "\nInstalling Ale linter\n"
if [[ -d "$VIM_DIR/bundle/ale" ]]; then
    printf "\t\tAle seems to be already installed."
else
    pathogen_install dense-analysis ale
    # ESLint for JavaScript
    npm install -g eslint eslint-plugin-vue
fi

# Style (mostly line-length) Guide Scripts

function ftplugin_install {
    if [[ $# -eq 1 ]]; then
        local language=$1
    else
        printf "\nThis function accepts 1 argument, not $#.\n"
        exit 1
    fi
    local src_path="./ftplugin/$language.vim"
    local dst_path="$VIM_DIR/ftplugin/$language.vim"
    printf "\nInstalling \"$language\" style-guide script.\n"
    if [[ -f $dst_path ]]; then
        printf "\t\tIt seems to be already installed."
    else
        cp -u $src_path $dst_path
    fi
}

if [[ ! -d "$VIM_DIR/ftplugin" ]]; then
    mkdir -p $VIM_DIR/ftplugin
fi

ftplugin_install css
ftplugin_install html
ftplugin_install javascript
ftplugin_install python
ftplugin_install rust
ftplugin_install sh

# Python

printf "\nInstalling Python code folding script.\n"
PYTHON_FOLDING_SCRIPT_PATH="$VIM_DIR/ftplugin/python_editing.vim"
if [[ -f $PYTHON_FOLDING_SCRIPT_PATH ]]; then
    printf "\t\tThe folding script seems to be already installed."
else
    VIM_URL="http://www.vim.org"
    PFS_SOURCE_URL="$VIM_URL/scripts/download_script.php?src_id=5492"
    wget -O $PYTHON_FOLDING_SCRIPT_PATH $PFS_SOURCE_URL
fi

# PlantUML Install
printf "\nInstalling open-browser.vim\n"
pathogen_install tyru open-browser.vim

printf "\nInstalling plantuml-syntax\n"
pathogen_install aklt plantuml-syntax

printf "\nInstalling plantuml-previewer.vim\n"
pathogen_install weirongxu plantuml-previewer.vim

# Web development

printf "\nInstalling Emmet-vim for HTML and CSS abbreviations\n"
pathogen_install mattn emmet-vim

printf "\nInstalling vim-css-color\n"
pathogen_install ap vim-css-color

printf "\nInstalling vim-javascript\n"
pathogen_install pangloss vim-javascript

printf "\nInstalling vim-vue-plugin\n"
pathogen_install leafOfTree vim-vue-plugin 1

printf "\nInstalling typescript-vim\n"
pathogen_install leafgarland typescript-vim

# Rust

printf "\nInstalling rust.vim\n"
pathogen_install rust-lang rust.vim 1

# Font

if [[ $FOR_WIN < 1 ]]; then
<<<<<<< HEAD
=======
    # NOTE: Supposedly this only works on Ubuntu.
>>>>>>> f0dd3651f9f0f10d551dcef16a65edd5e271f1f8
    # NOTE: This does work on Ubuntu-on-Windows to detect the Ubuntu state.
    font_test=`fc-list | grep -c -s Powerline`
else
    # NOTE: Is it possible to check the Windows fonts from Ubuntu on Windows?
    font_test=0
fi

if [[ $font_test > 0 ]]; then
    printf "\nPowerline fonts appear to be already installed. \n"
else
    printf "\nDownloading powerline fonts\n"
    git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
    printf "\nInstalling powerline fonts\n"
    ~/fonts/install.sh
    if [[ $FOR_WIN < 1 ]]; then
        # Not deleted on Windows for manual install.
        printf "\nCleaning up after fonts install\n"
        rm -rf ~/fonts
    fi
fi


printf "\nEnd of script\n"
exit 0

