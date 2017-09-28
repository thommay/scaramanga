set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'mattn/webapi-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'neomake/neomake'
Plug 'dougireton/vim-chef', { 'for': 'ruby.chef' }
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'autozimu/LanguageClient-neovim' , { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-rct-complete'
Plug 'Shougo/echodoc.vim'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

call plug#end()

set number
set ruler
set laststatus=2

set nowrap
set ts=2
set sw=2
set shiftround
set expandtab
set softtabstop=2

set incsearch
set ignorecase
set smartcase
set title
set nohlsearch

set hidden
nnoremap ' `
nnoremap ` '
let mapleader=','
set history=1000
set clipboard=unnamed

set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

if has('mac')
	let g:gist_clip_command = 'pbcopy'
elseif
	let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype=1
let g:gist_open_browser_after_post=1

let g:airline_powerline_fonts=1
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

" auto format rust code
let g:rustfmt_autosave = 1

set termguicolors
set bg=dark
colorscheme solarized

function s:setupWrap()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrap()
endfunction

let g:neomake_ruby_rubocop_exe = 'chefstyle'

au BufRead,BufNewFile {Berksfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.run} set ft=ruby
au BufRead,BufNewFile *.{markdown,md} call s:setupMarkup()
au BufRead,BufNewFile *.hjs set ft=handlebars
au BufRead,BufNewFile *.txt call s:setupWrap()
au FileType latex,tex,md,markdown setlocal spell
autocmd! BufWritePost * Neomake

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1

set shortmess+=c
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

set backspace=indent,eol,start
filetype plugin indent on
