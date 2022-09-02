------------------------------------------------------
-- Utilities
------------------------------------------------------
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


------------------------------------------------------
-- Packer Plugins
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  --use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' }}

  use { 'tom-anders/telescope-vim-bookmarks.nvim' }

  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'tiagovla/tokyodark.nvim'

   -- require('telescope').load_extension('vim_bookmarks')

end)



------------------------------------------------------
-- Plug Installation
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'yegappan/bufselect'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug('ibhagwan/fzf-lua', { branch ='main'})
Plug 'kyazdani42/nvim-web-devicons'


Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'MattesGroeger/vim-bookmarks'

Plug 'vim-airline/vim-airline'
Plug 'kyazdani42/nvim-web-devicons'

-- Plug 'romgrk/barbar.nvim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-commentary'
Plug 'valloric/matchtagalways'
Plug 'Yggdroot/indentLine'

Plug('ms-jpq/coq_nvim', { branch = 'coq'})
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts'})
Plug('ms-jpq/coq.thirdparty', { branch = '3p'})

-- Themes
Plug 'altercation/vim-colors-solarized'
Plug 'thedenisnikulin/vim-cyberpunk'
Plug('dracula/vim', { as = 'dracula' })

-- Utilities
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'mileszs/ack.vim'
Plug 'preservim/nerdcommenter'

-- Git
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/unite.vim'

vim.call('plug#end')

vim.g.mapleader = " "

------------------------------------------------------
-- Plug Hotkey
map("n", "<C-f>", ":NERDTree<CR>", { silent = true })
-- map("n", "<Leader>b", ":FzfLua buffers<CR>", { silent = true })
map("n", "<C-p>", ":FzfLua git_files<CR>", { silent = true })
map("n", "<Leader>q", ":COQnow<CR>", { silent = true })
map("n", "<Leader>c", ":Commentary<CR>", { silent = true })

map("n", "<Leader>1", ":BufferPrevious<CR>")
map("n", "<Leader>2", ":BufferNext<CR>")
map("n", "<Leader>m", ":BookmarkShowAll<CR>")

map("n", "<Leader>r", ":source ~/.nvim/init.lua<CR>", { silent = true })



------------------------------------------------------
-- VIM Configuration

vim.cmd [[
  nnoremap <C-f> :NERDTreeFind<CR>
  nnoremap <leader>f :NERDTreeFind<CR>

  nnoremap <silent> <Leader>s :FixWhitespace<CR>
  nnoremap <silent> <Leader>cc :Commentary<CR>

  nnoremap <silent> <Leader>k :BookmarkShowAll<CR>
  nnoremap <silent> <Leader>b :Unite -start-insert buffer<CR>
  nnoremap <silent> bb :Unite -start-insert vim_bookmarks<CR>

  nmap mm :BookmarkToggle<CR>
  nmap mi :BookmarkAnnotate<CR>
  nmap mn :BookmarkNext<CR>
  nmap mp :BookmarkPrev<CR>
  nmap ma :BookmarkShowAll<CR>
  nmap mc :BookmarkClear<CR>
  nmap mx :BookmarkClearAll<CR>
  nmap mkk :BookmarkMoveUp
  nmap mjj :BookmarkMoveDown

  nmap <Leader>w :BufferClose<CR>
  nmap <Leader>p :BufferPin<CR>
  nmap <Leader>q :BufferCloseAllButPinned<CR>
  nmap <C-q> :BufferCloseAllButCurrent<CR>

  " Searching
  let g:ackprg = 'ag --vimgrep'
  let NERDTreeQuitOnOpen=1

  nnoremap <C-s> :Ack!<Space>

  set background=dark
  set clipboard=unnamedplus
  set completeopt=noinsert,menuone,noselect
  set cursorline
  set hidden
  set inccommand=split
  set mouse=a
  set number
  set relativenumber
  set splitbelow splitright
  set title
  set ttimeoutlen=0
  set wildmenu

  set expandtab
  set shiftwidth=2
  set tabstop=2
  filetype plugin indent on
  syntax on

  set termguicolors
  set cursorline
  let NERDTreeQuitOnOpen=1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1

  set noswapfile

  let g:bookmark_center = 1
  let g:bookmark_location_list = 1
  let g:bookmark_save_per_working_dir = 1
  let g:bookmark_auto_save = 1


]]


vim.cmd("colorscheme dracula")
vim.cmd("hi Normal ctermbg=none guibg=none")
