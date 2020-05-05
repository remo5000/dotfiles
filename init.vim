scriptencoding utf-8
set encoding=utf-8
set clipboard+=unnamedplus         " Use system clipbaord in addition to 0
set colorcolumn=+1                 " line length matters
set foldmethod=indent              " set a foldmethod
set nofoldenable
set mouse=a                        " enable mouse
set number                         " line numbers
set scrolloff=10                   " Always shows some lines of vertical context around the cursor
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

set ruler                          " Use the ruler
set number                         " Show current line number

set hidden                         " Don't warn when leaving an unsaved buffer

let mapleader = "\<Space>"         " Use space as leader

" Newline
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Remove trailing newline
autocmd BufWritePre * :%s/\s\+$//e

" JK is Esc
imap jk <Esc>

" Quick moves
nmap J 15j
vmap J 15j
nmap K 15k
vmap K 15k

" Window movement using Tab
map <tab> <c-w>

" Escape terminal mode using esc
tnoremap <Esc> <C-\><C-n>

" Reload/Edit vimrc.
nnoremap <leader>v :source $MYVIMRC<CR>
nnoremap <leader>e :e $MYVIMRC<CR>

" Close this buffer, but don't delete the window.
nnoremap <leader>w :bp<bar>sp<bar>bn<bar>bd<CR>

" Double slash to search for visual selection.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" Clear highlights.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Copy current filepath to systen clipboard.
nnoremap <Leader>y :let @+ = expand("%")<CR>
nnoremap <Leader>Y :let @+ = expand("%:t")<CR>
command! Dirname :let @+ = expand("%:h")

" Trailing whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Copy entire buffer
nnoremap <leader>B ggVGy

" Search for buffers
nnoremap <leader>b :Buffers<CR>

" Navigate buffers using leader h/l.
noremap <leader>h :bp <CR>
nnoremap <leader>l :bn <CR>

" Call "make".
nnoremap <leader>m :!make<CR>

" Close netrw buffers when we open a file.
let g:netrw_fastbrowse = 0

" FZF
set rtp+=/usr/local/opt/fzf

" Never use paste mode
au InsertLeave * set nopaste

" Filetypes
filetype plugin indent on
augroup Indentation
  autocmd!
  autocmd Filetype Dockerfile setlocal tabstop=4 softtabstop=4 shiftwidth=0
  autocmd Filetype bash       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype bzl        setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype ruby       setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype python     setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype sh         setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype sql        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype c          setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype cpp        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype thrift     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype xml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup FileTypeAliases
  autocmd!
  autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
augroup END


" Boxes
let g:boxes_types = {
      \"bash": "shell",
      \"vim":  "vim-box",
      \}
let g:boxes_config_file = '~/boxes-config'

function CallBoxes(line_or_lines)
  let boxed_title_lines = systemlist('boxes'
        \. ' -f ' . g:boxes_config_file
        \. ' -d ' . get(g:boxes_types, &filetype, "shell")
        \, a:line_or_lines)
  return append(line('.'), boxed_title_lines)
endfun

function BoxCurrentLine()
  let current_line = trim(getline("."))
  call CallBoxes(current_line)
  call deletebufline(bufname(), line("."))
endfun

function BoxLines() range
  let visual_lines = map(getline(line("'<"), line("'>")), {_, val -> trim(val)})
  call deletebufline(bufname(), line("'<"), line("'>"))
  normal k
  call CallBoxes(visual_lines)
  normal 2j
endfun

if executable('boxes')
  nmap <leader>d :call BoxCurrentLine()<CR>
  vmap <leader>d :call BoxLines()<CR>
endif

