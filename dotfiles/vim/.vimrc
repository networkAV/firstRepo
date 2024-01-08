""""""""""""""""""""""""""""""""""""""""""""""""
" Setup plugins
""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

" NERD tree - tree explorer
"" " configure vim packages
"Plugin 'scrooloose/nerdtree'

" Vimwiki
"" "Plugin 'vimwiki/vimwiki'

filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""

" turn off search highlight with ,-<space>
"nnoremap <leader><space> :nohlsearch<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
" General Configuration
""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically update a file if it is changed externally
"" "set autoread

" Height of the command bar
set cmdheight=2

"" "set hlsearch	    " highlight search matches
"" "set incsearch	    " search while characters are entered

" search is case-insensitive by default
set ignorecase

" Show linenumbers
"" "set number

set showcmd	" show last command in the bottom right

set ruler	" always show current position

" Line wrap (number of cols)
"set wrap	    " wrap lines only visually
"set linebreak	    " wrap only at valid characters
"set textwidth=0	    " prevent vim from inserting linebreaks
"set wrapmargin=0    "   in newly entered text

" show matching braces
set showmatch

set wildmenu	    " visual autocomplete for command menu

""""""""""""""""""""""""""""""""""""""""""""""""
" Backups, Swap Files
""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" UTF-8 encoding and en_US as default encoding/language
set encoding=utf8

" Define standard filetype
set ffs=unix,dos,mac

colorscheme ron
"" "set background=dark

"" "set cursorline	" highlight current active line

""""""""""""""""""""""""""""""""""""""""""""""""
" File Types
""""""""""""""""""""""""""""""""""""""""""""""""
" recognize .md files as markdown files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" enable spell-checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

""""""""""""""""""""""""""""""""""""""""""""""""
" Text and Indentation
""""""""""""""""""""""""""""""""""""""""""""""""
" Use smart tabs
set smarttab

"" "set expandtab " use spaces, no tabs

" 1 tab == 4 spaces
"" "set shiftwidth=4
"" "set softtabstop=4

set ai " Auto indent
set si " Smart indent

" modern backspace behavior
"" "set backspace=indent,eol,start

filetype indent on	" enable filetype specific indentation

""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""""""""""
" move vertically by visual line (don't skip wrapped lines) 
"nnoremap j gj
"nnoremap k gk


""""""""""""""""""""""""""""""""""""""""""""""""
" vimwiki
""""""""""""""""""""""""""""""""""""""""""""""""
" automatically generate HTML files
"" "let g:vimwiki_list = [{'path': '~/vimwiki/', 'auto_export': 1}]


""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""
" show hidden files
"" "let NERDTreeShowHidden=1

" open/close NERDTree using Leader-f (,-f)
"" "nnoremap <Leader>f :NERDTreeToggle<Enter>
