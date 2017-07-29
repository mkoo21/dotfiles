set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'

call plug#end()

filetype plugin indent on    " required

"Using system clip requires vim-gtk
set clipboard=unnamed
set mouse=a

"Tab/shift tab indent
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

"Familiar ctrl shortcuts
map <C-s> <esc>:w<CR>
noremap <C-f> <esc>:Files<CR>
noremap ƒ :Ag<CR>
map <C-l> <esc>:ls<CR>

"Code fold with spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Alignment/tabs/line numbers
set shiftwidth=4
set autoindent
set cindent
set tabstop=4
set expandtab
set softtabstop=4
set number
set backspace=indent,eol,start

"Comments/alignment (for nerdcommenter)
let g:NERDDefaultAlign = 'left'

"Stop commenting next line on enter and o
set formatoptions-=r
set formatoptions-=o

"Search
set incsearch
set hlsearch
set ignorecase

"NERDTree ezaccess
noremap <C-\> :NERDTreeToggle<CR>

"Python 
au FileType python
    \set textwidth=79
    \set fileformat=unix

"For 256 colors in tmux on mac (tmux seems to only work with screen-256-color
"which is still different from xterm-256-color)
"iTerm is recommended
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 <
        "https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 <
    "https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
    "Based on Vim patch 7.4.1770 (`guicolors` option) <
    "          https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
    "          >
    "            " <
    "            https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
    "            >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

"Salesforce lightning 
au BufRead *.cmp set syntax=xml

"Mac
let g:onedark_termcolors=256
colorscheme onedark
set background=dark


if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
