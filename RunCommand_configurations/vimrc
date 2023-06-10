set nocompatible " be iMproved, required
filetype off " required
"
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"Plugin 'ycm-core/YouCompleteMe'

"Plugin 'vim-scripts/Conque-GDB'

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
syn on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent " check aso cindent for a C indentation standard
" set fdm=syntax " to fold part of the text
set showmatch
set incsearch " start to search from the first input character. typing more characters refines the search. 
set hlsearch " highlight when search
set ruler
set cursorline
set statusline=%<%F%h%m%r%h%w%y\ %=\ lin:%l\,%L\ col:%c%V\ %P
set laststatus=2
set vb t_vb=
set history=10000 " keep 10000 lines of command history
"set background=dark
"set textwidth=80
set t_Co=256
set term=xterm-256color
set laststatus=2

set number " Enable line numbers
set relativenumber " current line has line number other lines' numbers is the relative distance from the current line
noremap <C-N> :set relativenumber!<CR> " bind ctrl+n to toggle relative number

set splitbelow " Open new split panes to the bottom
set splitright " Open new split panes to the right
set wildmenu "use the command :find to navigate among files (note :set path+=** to add the current path among the pathes that are scanned in the search)

" to use Ctrl+b for visuall block (ctrl+v for paste ctrl+q minimize windows (default is to close windows but Isometimes I press it instead of ctrl+w in firefox to close a tab))
nnoremap <C-b> <C-q>

" to use Ctrl+c to copy
vnoremap <C-c> "+y :echo "Copied selected text to the system clipboard!" <CR>
nnoremap <C-c> V"+y :echo "Copied whole line to the system clipboard!" <CR>
vnoremap <C-v> "+p

au BufNewFile,BufRead *.wl set filetype=mma

" to retain folded snippet from
" https://www.freecodecamp.org/news/learn-linux-vim-basic-features-19134461ab85/
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" for pathogen, a plugin manager
"execute pathogen#infect()
"syntax on
"filetype plugin indent on

" For the colour scheme https://github.com/morhetz/gruvbox
" colorscheme gruvbox
" set background=light  " Setting light mode
"" let g:gruvbox_contrast_light = 'hard'

" For the colour scheme https://github.com/sonph/onehalf.git
"syntax on
"set t_Co=256
"set cursorline
"colorscheme onehalflight
"let g:airline_theme='onehalfdark'
" lightline
" " let g:lightline.colorscheme='onehalfdark'

" For the coulour scheme https://github.com/altercation/vim-colors-solarized.git
"syntax enable
"set background=light
"colorscheme solarized

" syntax on " This is required
" colorscheme purify
"
"
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

