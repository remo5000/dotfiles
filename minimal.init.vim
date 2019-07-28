scriptencoding utf-8
set encoding=utf-8
set clipboard=unnamed							 " Use system clipboard for everything
set colorcolumn=+1                 " line length matters
set foldmethod=indent              " set a foldmethod
set nofoldenable
set mouse=a                        " enable mouse
set number                         " line numbers
set scrolloff=2                    " Always shows two lines of vertical context around the cursor
set showcmd                        " show incomplete commands
set undofile
set updatetime=100
set hlsearch                       " highlight what you search for
set ignorecase                     " case insensitive search
set incsearch                      " type-ahead-find
set smartcase                      " smart case search
set inccommand=nosplit             " in-place substitution preview

set expandtab                      " use spaces instead of tabs
set shiftwidth=2                   " 1 tab == 2 spaces
set tabstop=2                      " 1 tab == 2 spaces

set splitbelow                     " all horizontal splits open to the bottom
set splitright                     " all vertical splits open to the right

let mapleader = "\<Space>"         " Use space as leader

" Newline
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" JK is Esc
imap jk <Esc>

" Window movement using Tab
map <tab> <c-w>

" Escape terminal mode using esc
tnoremap <Esc> <C-\><C-n>

" Reload/Edit vimrc.
nnoremap <leader>v :source $MYVIMRC<CR>
nnoremap <leader>e :e $MYVIMRC<CR>

" Double slash to search for visual selection.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" Clear highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Copy current filepath to systen clipboard.
nnoremap <Leader>y :let @+ = expand("%")<CR>
nnoremap <Leader>Y :let @+ = expand("%:t")<CR>
command! Dirname :let @+ = expand("%:h")

" Ruler
set ruler
set number                     " Show current line number

" Trailing whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Clipboard
vnoremap  y  "+y
nnoremap  Y  "+yg_
nnoremap  y  "+y
nnoremap  yy  "+yy
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P

" Never use paste mode
au InsertLeave * set nopaste
