"                                           _
"       ___ _ __   __ _  ___ ___     __   _(_)_ __ ___
"      / __| -_ \ / _- |/ __/ _ \____\ \ / / | -_ - _ \
"      \__ \ |_) | (_| | (_|  __/_____\ V /| | | | | | |
"      |___/ .__/ \__._|\___\___|      \_/ |_|_| |_| |_|
"          |_|
"
"   Copyright (c) 2017 Liu-Cheng Xu & Contributors
"
"   You can customize space-vim with .spacevim
"   and don't have to take care of this file.
"
"   Author: Liu-Cheng Xu <xuliuchengxlc@gmail.com>
"   URL: https://github.com/liuchengxu/space-vim
"   License: MIT

scriptencoding utf-8

let g:spacevim = get(g:, 'spacevim', {})
let g:spacevim.base = $HOME.'/.space-vim'
let g:spacevim.version = '0.8.0'

" Identify platform {
let g:spacevim.os = {}
let g:spacevim.os.mac = has('macunix')
let g:spacevim.os.linux = has('unix') && !has('macunix') && !has('win32unix')
let g:spacevim.os.windows = has('win32') || has('win64')
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:yaml_formatter_indent_collection=1
set number relativenumber
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:spacevim.os.windows
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

set runtimepath+=$HOME/.space-vim/core
autocmd BufWritePre * %s/\s\+$//e

call spacevim#begin()

Layer 'spacevim'

call spacevim#end()

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'avakhov/vim-yaml'
Plug 'tarekbecker/vim-yaml-formatter'
Plug 'rust-lang/rust.vim'
Plug 'phildawes/racer'
Plug 'tpope/vim-rhubarb'

call plug#end()

