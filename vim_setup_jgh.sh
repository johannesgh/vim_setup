#!/bin/bash
# Script created by: Jóhannes G. Halldórsson
REQ_PCKGS="vim wget git git-delta fzf bat the_silver_searcher ripgrep perl \
    nodejs npm graphviz jdk-openjdk openjdk-doc plantuml shellcheck \
    bash-language-server clang marksman texlive-bin texlab yamllint libxml2 \
    deno python-lsp-server python-rope python-pyflakes python-pycodestyle \
    universal-ctags"
printf "About to install several vim extentions and prerequisites."
printf "You need to have already installed Rust.\n\nAnd if you're on Ubuntu"
printf "you need to read through this script before running it!"
printf "\nDo you want to continue (Y/n)?"
read -r user_answer
if echo "$user_answer" | grep -iq "^n" ;then
    exit 1
fi

printf "\nAre you using WSL (Windows Subsystem for Linux)"
printf " to install vim for Windows (y/N)?"
read -r user_answer
if echo "$user_answer" | grep -iq "^y" ;then
    VIM_DIR="$HOME/vimfiles"
    FOR_WIN=1
    printf "You'll have to install the ALE stuff, if you want "
    printf "it to work on Windows itself, manually. Good luck!"
    printf "\nSome additional work is needed, like installing "
    printf "fonts.\n\nDownloads will be placed in:\n%s\n" "$VIM_DIR"
    printf "You'll need to copy them to your Windows home dire"
    printf "ctory, by which I mean: \"C:\\Users\\<username>\" "
else
    VIM_DIR="$HOME/.vim"
    printf "\nAre you on Ubuntu or Arch (u/A)?"
    read -r user_answer
    if echo "$user_answer" | grep -iq "^u" ;then
        # graphviz pulls in headless Java on Ubuntu
        REQ_PCKGS=$(echo "$REQ_PCKGS" | sed -e "s/bat/bat-cat/"\
         -e "s/the_silver_searcher/silversearcher-ag/" \
         -e "s/ripgrep/rust-ripgrep/" \
         -e "s/jdk-openjdk\s//" \
         -e "s/openjdk-doc\s//" \
         -e "s/bash-language-server\s//" \
         -e "s/clang/clangd/" \
         -e "s/marksman\s//" \
         -e "s/texlive-bin/texlive-binaries/" \
         -e "s/texlab\s//" \
         -e "s/libxml2/libxml2-utils/" \
         -e "s/deno\s//" \
         -e "s/python-lsp-server/python3-pylsp/" \
         -e "s/python-rope/rope/" \
         -e "s/python-pyflakes/pyflakes/" \
         -e "s/python-pycodestyle/pycodestyle/" \
        )
        printf "\nThese are the required packages:\n%s\n" "$REQ_PCKGS"
        sudo apt update && sudo apt upgrade
        sudo apt install "$REQ_PCKGS"
        sudo snap install bash-language-server --classic
        sudo snap install marksman
        cargo install --git https://github.com/latex-lsp/texlab --locked \
            --tag 5.22.1 # NOTE: Go and check what's new before running this.
        npm install -g deno
    else
        printf "\nThese are the required packages:\n%s\n" "$REQ_PCKGS"
        sudo pacman -Syu "$REQ_PCKGS"
    fi
    npm install -g cspell vim-language-server sql-lint jsonlint \
        htmlhint csslint vls
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
        printf "\nThis function accepts 2 or 3 arguments not %s.\n" "$#"
        exit 2
    fi
    local source_url="https://github.com/$gh_user/$gh_repo.git"
    local dest_dir="$VIM_DIR/bundle/$gh_repo"
    if [[ -d "$dest_dir" ]]; then
        printf "\t\t%s seems to be already installed." "$gh_repo"
        return 0
    fi
    if [[ -z "$n_levels" ]]; then
        git clone "$source_url" "$dest_dir"
    else
        git clone --depth="$n_levels" "$source_url" "$dest_dir"
    fi
}

printf "\nInstalling Pathogen\n"

PATHOGEN_PATH="$VIM_DIR/autoload/pathogen.vim"

if [[ -f $PATHOGEN_PATH ]]; then
    printf "\t\tPathogen seems to be already installed."
else
    mkdir -p "$VIM_DIR"/autoload "$VIM_DIR"/bundle
    wget -O "$PATHOGEN_PATH" https://tpo.pe/pathogen.vim
fi

# Ale Linter
printf "\nInstalling Ale linter\n"
pathogen_install dense-analysis ale

# Vim-polyglot language pack collection.
printf "\nInstalling vim-polyglot\n"
pathogen_install sheerun vim-polyglot 1

# Fuzzy finder plugin.
printf "\nInstalling fzf.vim\n"
pathogen_install junegunn fzf.vim

# GUI plugins
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
printf "\nInstalling minimap\n"
pathogen_install wfxr minimap.vim

# Color schemes
export TERM=xterm-256color

printf "\nInstalling Wombat256Mod\n"
pathogen_install michalbachowski vim-wombat256mod
printf "\nInstalling tokyonight-vim\n"
pathogen_install ghifarit53 tokyonight-vim

# Style (mostly line-length) Guide Scripts
function ftplugin_install {
    if [[ $# -eq 1 ]]; then
        local language=$1
    else
        printf "\nThis function accepts 1 argument, not %s.\n" "$#"
        exit 1
    fi
    local src_path="./ftplugin/$language.vim"
    local dst_path="$VIM_DIR/ftplugin/$language.vim"
    printf "\nInstalling \"%s\" style-guide script.\n" "$language"
    if [[ -f $dst_path ]]; then
        printf "\t\tIt seems to be already installed."
    else
        cp -u "$src_path" "$dst_path"
    fi
}

if [[ ! -d "$VIM_DIR/ftplugin" ]]; then
    mkdir -p "$VIM_DIR"/ftplugin
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
    wget -O "$PYTHON_FOLDING_SCRIPT_PATH" "$PFS_SOURCE_URL"
fi

# PlantUML Install
printf "\nInstalling open-browser.vim\n"
pathogen_install tyru open-browser.vim

printf "\nInstalling plantuml-syntax\n"
pathogen_install aklt plantuml-syntax

printf "\nInstalling plantuml-previewer.vim\n"
pathogen_install weirongxu plantuml-previewer.vim

# Web development

printf "\nInstalling Emmet-vim for HTML and CSS abbreviations.\n"
pathogen_install mattn emmet-vim

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

if [[ $FOR_WIN -lt 1 ]]; then
    # NOTE: This does work on Ubuntu-on-Windows to detect the Ubuntu state.
    font_test=$(fc-list | grep -c -s Powerline)
else
    # NOTE: Is it possible to check the Windows fonts from Ubuntu on Windows?
    font_test=0
fi

if [[ $font_test -gt 0 ]]; then
    printf "\nPowerline fonts appear to be already installed.\n"
else
    printf "\nDownloading powerline fonts.\n"
    git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
    printf "\nInstalling powerline fonts.\n"
    ~/fonts/install.sh
    if [[ $FOR_WIN -lt 1 ]]; then
        # Not deleted on Windows for manual install.
        printf "\nCleaning up after fonts install.\n"
        rm -rf ~/fonts
    fi
fi

printf "\nEnd of script.\n"
exit 0

