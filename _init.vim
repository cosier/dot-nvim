call plug#begin()
  " Core
	Plug 'lambdalisue/suda.vim'
	Plug 'yegappan/bufselect'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	" Appearance
	Plug 'vim-airline/vim-airline'
	Plug 'ryanoasis/vim-devicons'

	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'romgrk/barbar.nvim'
	Plug 'tomasr/molokai'
	Plug 'bronson/vim-trailing-whitespace'
	"Plug 'altercation/vim-colors-solarized'
	Plug 'tpope/vim-commentary'
	Plug 'valloric/matchtagalways'
	Plug 'Yggdroot/indentLine'

	" Themes
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'thedenisnikulin/vim-cyberpunk'


	" Utilities
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'sheerun/vim-polyglot'
	Plug 'ap/vim-css-color'
	Plug 'preservim/nerdtree'
	Plug 'kien/ctrlp.vim'

	" Completion / linters / formatters
	" Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
	"Plug 'pantharshit00/vim-prisma'
	Plug 'mileszs/ack.vim'
	" Plug 'preservim/nerdcommenter'

	" Git
	Plug 'airblade/vim-gitgutter'
call plug#end()

" Syntax
filetype plugin indent on
syntax on

" Leader
"let mapleader = ','
let mapleader = "\<Space>"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


nnoremap <silent>    <Leader>bb :buffers<cr>
nnoremap <silent>    <Leader>b :b <tab><tab>

nnoremap <silent> <Leader>s :FixWhitespace<CR>
nnoremap <silent>    <Leader>cc :Commentary<CR>

" Move to previous/next
nnoremap <silent>    <Leader>p :BufferPrevious<CR>
nnoremap <silent>    <Leader>n :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>

" Delete in INSERT mode
imap <C-D> <C-O>x


" Options
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

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" True color if available
let term_program = $TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
	set termguicolors
else
	if $TERM !=? 'tmux-256color'
		set termguicolors
	endif
endif

" Color scheme and themes
" let t_Co = 256
colorscheme dracula
set termguicolors
"colorscheme cyberpunk
let g:airline_theme='cyberpunk'

set cursorline

" Nerd Tree
let NERDTreeQuitOnOpen=1

" Airline
" let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Searching
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <C-s> :Ack!<Space>

" Italics
"let &t_ZH = "\e[3m"
"let &t_ZR = "\e[23m"

" File browser
let NERDTreeShowHidden = 1

" CTRLP: Ignore based on gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Language server stuff
"let g:python3_host_prog = '/usr/local/bin/python3'
"command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Folding
"highlight Folded
"set nofoldenable
"set foldlevel=99
"set fillchars=fold:\
"set foldtext=CustomFoldText()
"setlocal foldmethod=expr
"setlocal foldexpr=GetPotionFold(v:lnum)

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>
nnoremap <F10> :CocCommand tsserver.organizeImports<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>
