call plug#begin(stdpath('data') . '/plugged')
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/bogado/file-line.git'
Plug 'yuttie/comfortable-motion.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'monlih/vimsence'
call plug#end()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

autocmd vimenter * NERDTree
:set mouse=a

set termguicolors

let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'

colorscheme material
set number
set relativenumber

set clipboard=unnamed
set statusline^=%{coc#status()}
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

