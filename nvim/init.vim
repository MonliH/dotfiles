let mapleader = " "
" Plug Plugins {{{
call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'
Plug 'bogado/file-line'
Plug 'yuttie/comfortable-motion.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
Plug 'jiangmiao/auto-pairs'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'sbdchd/neoformat'
Plug 'chrisbra/Colorizer'
Plug 'jdonaldson/vaxe'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-scripts/ebnf.vim'
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'KabbAmine/vCoolor.vim'
Plug 'albfan/ag.vim'
Plug 'tpope/vim-eunuch'
Plug 'zyedidia/vim-snake'
Plug 'dstein64/vim-startuptime'
Plug '~/Documents/programming/github/coc-explorer'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
Plug 'hoov/tmuxline.vim', { 'branch': 'truecolor-lightline' }
call plug#end()
" }}}
" Plugin Config {{{
" fuzzy finder bind
nnoremap <leader>ss :FZF<CR>
" }}}
" CoC {{{
" CoC setup
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
nmap <leader>rn <Plug>(coc-rename)

" next CoC diagnostic
nmap <silent> ]n <Plug>(coc-diagnostic-next-error)
nmap <silent> ]b <Plug>(coc-diagnostic-prev-error)

nmap <silent> [n <Plug>(coc-diagnostic-next)
nmap <silent> [b <Plug>(coc-diagnostic-prev)

" jump to useful stuff
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" CoC exploere key map
nmap <leader>e :CocCommand explorer --preset normal<CR>

" CoC show documentation on K
nmap <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" spellchecker bind
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" }}}
" Discord {{{
" discord rich presence
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_client_id = '566398769386749973'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
" }}}
" Theme {{{
" nicer colors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

let g:edge_enable_italic = 1
let g:edge_sign_column_background = 'none'

" theme
colorscheme edge
" }}}
" Lightline {{{
" remove insert mode indicator (lightline)
set noshowmode

let g:lightline = {'colorscheme' : 'edge'}
" }}}
" Disabled Keys {{{
" disable arrow keys in normal mode
noremap <Left> :echo "No left for you!"<CR>
noremap <Right> :echo "No right for you!"<CR>
noremap <Up> :echo "No up for you!"<CR>
noremap <Down> :echo "No down for you!"<CR>

" disable page up/down keys (they're annoying!!)
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
" }}}
" Language Specific Support {{{
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
    autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
augroup END

nnoremap <leader>f :Neoformat<CR>
" Gdb
packadd termdebug
" }}}
" Miscellaneous {{{
" relative line numbers
set number
set relativenumber

" tab stuff
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set smartindent

" configure python path
let g:python3_host_prog = "/usr/bin/python3"

" vim tabs
set foldmethod=marker foldenable

" toggle vim tabs to syntax highlight
noremap <leader>h :set foldmethod=syntax foldenable!<CR>

" remove highlight
nnoremap <leader>r :noh<CR>

" source bind
nnoremap <leader>sf :source %<CR>

" open nvimrc
nnoremap <leader>conf :e $MYVIMRC<cr>

" leave insert mdoe with jk or kj
inoremap jk <esc>
inoremap kj <esc>

" shortcut delay
set timeoutlen=300

" detect filetypes
filetype on

" indent marks
let g:indentguides_spacechar = '|'
let g:indentguides_tabchar = '|'
" }}}
