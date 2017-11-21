set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"FZF, vim markdown, pandoc have requirements
"Colorschemes may need TERM=xterm-256color
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
"Note to self this is for autocompletion, not indenting; use :set paste for copypasta
Plug 'ervandew/supertab'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'derekwyatt/vim-scala'
Plug 'tomlion/vim-solidity'
Plug 'kien/rainbow-parentheses.vim'
"Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

filetype plugin indent on    " required

"Using system clip requires vim-gtk
set clipboard=unnamed
set mouse=a

"Splitting
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
set splitbelow
set splitright

if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

"Tab/shift tab indent
nnoremap <Tab> ><ESC>gv
nnoremap <S-Tab> <<<ESC>gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
inoremap <S-Tab> <C-d>

"Familiar ctrl shortcuts
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
inoremap <C-f> <ESC>:Files<CR>
noremap <C-f> <ESC>:Files<CR>
inoremap ƒ <ESC>:Ag<CR> 
nnoremap ƒ :Ag<CR> 
inoremap f <ESC>:Ag<CR>
nnoremap f :Ag<CR>

map <C-o> <ESC>:Buffer<CR>
imap <C-o> <ESC>:Buffer<CR>
map <C-p> <ESC>:ls<CR>
imap <C-p> <ESC>:ls<CR>
map  <ESC><leader>c<space>
imap  <ESC><leader>c<space>

"Ctrl + c to system clipboard (unix)
vnoremap <C-c> "+y

"Delete word with ctrl
imap <C-BS> <C-W>

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
set breakindent

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
noremap <C-\> <ESC>:NERDTreeToggle<CR>
inoremap <C-\> <ESC>:NERDTreeToggle<CR>

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

"Markdown
au! BufRead,BufNewFile *.md set filetype=mkd
au! BufRead,BufNewFile *.markdown set filetype=mkd

"Salesforce Apex
au! BufRead,BufNewFile *.(cls|trigger) set filetype=java

"Markup
:autocmd BufWritePre *.html :normal gg=G

autocmd FileType mkd nnoremap <C-p> :w<Space><Bar><Space>!markdown<Space>%<Space>><Space>file.html<Space>&&<Space>open<Space>file.html<CR>
autocmd FileType mkd inoremap <C-p> <ESC>:w<Space><Bar><Space>!markdown<Space>%<Space>><Space>file.html<Space>&&<Space>open<Space>file.html<CR>

"Mac
"let g:onedark_termcolors=256
colorscheme onedark
set background=dark

"Linux translucency
hi Normal ctermbg=none


if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

"Rainbows
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
