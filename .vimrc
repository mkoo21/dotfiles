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
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'ervandew/supertab'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'derekwyatt/vim-scala'
Plug 'tomlion/vim-solidity'
Plug 'eapache/rainbow_parentheses.vim'
"Plug 'lervag/vimtex'
Plug 'yuttie/hydrangea-vim'
Plug 'nvie/vim-flake8'
Plug 'elmcast/elm-vim' 
"Plug 'JamshedVesuna/vim-markdown-preview'
"Plug 'jaxbot/browserlink.vim'

call plug#end()

filetype plugin indent on    " required

"Using system clip requires vim-gtk
set clipboard=unnamed
set pastetoggle=<F2>

"Make vim a little more mouse/clipboard-friendly
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        set mouse=
    else
        set mouse=a
    endif
endfunc
set mouse=a
map <C-m> :call ToggleMouse()<CR>

"auto dos2unix
set ff=unix

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

"Mac 
"inoremap ƒ <ESC>:Ag<CR> 
"nnoremap ƒ :Ag<CR> 

"Linux
inoremap f <ESC>:Ag<CR> 
nnoremap f :Ag<CR> 

map <C-o> <ESC>:Buffer<CR>
imap <C-o> <ESC>:Buffer<CR>
"map <C-p> <ESC>:Buf<CR>
"imap <C-p> <ESC>:Buf<CR>
map  <ESC><leader>c<space>
imap  <ESC><leader>c<space>

"Ctrl + c to system clipboard (unix)
vnoremap <C-c> "+y

"Delete word with ctrl
imap <C-BS> <C-W>

"For scrolling in tmux
noremap [1;2A] <C-b>
noremap [1;2B] <C-d>
"More useful little A
"nnoremap a ea

"Code fold with spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Alignment/tabs/line numbers
set shiftwidth=2
set autoindent
set cindent
set tabstop=2
set expandtab
set softtabstop=2
set number
hi lineNr ctermfg=grey "if line numbers are not visible 
set backspace=indent,eol,start
set breakindent
set statusline+=col:\ %c,

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

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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

"JS template
au BufRead *.ejs set syntax=xml

"Salesforce lightning 
au BufRead *.cmp set syntax=xml

"Markdown
au! BufRead,BufNewFile *.md set filetype=mkd
au! BufRead,BufNewFile *.markdown set filetype=mkd

"Salesforce Apex
au! BufRead,BufNewFile *.(cls|trigger) set filetype=java

autocmd FileType mkd nnoremap <C-p> :w<Space><Bar><Space>!markdown<Space>%<Space>><Space>file.html<Space>&&<Space>open<Space>file.html<CR>
autocmd FileType mkd inoremap <C-p> <ESC>:w<Space><Bar><Space>!markdown<Space>%<Space>><Space>file.html<Space>&&<Space>open<Space>file.html<CR>

"Stop littering swap files
set noswapfile

"Unset the background to use terminal's bg (e.g. for translucency). Set after
"colorscheme to override
"hi Normal ctermbg=none

syntax on
colorscheme onedark
set background=dark
"colorscheme hydrangea
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

"Eslint syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

"xmllint
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
