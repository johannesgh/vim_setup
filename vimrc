" Jóhannes G. Halldórsson .vimrc file
" modified from sample file by Martin Brochhaus
" https://github.com/mbrochh/vim-as-a-python-ide/blob/master/.vimrc
" This vimrc is optimized for python programming

" Turn off vi compatibility in case of "vim -u some_file"
set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Inbuilt file search settings
" Add starting folder recursively to search path
set path+=**
" Nice inbuilt search menu, select with tab and shift+tab
set wildmenu

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed

" Rebind <Leader> key to comma.
let mapleader = ","

" Bind nohl
" Removes highlight of your last search with Ctrl+N
noremap <C-n> :nohl<CR>

" bind Ctrl+<movement> keys to move around the windows,
" instead of using Ctrl+w + <movement>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
" Max number of tabs
set tabpagemax=8
" Show tab labels: 0=never, 1=if n tabs > 1, 2=always
set showtabline=2

" better indentation of code blocks in visual mode
vnoremap < <gv  "
vnoremap > >gv  " better indentation
" Try to go into visual mode (v), then select several lines of code here and
" then press ``>`` several times.

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Formatting tabs/indentation
" Automatic indentation
set autoindent
" Round to even indentation levels
set shiftround
" Convert tabs to spaces
set expandtab

" Showing line numbers and length
set number  " show line numbers
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Underline cursor's current line
set cursorline

" Turning filetype detection off
filetype off
" Turning it back on with plugins and indents
filetype plugin indent on

" Enable syntax highlighting
syntax enable
let python_highlight_all = 1

" Set the fileformat to unix for safety and GitHub compatibility.
set fileformat=unix
set encoding=utf-8

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" ============================================================================
" Pathogen setup
" ============================================================================

" Setting up Pathogen to manage plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now any plugin can be installed into a .vim/bundle/plugin-name/ folder
call pathogen#infect()
call pathogen#helptags()

" ============================================================================
" wombat256mod setup
" ============================================================================

" Using wombat256mod color scheme through Pathogen
" cd ~/.vim/bundle
" git clone https://github.com/michalbachowski/vim-wombat256mod
" Shell command "echo $TERM" should print 'xterm-256color'.
" If it doesn't set it with this shell command:
" export TERM=xterm-256color
set t_Co=256
color wombat256mod

" ============================================================================
" vim-gitgutter setup
" ============================================================================

" Installing Git monitoring plugin vim-gitgutter
" It shows git diff (+ & -) in the gutter (sign column)
" cd ~/.vim/bundle
" git clone git://github.com/airblade/vim-gitgutter.git
" This is a native vim option but it's lowered from 4s for this plugin
set updatetime=500

" ============================================================================
" vim-airline setup
" ============================================================================

" Installing status/tabline plugin (Powerline replacement) vim-airline
" cd ~/.vim/bundle
" git clone https://github.com/vim-airline/vim-airline
" git clone https://github.com/vim-airline/vim-airline-themes

" Installing Powerline patched fonts.
" See https://github.com/powerline/fonts for what fonts are available
" cd ~
" git clone https://github.com/powerline/fonts.git --depth=1
" fonts/install.sh
" rm -rf fonts

" Settings for vim-airline and vim-airline-themes
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" ============================================================================
" nerdtree setup
" ============================================================================

" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
" git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git
" Ctrl+t shortcut to open it
map <C-t> :NERDTreeToggle<CR>
" Move it to the right side of the screen.
" let g:NERDTreeWinPos = "right"

" ============================================================================
" jedi-vim setup
" ============================================================================
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git

let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" ============================================================================
" vim-flake8 setup
" ============================================================================
" cd ~/.vim/bundle
" git clone git://github.com/nvie/vim-flake8.git
" Use Flake8 linter on every write to a Python file.
autocmd BufWritePost *.py call Flake8()

" ============================================================================
" j and k for OmniCppComplete
" ============================================================================

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" ============================================================================
" Python ftplugin setup
" ============================================================================

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

