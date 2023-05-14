set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath

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

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'jeetsukumaran/vim-pythonsense'
Plug 'vim-python/python-syntax'

Plug 'ap/vim-css-color'
Plug 'uiiaoo/java-syntax.vim'

" Theme
Plug 'vv9k/bogster'

" Snippets
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
Plug 'honza/vim-snippets'
call plug#end()

" ===================
" Bogster theme
" ===================

colorscheme bogster
hi Normal guibg=NONE ctermbg=NONE
highlight ColorColumn guibg=#263640

let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" ===================
" nvim-cmp
" ===================

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup {
    preselect = cmp.PreselectMode.None
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
        { name = 'snippy' }, -- For snippy users.
        { name = 'path' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  local servers = {'rust_analyzer', 'gopls', 'clangd', 'jedi_language_server', 'jdtls'}
  for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
      capabilities = capabilities
    }
  end

-- TAB completion

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local snippy = require("snippy")

  local cmp = require("cmp")

  cmp.setup({

    -- ... Your other configuration ...

    mapping = {

      -- ... Your other mappings ...

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snippy.can_expand_or_advance() then
          snippy.expand_or_advance()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif snippy.can_jump(-1) then
          snippy.previous()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ... Your other mappings ...
    },

    -- ... Your other configuration ...
  })
EOF

" ===================
" vim-commentary
" ===================

map \\ gcc
vmap \\ gc

" ===================
" Neofromat
" ===================

let g:neoformat_c_clangformat = {
              \ 'exe': 'clang-format',
              \ 'args': ['-assume-filename=.c', '-style="{IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: false}"'],
              \ 'stdin': 1,
              \ }

let g:neoformat_cpp_clangformat = {
              \ 'exe': 'clang-format',
              \ 'args': ['-style="{IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: false}"'],
              \ 'stdin': 1,
              \ }

let g:neoformat_rust_rustfmt = {
              \ 'exe': "rustfmt",
              \ 'args': ["--edition 2021"],
              \ 'stdin': 1,
              \ }

let g:neoformat_java_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-assume-filename=.java', '-style="{IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: false}"'],
            \ 'stdin': 1,
            \ }

let g:neoformat_jsp_custom = {
            \ 'exe': '/home/zzz1/xml-format/fxml.py',
            \ 'stdin': 0,
            \ 'valid_exit_codes': [0],
            \ }

let g:neoformat_html_custom = {
            \ 'exe': '/home/zzz1/xml-format/fxml.py',
            \ 'stdin': 0,
            \ 'valid_exit_codes': [0],
            \ }

let g:neoformat_enabled_jsp = ['custom']
let g:neoformat_enabled_html = ['custom']

noremap <space>w :Neoformat<CR>

" ===================
" Telescope
" ===================

nnoremap <space>f :Telescope find_files<CR>
nnoremap <space>g :Telescope live_grep<CR>
nnoremap <space>d :Telescope diagnostics<CR>
nnoremap <space>s :Telescope lsp_dynamic_workspace_symbols<CR>

nnoremap <space>a :lua vim.lsp.buf.code_action()<CR>

" ===================
" Lsp
" ===================

" lspconfig turn off top split preview
set completeopt-=preview

lua <<EOF
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
  buf_set_keymap('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '<space>c', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
 
  buf_set_keymap('n', '<space>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('i', '<C-q>', '<c-x><c-o>', opts)

  buf_set_keymap('n', '<C-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

local servers = {'rust_analyzer', 'gopls', 'clangd', 'jedi_language_server', 'jdtls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

