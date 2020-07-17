" vimplug
call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/deol.nvim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vuciv/vim-bujo'
call plug#end() 

" sets
set guicursor=
set number relativenumber
set mouse=a
set background=light
syntax enable
set cursorline
set ignorecase
set smartcase
set wildmenu                                      " Tab autocomplete in command mode
set autoread                                      " Auto reload changed files

" Spaces & Tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
colorscheme pencil
"hi Normal ctermbg=16 guibg=#000000
"hi LineNr ctermbg=16 guibg=#000000

" vim-bujo
nmap <C-N> <Plug>BujoAddnormal
imap <C-N> <Plug>BujoAddinsert
nmap <C-P> <Plug>BujoChecknormal
imap <C-P> <Plug>BujoCheckinsert

" deoplete
let g:deoplete#enable_at_startup = 1

" git gutter settings
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                     = '+'
let g:gitgutter_sign_modified                  = '±'
let g:gitgutter_sign_removed                   = '-'
let g:gitgutter_sign_removed_first_line        = '^'
let g:gitgutter_sign_modified_removed          = '#'

" vim-markdown 
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_yaml_frontmatter=1
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal=0

" nerdtree
let g:NERDTreeWinPos = "right"
map <C-i> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" insert centered
autocmd InsertEnter * norm zz

" shortcut split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" replace all using S
nnoremap S :%s//gI<Left><Left><Left>

" italic comments
hi Comment cterm=italic

" statusbar
scriptencoding utf-8

" cpp template
autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/skeleton.cpp

" statusline
hi PrimaryBlock   ctermbg=NONE ctermfg=8
hi ModeBlock      ctermbg=NONE ctermfg=2
hi SecondaryBlock ctermbg=NONE ctermfg=8
hi TeritaryBlock  ctermbg=NONE ctermfg=9
hi Blanks         ctermbg=NONE
hi statusline     ctermbg=NONE
let g:currentmode={
            \ 'n'  : 'NORMAL ',
            \ 'no' : 'N·OPERATOR PENDING ',
            \ 'v'  : 'VISUAL ',
            \ 'V'  : 'V·LINE ',
            \ '' : 'V·BLOCK ',
            \ 's'  : 'SELECT ',
            \ 'S'  : 'S·LINE ',
            \ '' : 'S·BLOCK ',
            \ 'i'  : 'INSERT ',
            \ 'R'  : 'REPLACE ',
            \ 'Rv' : 'V·REPLACE ',
            \ 'c'  : 'COMMAND ',
            \ 'cv' : 'VIM EX ',
            \ 'ce' : 'EX ',
            \ 'r'  : 'PROMPT ',
            \ 'rm' : 'MORE ',
            \ 'r?' : 'CONFIRM ',
            \ '!'  : 'SHELL ',
            \ 't'  : 'TERMINAL '}
set statusline=
set statusline+=%#ModeBlock#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#TeritaryBlock#
set statusline+=\ %f\ 
set statusline+=%M\ 
set statusline+=%#Blanks#
set statusline+=%=
set statusline+=%#PrimaryBlock#
set statusline+=\ %Y\ 
set statusline+=%#SecondaryBlock#
set statusline+=\ %P\ 
