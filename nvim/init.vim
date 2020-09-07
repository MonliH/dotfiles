" Plug Plugins {{{
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
Plug 'MonliH/vimsence'
Plug 'Chiel92/vim-autoformat'
Plug 'chrisbra/Colorizer'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jdonaldson/vaxe'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'godlygeek/csapprox'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()
" }}}
" Plugin Config {{{
" fuzzy finder bind
nmap <space>s :FZF<CR>
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
nmap <space>rn <Plug>(coc-rename)

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

" CoC config
let g:coc_user_config = {
            \    'explorer.icon': {
            \        'enableNerdfont': "true"
            \    }
            \}

" CoC explorer
let g:coc_explorer_global_presets = {
            \    'normal': {
            \        'file-child-template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5][size]'
            \    }
            \}

" CoC exploere key map
nmap <space>e :CocCommand explorer --preset normal<CR>

" CoC show documentation on K
nnoremap <silent> <space>k :call <SID>show_documentation()<CR>

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
" theme
let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1

" transparent background
function! AdaptColorscheme()
    highlight clear CursorLine
    highlight Normal ctermbg=none guibg=NONE
    highlight LineNr ctermbg=none guibg=NONE
    highlight Folded ctermbg=none guibg=NONE
    highlight NonText ctermbg=none guibg=NONE
    highlight SpecialKey ctermbg=none guibg=NONE
    highlight VertSplit ctermbg=none guibg=NONE
    highlight SignColumn ctermbg=none guibg=NONE
endfunction
autocmd ColorScheme * call AdaptColorscheme()

" colors
colorscheme material
" nicer colors
set termguicolors
" }}}
" Lightline {{{
" remove insert mode indicator (lightline)
set noshowmode

autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  " transparent background in statusbar
  let l:palette = lightline#palette()

  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction
" }}}
" Code Formatting {{{
" rustfmt
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

" autoformat cmd
nmap <space>f :Autoformat<:R>

autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
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
nmap <space>h :set foldmethod=syntax foldenable!<CR>

" remove highlight
nmap <space>r :noh<CR>
" }}}
