" vimplug
call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/deol.nvim'
Plug 'ap/vim-css-color'
Plug 'luochen1990/rainbow'
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
set background=dark
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
colorscheme bloodbath
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

" rainbow
let g:rainbow_active = 1

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

" statusline
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

hi PrimaryBlock       ctermfg=00    ctermbg=6
hi SecondaryBlock     ctermfg=07    ctermbg=10
hi Blanks             ctermfg=00    ctermbg=11

hi User1             ctermfg=01    ctermbg=0
hi User2             ctermfg=02    ctermbg=0
hi User3             ctermfg=03    ctermbg=0
hi User4             ctermfg=04    ctermbg=0
hi User5             ctermfg=05    ctermbg=0
hi User6             ctermfg=06    ctermbg=0
hi User7             ctermfg=07    ctermbg=0
hi User8             ctermfg=08    ctermbg=0
hi User9             ctermfg=09    ctermbg=0

highlight EndOfBuffer ctermfg=black ctermbg=black

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'* '.l:branchname.'  ':''
endfunction

function! ReadOnly() abort
    if !&modifiable && &readonly
        return ' RO'
    elseif &modifiable && &readonly
        return 'RO'
    elseif !&modifiable && !&readonly
        return ''
    else
        return ''
    endif
endfunction

function! Filepath() abort
    let l:basename = expand('%:h')
    let l:filename = expand('%:t')
    let l:extension = expand('%:e')
    let l:prefix = (l:basename ==# '' || l:basename ==# '.') ?
                \ '' : substitute(l:basename . '/', '\C^' . $HOME, '~', '')

    if empty(l:prefix) && empty(l:filename)
        return printf('%%8*%%f%%*%s %%m%%*', '%8*')
    elseif empty(l:prefix)
        return printf('%%8*%%f%%*%s %%m%%*', '%6*')
    else
        return printf('%%8*%s%%*%s%s%%*', l:prefix, &modified ? '%6*' : '%8*', l:filename)
    endif
endfunction

function! LinterStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, printf('%%5*%s×%%*', info['error']))
  endif
  if get(info, 'warning', 0)
    call add(msgs, printf('%%3*%s!%%*', info['warning']))
  endif
  return join(msgs, ' ')
endfunction

function! StatusLine(mode) abort
  let l:line=''

  " help or man pages
  if &filetype ==# 'help' || &filetype ==# 'man'
    let l:line.=' %#StatusLineNC# ['. &filetype .'] %f '
    return l:line
  endif

  " active
  if a:mode ==# 'active'
    let l:line.='%7*%{StatuslineGit()}'
    let l:line.='%<'
    let l:line.=Filepath()

    let l:line.='%5*'
    let l:line.=' %{ReadOnly()} %w%*'
    let l:line.='%9* %=%*'

    let l:line.='%7* %l,%c  %*'
    let l:line.='%8* %{g:currentmode[mode()]}%*'
    let l:line.=' '
    let l:line.=LinterStatus()
    let l:line.=' '
    let l:line.='%8*'. &filetype

  else
    " inactive
    let l:line.='%#Blanks#'
    let l:line.='%f %5*%m%*'
    let l:line.='%#Blanks# %=%*'
  endif

  let l:line.='%*'

  return l:line
endfunction

set statusline=%!StatusLine('active')
augroup MyStatusLine
  autocmd!
  autocmd WinEnter * setl statusline=%!StatusLine('active')
  autocmd WinLeave * setl statusline=%!StatusLine('inactive')
augroup END
