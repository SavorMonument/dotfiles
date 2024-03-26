" set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
" let &packpath = &runtimepath

" set clipboard=unnamedplus
set nocompatible
filetype plugin on
syntax on

set nu
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=120
set expandtab
set autoindent
set fileformat=unix
set guicursor=i:block
set noswapfile
set cc=100

set termguicolors
set mouse=a

" Aliases
command! Wq wq
command! WQ wq
command! Wqa wqa
command! WQa wqa
command! WQA wqa
command! Q q
command! Qa qa
command! W w

" Splits
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Down> <C-W><C-J>

nnoremap <C-h> <C-W><C-H>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-j> <C-W><C-J>

" Quotes and paran close
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
