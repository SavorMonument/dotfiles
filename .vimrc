set nocompatible

syntax enable
filetype plugin on

set nu
set hlsearch


"---------------------------------------
"- Preferences
"---------------------------------------

set tabstop=4
set softtabstop=4
"Uses tabstop value if zero
set shiftwidth=4
set textwidth=99
set expandtab
set autoindent
set fileformat=unix
set incsearch

cmap W w

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

augroup vimrc

autocmd!
autocmd WinEnter * :resize 1000

augroup END

"---------------------------------------
"- Session save
"---------------------------------------

" fu! Save_if_flag()
"     if g:save_session==1
"         execute ('mksession! $HOME/.vim/projects/' . g:project_name . '.vim')
"     endif
" endfunction

" autocmd VimLeave * call Save_if_flag()

"---------------------------------------
"- Theme
" Chosen color schemes are 
" 		    	   gruvbox(dark and light)
" 			   pencil(light)
" All themes need the background color from the terminal
"---------------------------------------

"Gruvbox theme
let g:gruvbox_contrast_dark='soft'

set t_Co=256
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
Plugin 'vimwiki/vimwiki'
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
let g:airline_theme='jsolarized'

"---------------------------------------
"- PythonSyntax
"---------------------------------------

let g:python_highlight_all=1
let g:python_highlight_space_errors = 0
hi link pythonFunctionCall pythonFunction

"---------------------------------------
"- pythonsense
"---------------------------------------

