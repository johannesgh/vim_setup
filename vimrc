" Jóhannes G. Halldórsson .vimrc file
" Started my modding sample from Martin Brochhaus, original here:
" https://github.com/mbrochh/vim-as-a-python-ide/blob/master/.vimrc

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

" Rebind <Leader> key to the spacebar.
let mapleader = "<Space>"

" Bind nohl
" Removes highlight of your last search with Ctrl+N
noremap <C-n> :nohl<CR>

" bind Ctrl+<movement> keys to move around the windows,
" instead of using Ctrl+w + <movement>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" easier moving between tabs
noremap <leader>n :tabprevious<CR>
noremap <leader>m :tabnext<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 10gt

" Max number of tabs
set tabpagemax=10
" Show tab header: 0=never, 1=if n tabs > 1, 2=always
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
set number          " show line numbers
set relativenumber  " show relative numbers, both results in hybrid numbers
set nowrap          " don'tautomatically wrap on load
set fo-=t           " don'tautomatically wrap text when typing

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Underline cursor's current line
set cursorline

" Filetype detection settings
filetype off
filetype plugin indent on

" Enable syntax highlighting
let python_highlight_all = 1
syntax enable

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
" ALE config (apparently goes before plugins are loaded)
" ============================================================================

let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_linters_explicit = 1
let g:ale_linters = {
\        'shell': ['bashate', 'language_server', 'shell', 'shellcheck'],
\        'python': ['flake8', 'mypy', 'pylint', 'pyright', 'ruff'],
\        'rust': ['analyzer', 'cargo', 'cspell'],
\        'vim': ['ale_custom_linting_rules', 'vimls', 'vint'],
\        'vue': ['vls', 'eslint'],
\        'html': ['alex', 'angular', 'cspell', 'eslint', 'fecs', 'htmlhint', 
\                 'proselint', 'stylelint', 'tidy', 'vscodehtml', 'writegood'],
\        'css': ['cspell', 'csslint', 'fecs', 'stylelint', 'vscodecss'],
\        'javascript': ['cspell', 'deno', 'eslint', 'fecs', 'flow', 'flow_ls',
\                       'jscs', 'jshint', 'standard', 'tsserver', 'xo'],
\        'typescript': ['cspell', 'deno', 'eslint', 'standard', 'tslint',
\                       'tsserver', 'typecheck', 'xo'],
\        'markdown': ['alex', 'cspell', 'languagetool', 'markdownlint', 
\                     'marksman', 'mdl', 'proselint', 'redpen', 'remark_lint',
\                     'textlint', 'vale', 'writegood'],
\        'text': ['alex', 'cspell', 'languagetool', 'proselint', 'redpen',
\                 'textlint', 'vale', 'writegood']
\}
" ============================================================================
" Pathogen setup
" ============================================================================

call pathogen#infect()
call pathogen#helptags()

" Shell command "echo $TERM" should print 'xterm-256color'.
" If it doesn't set it with this shell command:
" export TERM=xterm-256color

" ============================================================================
" wombat256mod (Backup Color Scheme)
" ============================================================================

set t_Co=256
color wombat256mod

" ============================================================================
" Tokyo-night (Default Color Scheme)
" ============================================================================

set termguicolors
let g:tokyonight_style = 'night'
let g:tokyonight_transparent_background = 1
let g:tokyonight_menu_selection_background = 'green'
let g:tokyonight_disable_italic_comment = 1
let g:tokyonight_enable_italic = 0
let g:tokyonight_cursor = 'auto'
colorscheme tokyonight

" ============================================================================
" More Pathogen plugins
" ============================================================================

" Settings for vim-airline and vim-airline-themes
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'powerlineish'
let g:airline_theme = 'tokyonight'
let g:airline#extensions#ale#enabled = 1

" minimap setup
let g:minimap_width = 16
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_git_colors = 1

" vim-gitgutter setup
" This is a native vim option but it's lowered from 4s for this plugin
set updatetime=1000

" nerdtree setup
" Ctrl+t shortcut to open it
map <C-t> :NERDTreeToggle<CR>

" Better navigation for the OmniPopup
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" This answer: https://stackoverflow.com/a/61500480

inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><Cr> pumvisible() ? "\<C-y>\<C-c>" : "\<Cr>"

" Python ftplugin setup
" Python function and class folding
set nofoldenable

" Emmet-vim settings
" Plugin only works in Normal mode.
let g:user_emmet_mode='n'
" Leader key now ','; press comma twice to expand abbreviation.
let g:user_emmet_leader_key=','

" Emmet is only active inside html and css files.
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall

" vim-vue-plugin settings
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

" typescript-vim settings
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

" ============================================================================
" Ubuntu-on-Windows fixes for Vim.
" ============================================================================

" Vim starting in REPLACE mode.
set t_u7=
set ambiwidth=single

" Disabling bell sound.
set visualbell
set t_vb=

" ============================================================================
" Cursor changes shape based on mode.
" ============================================================================

"	Cursor settings:

"	1 -> blinking block
"	2 -> solid block 
"	3 -> blinking underscore
"	4 -> solid underscore
"	5 -> blinking vertical bar
"	6 -> solid vertical bar

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[1 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

