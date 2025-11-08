" nnoremap <space>f :call VSCodeNotify('workbench.action.files.openFile')<CR>

echom "VSCode Neovim config loaded!"

call plug#begin()
Plug 'sbdchd/neoformat'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
call plug#end()
