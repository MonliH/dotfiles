call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/bogado/file-line.git'
Plug 'yuttie/comfortable-motion.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'hugolgst/vimsence'
Plug 'Chiel92/vim-autoformat'
Plug 'chrisbra/Colorizer'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jdonaldson/vaxe'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

set mouse=a

set termguicolors

let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_client_id = '566398769386749973'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

colorscheme material
set number
set relativenumber

set clipboard=unnamed
set statusline^=%{coc#status()}
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

noremap <Left> :echo "No left for you!"<CR>
noremap <Right> :echo "No right for you!"<CR>
noremap <Up> :echo "No up for you!"<CR>
noremap <Down> :echo "No down for you!"<CR>

nmap <silent> ]c <Plug>(coc-diagnostic-next)

let g:python3_host_prog = "/usr/bin/python3"
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

nmap <Leader>f :Autoformat<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

set clipboard=unnamedplus

nmap <space>e :CocCommand explorer<CR>

nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

