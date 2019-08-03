scriptencoding utf-8
set encoding=utf-8
set clipboard=unnamed							 " Use system clipboard for everything
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

" JK is Esc
imap jk <Esc>

" Window movement using Tab
map <tab> <c-w>

" Escape terminal mode using esc
tnoremap <Esc> <C-\><C-n>

" Reload/Edit vimrc.
nnoremap <leader>v :source $MYVIMRC<CR>
nnoremap <leader>e :e $MYVIMRC<CR>

" Close this buffer.
nnoremap <leader>w :bd<CR>

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

" Clipboard
vnoremap  y  "+y
nnoremap  Y  "+yg_
nnoremap  y  "+y
nnoremap  yy  "+yy
nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P

" Copy entire buffer
nnoremap <leader>B ggVGy

" Navigate buffers using leader h/l.
noremap <leader>h :bp <CR>
nnoremap <leader>l :bn <CR>

" FZF
set rtp+=/usr/local/opt/fzf

" Stripe - API
function! s:PayTestOnLastLine()
  let pay_test_command = '"pay test -f ' . expand('%') . ' -l ' . g:last_line . '"'
  execute 'silent !tmux send-keys -R -t "pay test" ' . pay_test_command . ' Enter'
endfunction

function! s:PayTestOnCurrentLine()
  let g:last_line = line('.')
  :call s:PayTestOnLastLine()
endfunction

if fnamemodify(getcwd(), ':p') == $HOME.'/stripe/pay-server/'
  nnoremap <leader>tt :call <SID>PayTestOnCurrentLine()<CR>
  nnoremap <leader>tr :call <SID>PayTestOnLastLine()<CR>
end

" Stripe - Sorbet
function! s:SorbetLldbExpr()
  let command = '"expr ' . expand("<cword>") . '"'
  echo command
  execute 'silent !tmux send-keys -R -t "pay test" ' . command . ' Enter'
endfunction

function! s:SorbetLldbAddBreakpointAtCurrentLine()
  let g:last_line = line('.')
  let lldb_breakpoint = '"b ' . expand('%:t') . ':'. g:last_line . '"'
  echo lldb_breakpoint
  execute 'silent !tmux send-keys -R -t "pay test" ' . lldb_breakpoint ' Enter'
endfunction

if fnamemodify(getcwd(), ':p') == $HOME.'/stripe/sorbet/'
  nnoremap <leader>tb :call <SID>SorbetLldbAddBreakpointAtCurrentLine()<CR>
  nnoremap <leader>tp :call <SID>SorbetLldbExpr()<CR>
end

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
  autocmd Filetype cpp        setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype thrift     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype xml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup FileTypeAliases
  autocmd!
  autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
augroup END

" CP bindings.
" Requries an a.in file at the root dir
augroup CompProg
  autocmd Filetype python nnoremap <leader>r :w <bar> !python % < a.in <CR>
augroup END


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
  \   'rg --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case ' . rg_colors . RgArgs(<q-args>), 1,
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
Plug 'chriskempson/base16-vim'
if has("termguicolors")
    set termguicolors
endif

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='base16'
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
let g:github_enterprise_urls = ['git.corp.stripe.com']
noremap <leader>gs :Git<CR>
noremap <leader>gwr :Gwrite<CR>
noremap <leader>ga :Git add --patch<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gv :Gcommit -v<CR>
noremap <leader>gp :Git push<CR>
noremap <leader>gdu :Git diff<CR>
noremap <leader>gdc :Git diff --cached<CR>
noremap <leader>grc :Git rebase --continue<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vinegar.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-vinegar'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ludovicchabant/vim-gutentags'

" Generate tags right after opening vim (empty buffer)
let g:gutentags_generate_on_empty_buffer = 1

" Search tags in buffer by using leader + b.
noremap <silent> <leader>b :silent BTags<CR>

" Update tags using leader + C.
noremap <Leader>C :GutentagsUpdate!<CR>

let g:gutentags_ctags_executable_cpp = 'rtags'

Plug 'zackhsi/fzf-tags'

" Use fzf_tags for searching tags
nmap <C-]> <Plug>(fzf_tags)

Plug 'majutsushi/tagbar'

" Use TT in vim command line to toggle tagbar
:command! TT TagbarToggle

" List files by declaration order
let g:tagbar_sort = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surround, Brackets, Selection, Commenting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'

Plug 'terryma/vim-multiple-cursors'
" No alt key in terminal, use C-a
let g:multi_cursor_select_all_key = '<C-a>'

" Don't use NeoComplete for multiple cursors
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

" Highlight word under cursor
Plug 'pboettch/vim-highlight-cursor-words'

" Comment stuff
Plug 'scrooloose/nerdcommenter'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale, others | Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'

" custom signs
" let g:ale_sign_warning='○'
" let g:ale_sign_error='○'

let g:ale_linters = {
\   'ruby': ['ruby', 'rubocop'],
\   'scala': ['fsc', 'sbtserver', 'scalac', 'scalastyle'],
\   'typescript': ['tsserver', 'tslint'],
\   'python': ['pylint'],
\   'javascript': ['eslint'],
\}
let g:ale_linter_aliases = {}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'typescript': ['tslint'],
\   'cpp': ['clang-format'],
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'yapf'],
\   'scala': ['scalafmt'],
\}

let g:ale_fix_on_save = 1

" Sorbet LSP and Rubocop (Stripe-specific)
Plug 'zackhsi/sorbet-lsp'
if fnamemodify(getcwd(), ':p') == $HOME.'/stripe/pay-server/'
  let g:ale_ruby_rubocop_executable = getcwd() . '/scripts/bin/rubocop'
  call add(g:ale_linters['ruby'], 'sorbet-lsp')
end

" Navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Airline support
let g:airline#extensions#ale#enabled = 1

" Format linter output
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Debug LSP
" let g:ale_command_wrapper = '~/alewrapper.sh'

" HTML tag matching
Plug 'valloric/MatchTagAlways'
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}

" TS support
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" augroup Typescript
"   autocmd!
"   autocmd FileType typescript nnoremap <leader>K :TSTypeDef<CR>
"   autocmd FileType typescript nnoremap <C-]> :TSDef<CR>
"   autocmd FileType typescript nnoremap K :TSDoc<CR>
" augroup END

" Nicer C++ syntax
Plug 'octol/vim-cpp-enhanced-highlight'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete | Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Prevent slow vim exits
function! OnTermClose()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        :quit!
    else
        call feedkeys(" ")
    endif
endfunction
au TermClose * nested call OnTermClose()

" Use Ctrl F for selecting the first completion
imap <C-f> <C-n>

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Ctrl K to fill in the next blank of the snippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

call plug#end()

" colorscheme needs runtime ("echo &rtp") to include Plug directories
" before it can load installed colors.
colorscheme base16-material-palenight

" Optimize tabnine performance -- 200 instead of 1K, 5 instead of 20
call deoplete#custom#var('tabnine', {
\ 'line_limit': 200,
\ 'max_num_results': 5,
\ })
