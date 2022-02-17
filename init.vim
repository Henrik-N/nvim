" vim config
"
let g:config_dir_path='~/.config/nvim/'


" Utility functions {{{
"
let g:config_dir = get(g:, 'config_dir', expand(g:config_dir_path))

" source a file in the config directory
fu! SourceFile(config_file)
    exec 'source' g:config_dir.a:config_file
endfu

" source an array of files in the config directory
fu! SourceFiles(config_files)
    for files in a:config_files
        for file in glob(g:config_dir.files, 1, 1)
            exec 'source' file
        endfor
    endfor
endfu
"
" }}}

" Base config {{{
"
fu! BaseConfig()
    set encoding=utf8
    set showmatch "highlight matching '(' to ')'
    set mouse=v "middle click paste
    set mouse=a "enable mouse clicks
    set scrolloff=8
    set guicursor=i:block "blockcursor in insert mode as well
    set clipboard=unnamedplus "use system clipboard
    set cursorline "highlight current line
    set ttyfast "faster scrolling
    syntax on "syntax highlighting
    set noswapfile
    set backupdir=~/.cache/vim 

    " Indenting
    set tabstop=4
    set softtabstop=4
    set expandtab "tabs -> spaces

    " Auto-indenting
    set autoindent
    set shiftwidth=4 "auto-indent width
    filetype plugin indent on "auto-indenting settings depending on file-type

    " Searching
    set ignorecase
    set hlsearch
    set incsearch
    " clear highlighting from previous search
    nnoremap <C-l> <cmd>noh<cr>

    " Line numbers
    set number
    set relativenumber

    " Tab-completion
    set wildmode=longest,list

    " 80 char column border
    set cc=80

    " {{{ }}} to mark, zm to fold, zr to unfold
    set foldmethod=marker
endfu
"
" }}}


" Key bindings {{{
"

let mapleader = " " "needs to be called globally for some reason
fu! KeyBindings()
    " Rebind Escape
    inoremap kj <Esc>

    " Save/Quit
    nnoremap <leader>ww <cmd>:w<cr>
    nnoremap <leader>wq <cmd>:wq<cr>
    nnoremap <leader>qq <cmd>:q!<cr>

    " Change window
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l


    if &filetype ==# 'rust'
        nnoremap <leader>r :!cargo r<cr>
        nnoremap <leader>b :!cargo b<cr>
        nnoremap <leader>q :!cargo fmt<cr>
    endif


    if &filetype ==# 'markdown'
        nmap <leader>p <Plug>MarkdownPreviewToggle
    endif


    if has('nvim')
        " File explorer (nvim-tree)
        nnoremap <leader>e :NvimTreeToggle<cr>
        nnoremap <leader>n :NvimTreeFindFile<cr>
    endif


endfu

" compat mode if vanilla vim
if &compatible
    set nocompatible
endif
"
" }}}

" Load plugins {{{
"
fu! LoadPlugins()
    " Note: Run :PlugInstall to install plugins after changing this list
    "
    call SourceFile('vim-plug.vim')
    call plug#begin('~/.vim/plugged')

    " Syntax highlighting
    Plug 'sainnhe/gruvbox-material' "color scheme


    " Status line
    Plug 'itchyny/lightline.vim'

    " File explorer
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    if has('nvim')
        " Better syntax highlighting support (nvim only, use 'sheerun/vim-polygot' for vanilla vim?)
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

        " LSP & code completition
        Plug 'neovim/nvim-lspconfig'
        Plug 'williamboman/nvim-lsp-installer'

        " Zen mode / distraction-free mode
        Plug 'junegunn/goyo.vim'

        " Align text by character | markdown folding with zr (open)/zc(close)/zM(close all)
        Plug 'godlygeek/tabular' "| Plug 'plasticboy/vim-markdown'

        " Markdown preview
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


        Plug 'deoplete-plugins/deoplete-clang'
"         if has('nvim')
"           Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"         else
"           Plug 'Shougo/deoplete.nvim'
"           Plug 'roxma/nvim-yarp'
"           Plug 'roxma/vim-hug-neovim-rpc'
"         endif
"         let g:deoplete#enable_at_startup = 1            

    endif

    call plug#end()
endfu
"
" }}}

" Config files {{{
"
fu! LoadConfigs()
    let vim_script_configs = [
                \ 'gruvbox-material.vim',
                \ 'lightline.vim',
                \ ]
    call SourceFiles(vim_script_configs)


    if has('nvim')
        let lua_configs = [
                    \ 'nvim-tree.vim',
                    \ 'nvim-treesitter.vim',
                    \ 'lsp.vim',
                    \ ]
        call SourceFiles(lua_configs)
    endif
endfu
"
" }}}

" Main function {{{
"
fu! Main()
    call BaseConfig()
    call KeyBindings()
    call LoadPlugins()
    call LoadConfigs()

    set secure
endfu
"
" }}}


call Main()

