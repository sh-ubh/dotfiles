" vimplug
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'lervag/vimtex'
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
colorscheme plain
"hi Normal ctermbg=16 guibg=#000000
"hi LineNr ctermbg=16 guibg=#000000

let mapleader=" "

" Alias write and quit to Q
nnoremap <leader>q :wq<CR>
nnoremap <leader>w :w<CR>

" Save file as sudo when no sudo permissions
cmap w!! w !sudo tee > /dev/null %

" vim-bujo
nmap <C-N> <Plug>BujoAddnormal
imap <C-N> <Plug>BujoAddinsert
nmap <C-P> <Plug>BujoChecknormal
imap <C-P> <Plug>BujoCheckinsert

" nerdtree
let g:NERDTreeWinPos = "right"
map <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" system clipboard
" set clipboard+=unnamedplus

" Fix indenting visual block
vmap < <gv
vmap > >gv

" git gutter settings
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1

" vim-markdown 
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_yaml_frontmatter=1
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal=0

" vimtex
let g:tex_flavor = 'latex'

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

" templates
autocmd BufNewFile * silent! 0r $HOME/.config/nvim/templates/skelton.%:e

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

" ------COC SETTINGS------
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-clangd',
  \ 'coc-python',
  \ 'coc-sh',
  \ 'coc-vimtex'
  \ ]

" From Coc Readme
set updatetime=300

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <rn> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
