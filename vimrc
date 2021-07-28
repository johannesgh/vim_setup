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
" Allows dealing with multiple unsaved buffers.
set hidden

" better indentation of code blocks in visual mode
vnoremap < <gv
vnoremap > >gv

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Formatting tabs/indentation
" Automatic indentation
set autoindent
" Round to even indentation levels
set shiftround
" Set default indent size to 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
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

call pathogen#infect()
call pathogen#helptags()

" ============================================================================
" wombat256mod setup (Backup Color Scheme)
" ============================================================================

" Using wombat256mod color scheme through Pathogen
" Shell command "echo $TERM" should print 'xterm-256color'.
" If it doesn't set it with this shell command:
" export TERM=xterm-256color
set t_Co=256
color wombat256mod

" ============================================================================
" vim-airline setup
" ============================================================================

" Settings for vim-airline and vim-airline-themes
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" ============================================================================
" ############################################################################
" ###############################COLOUR SCHEMES###############################
" ############################################################################
" ============================================================================

" onedark
" colorscheme onedark
" let g:airline_theme = 'onedark'

" wombat256grf
" colorscheme wombat256grf

" tokyonight-vim
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
colorscheme tokyonight
let g:airline_theme = 'tokyonight'

" vim-neon-dark
" colorscheme neon-dark-256

" vim-monokai
" colorscheme monokai

" ============================================================================
" ############################################################################
" ============================================================================

" ============================================================================
" vim-gitgutter setup
" ============================================================================

" This is a native vim option but it's lowered from 4s for this plugin
set updatetime=500

" ============================================================================
" nerdtree setup
" ============================================================================

" Ctrl+t shortcut to open it
map <C-t> :NERDTreeToggle<CR>

" ============================================================================
" Better navigation for the OmniPopup
" ============================================================================

" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" This answer: https://stackoverflow.com/a/61500480

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><Cr> pumvisible() ? "\<C-y>\<C-c>" : "\<Cr>"

" ============================================================================
" Python ftplugin setup
" ============================================================================

" Python function and class folding
set nofoldenable

" ============================================================================
" Emmet-vim settings
" ============================================================================

" Plugin only works in Normal mode.
let g:user_emmet_mode='n'
" Leader key now ','; press comma twice to expand abbreviation.
let g:user_emmet_leader_key=','
" Emmet is only active inside html and css files.
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall

" ============================================================================
" vim-vue-plugin settings
" ============================================================================

let g:vim_vue_plugin_config = {
        \"syntax": {
        \    "template": ["html"],
        \    "script": ["javascript"],
        \    "style": ["css"],
        \},
        \"full syntax": [],
        \"initial_indent": [],
        \"attribute": 1,
        \"keyword": 1,
        \"foldexpr": 0,
        \"debug": 0,
        \}

" ============================================================================
" typescript-vim settings
" ============================================================================

" Turning off indenter
let g:typescript_indent_disable = 1

" ============================================================================
" gVim settings
" ============================================================================

if has("gui_running")
        set lines=36 columns=128 linespace=0
        if has("unix")
                " Linux font
                set guifont=Anonymous\ Pro\ for\ Powerline\ 14
        elseif has("gui_win32")
                " Windows font
                set guifont=Anonymice_Powerline:h14:cANSI:qDRAFT
        " elseif has("gui_macvim")
                " Mac font
                " Haven't tried this on Mac,
                " so I don't know what to put here.
        else
                " Default font
                set guifont=Anonymous\ Pro\ for\ Powerline\ 14
        endif
endif

