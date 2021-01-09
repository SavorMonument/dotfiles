"---------------------------------------
"- Preferences
"---------------------------------------
set nocompatible
syntax enable
filetype plugin on
" let g:python_recommended_style = 1

set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix

set hlsearch " highlight all results of a search
set incsearch " highlight first result of search whilst typing
" set ignorecase " Use case insensitive search
" set smartcase  "except when using capital letters

command Wq wq
command Wqa wqa
command Q q
command W w

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"---------------------------------------
"- Theme
" Chosen color schemes are 
" 		    	   gruvbox(dark and light)
" 			   pencil(light)
" All themes need the background color from the terminal
"---------------------------------------

set termguicolors

"Gruvbox theme
let g:gruvbox_contrast_dark='soft'

"Set them here
set background=dark
colorscheme gruvbox

"Remove background color so the terminal color shows
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE

"---------------------------------------
"- Templates
"---------------------------------------

function Pclass()
    read ~/.vim/templates/pclass.py
    normal w
    startinsert
endfunction

function Pcmethod()
    normal! "myiw
    normal! w
    normal! "pyi(
endfunction

function Ppmethod()
    read ~/.vim/templates/pmethod.py
    normal! e
    normal! l
    normal! "mp
    normal! ee
    exec 'normal a, '
    normal! "pp
endfunction

noremap \cm :call Pcmethod()<CR>
noremap \pm :call Ppmethod()<CR>
noremap \pc :call Pclass()<CR>

"---------------------------------------
"- Vundle
"---------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-commentary'
Plugin 'ap/vim-css-color'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-python/python-syntax'
Plugin 'ervandew/supertab'
Plugin 'jeetsukumaran/vim-pythonsense'

" All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on 
" filetype plugin on

"---------------------------------------
"- VimWiki
"---------------------------------------

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"---------------------------------------
"- vim-comentary
"---------------------------------------

map \\ gcc
vmap \\ gc

"---------------------------------------
"- Airline
"---------------------------------------

let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='jsolarized'

"---------------------------------------
"- PythonSyntax
"---------------------------------------

let g:python_highlight_all=1
let g:python_highlight_space_errors = 0
hi link pythonFunctionCall pythonFunction

"---------------------------------------
"- pythonsense
"---------------------------------------