""""""""""""""""""""""""
"             Plug
""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
nnoremap <leader>P :PlugInstall<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF & Rg | Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Escape question marks for usage in Rg.
function! s:CWordEscaped()
  if (&filetype ==# 'ruby')
    return substitute(expand('<cword>'), '?', '\\?', '')
  else
    return expand('<cword>')
  endif
endfunction


" Use Ripgrep to search file contents. I/O isn't as fast as ag,
" but doing search on selected text is way faster
function! RgArgs(args)
  let tokens  = split(a:args)
  let rg_opts = join(filter(copy(tokens), 'v:val =~# "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~# "^-"'))
  return rg_opts . ' ' . shellescape(query)
endfunction

let rg_colors = '--colors "match:none" --colors "match:style:bold" '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --glob "!.git/* !tags !cscope.out" --column --line-number --no-heading --color=always --smart-case ' . rg_colors . RgArgs(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:40%', '?'),
  \   <bang>0)

" Search word under cursor with leader + f.
nnoremap <silent> <leader>f :silent Rg -sw <C-r>=<SID>CWordEscaped()<CR><CR>
" Search visual selection with leader + r.
vnoremap <silent> <leader>f y:silent Rg -sw <C-r>"<CR>

" Search for filenames using -p
if trim(system('git rev-parse --is-inside-work-tree')) ==# 'true'
  noremap <leader>p :call fzf#vim#gitfiles('', fzf#vim#with_preview('right:40%'))<CR>
else
  noremap <leader>p :silent FZF <CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Themes / Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'drewtempelmeyer/palenight.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "palenight"
let g:airline#extensions#tabline#enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter, Fugitive | Git.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'
" Don't use leader h mappings, I want those for buffer navigation.
let g:gitgutter_map_keys = 0

" Show git diffs of a file when entering/leaving
augroup improved_autoread
  autocmd FocusGained * checktime
  autocmd FocusGained * GitGutterAll
  autocmd BufEnter * checktime
  autocmd BufEnter * GitGutterAll
augroup end

Plug 'tpope/vim-fugitive'
noremap <leader>g :Git<CR>
" I'll commit to using Fugitive instead of custom aliases, so
" here's a cheatsheet:
"
" s       stage
" P       add --patch
" u       unstage
" U       unstage all
" X       disregard file changes (== checkout HEAD <file>)
" i       jump to next hunk
"
" =       toggle diff of file
" dv      diff of file in vertical splits
" gI      gitignore the file
"
" cc      commit
" cvc     commit -v
" cva     commit -v --amend
" ca      commit --amend
" ce      commit --amend --no-edit
" cw      reword last commit (equivalent to rebase -i then rewording)
"
" crc     revert
" coo     checkout
" cb<spc> :Git branch
"
" ri      rebase -i
" rr      rebase --continue
" ra      rebase --abort
" r<spc>  :Git rebase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vinegar.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-vinegar'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surround, Brackets, Selection, Commenting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'tpope/vim-surround'

" Highlight word under cursor
Plug 'pboettch/vim-highlight-cursor-words'

" Comment stuff
Plug 'scrooloose/nerdcommenter'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" HTML tag matching
Plug 'valloric/MatchTagAlways'
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}

" Nicer C++ syntax
Plug 'octol/vim-cpp-enhanced-highlight'

" Java CUP syntax
Plug 'vim-scripts/cup.vim'
autocmd BufNewFile,BufRead *.cup setf cup

""""""""""""
"    Coc   "
""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
" Jump between errors
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

""""""""""""""""""
"    Gutentags   "
""""""""""""""""""

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']


let g:coc_global_extensions = [
      \"coc-snippets",
      \"coc-json",
      \"coc-tsserver",
      \"coc-tslint",
      \"coc-yank",
      \"coc-vimlsp",
      \"coc-python",
      \"coc-dictionary",
      \"coc-word",
      \"coc-vetur",
      \"coc-go",
      \"coc-java"
      \]

" TS syntax
Plug 'HerringtonDarkholme/yats.vim'

" Vue syntax
Plug 'posva/vim-vue'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Org mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jceb/vim-orgmode'

call plug#end()

" Color & color compatibility with emulator/tmux
colorscheme palenight
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

" Goto mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Preview definition using K
nmap <silent> <leader>k :call CocActionAsync('doHover')<cr>
