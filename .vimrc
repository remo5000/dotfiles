filetype plugin indent on
syntax on
set shell=/usr/local/bin/fish

" Plugins
call plug#begin()
" Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'owickstrom/vim-colors-paramount'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
" Plug 'Valloric/MatchTagAlways'
Plug 'slashmili/alchemist.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mustache/vim-mustache-handlebars'
call plug#end()
" Haskell indentation
setlocal formatprg=/Users/vigneshshankar/.local/bin/hindent

set runtimepath+=~/.vim/plugged/deoplete.nvim/
let g:deoplete#enable_at_startup = 1


" Color
set background=dark
colorscheme paramount
" let g:airline_theme='onehalflight'
" let g:airline_theme='atomic'

" Ruler
set ruler
set number                     " Show current line number
set relativenumber             " Show relative line numbers

" Trailing whitespace
set list

" Code folding
set foldmethod=indent
set nofoldenable
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'typescript' : 1,
    \}

" Mappings
map <Enter> o<ESC>
map <S-Enter> O<ESC>
imap jk <Esc>
map <tab> <c-w>
tnoremap <Esc> <C-\><C-n>

" Default Tab settings. I like to keep it at 2 (most of the time)
set tabstop=2
set shiftwidth=2
set expandtab
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" java auto tab toggles
" augroup java_settings
"     autocmd BufNewFile,BufRead ~/workspace/cs2030/* call CS2030()
"     autocmd BufWinEnter ~/workspace/cs2040/* call CS2040()
" augroup END

" Compilation
    " Java
augroup file_remaps
    autocmd BufWinEnter *.java nnoremap <F3> :w<CR>:!javac %:p<CR>
    autocmd BufWinEnter *.cpp nnoremap <F3> :!make ./%<
    autocmd BufWinEnter *.cpp nnoremap <F9> :r!make ./%<
    autocmd BufWinEnter *.cpp nnoremap <F4> :!./%<
augroup END
    " LaTeX
"let g:vimtex_compiler_progname = 'nvr'

"function CS2030()
"    set tabstop=2
"    set shiftwidth=2
"endfunction
"
"function CS2040()
"    set tabstop=4
"    set shiftwidth=4
"endfunction
" TODO remove this
nnoremap <F3> :w<CR>:!browserify %:p -o bundle.js<CR>
