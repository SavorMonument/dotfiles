set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath

syntax enable
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

set termguicolors
set mouse=a

" Aliases
command Wq wq
command WQ wq
command Wqa wqa
command WQa wqa
command WQA wqa
command Q q
command Qa qa
command W w

" Splits
nnoremap <C-Left> <C-W><C-H>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Down> <C-W><C-J>

vmap <C-C> "+y

call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
" Plug 'sbdchd/neoformat'
" Plug 'cloudhead/neovim-fuzzy'
Plug 'SavorMonument/neovim-fuzzy', {'branch': 'rg_options'}
Plug 'jeetsukumaran/vim-pythonsense'

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'ervandew/supertab'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

Plug 'ap/vim-css-color'

" Theme
" Plug 'rktjmp/lush.nvim'
" Plug 'adisen99/codeschool.nvim'
Plug 'vv9k/bogster'

call plug#end()

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif

" let g:codeschool_contrast_dark = "hard"
" let g:codeschool_transparent_bg = v:true
colorscheme bogster
hi Normal guibg=NONE ctermbg=NONE

let g:deoplete#enable_at_startup = 1

" vimwiki

let g:vimwiki_list = [{'path': '~/.vim/vimwiki/',
                    \ 'syntax': 'markdown', 'ext': '.md'}]

" vim-commentary

map \\ gcc
vmap \\ gc

" neoformat

"let g:neoformat_c_clangformat = {
"              \ 'exe': 'clang-format',
"              \ 'args': ['-assume-filename=' . expand('%:t'), '-style="{IndentWidth: 2, ColumnLimit: 120, AllowShortFunctionsOnASingleLine: false}"'],
"              \ 'stdin': 1,
"              \ }

"augroup fmt
"  autocmd!
"  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
"augroup END

" neovim-fuzzy

nnoremap <space>f :FuzzyOpen<CR>
nnoremap <space>g :FuzzyGrep<CR>
let g:fuzzy_rg_args = ["--no-ignore-vcs", "--ignore-file=".$HOME."/.vfignore"]

" lspconfig turn off top split preview
set completeopt-=preview

" nvim-treesitter

" Disable error highlighting
hi! TSError ctermbg=none

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local nvim_lsp = require('lspconfig')
-- vim.lsp.set_log_level("debug")

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
 vim.lsp.handlers.signature_help, {

 }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- stops gutter from moving around
  -- buf_set_option('signcolumn', 'yes:1')
  vim.o.signcolumn = "yes:1"
  -- Supertab triggger
  -- vim.api.nvim_buf_set_var(bufnr, 'SuperTabDefaultCompletionType', '<c-x><c-o>')

  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('i', '<TAB>', '<cmd>lua vim.lsp.omnifunc()<CR>', opts)

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<C-d>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<space>c', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '<space>a', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('i', '<C-q>', '<c-x><c-o>', opts)

  buf_set_keymap('n', '<C-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

local servers = { 'pylsp', 'rust_analyzer', 'gopls', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF



