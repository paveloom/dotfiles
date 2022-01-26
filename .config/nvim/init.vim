set shell=/bin/bash
let mapleader = "\<Space>"

" Paths
let $VIM_CONF = expand('<sfile>:h')
let $VIM_DATA = stdpath('data')
let $VIM_INIT = $VIM_CONF . '/init'
let $VIM_PLUGINS = $VIM_INIT . '/plugins'
let $VIM_THEMES = $VIM_CONF . '/themes'
let $VIM_SESSION = $VIM_DATA . '/session.vim'

" Theme
source $VIM_THEMES/noctis-hc.vim

" Configuration
source $VIM_INIT/set.vim
source $VIM_INIT/mappings.vim
source $VIM_INIT/autocmd.vim

" Plugins
source $VIM_INIT/plugins.vim
