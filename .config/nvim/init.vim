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
call plug#end()


" CoC setup
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

" mouse support
set mouse=a

" nicer colors
set termguicolors

" theme
let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1

" discord rich presence
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_client_id = '566398769386749973'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'

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

" relative line numbers
set number
set relativenumber

" tab stuff
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set smartindent

" disable arrow keys in normal mode
noremap <Left> :echo "No left for you!"<CR>
noremap <Right> :echo "No right for you!"<CR>
noremap <Up> :echo "No up for you!"<CR>
noremap <Down> :echo "No down for you!"<CR>

" next coc diagnostic
nmap <silent> ]n <Plug>(coc-diagnostic-next-error)
nmap <silent> ]b <Plug>(coc-diagnostic-prev-error)

nmap <silent> ]N <Plug>(coc-diagnostic-next)
nmap <silent> ]B <Plug>(coc-diagnostic-prev)

" configure python path
let g:python3_host_prog = "/usr/bin/python3"

" rustfmt
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

" fuzzy finder bind
nmap <space>s :FZF<CR>

" autoformat cmd
nmap <Leader>f :Autoformat<CR>

" jump to useful stuff
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc explorer
let g:coc_explorer_global_presets = {
            \    'normal': {
            \        'file-child-template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified][readonly] [linkIcon & 1][link growRight 1 omitCenter 5][size]'
            \    }
            \}

nmap <space>e :CocCommand explorer --preset normal<CR>

" disable page up/down keys (they're annoying!!)
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" spellchecker bind
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

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

