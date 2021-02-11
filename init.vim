"""""""""""""""""""""""""""""""""""
"                                 "
"    General settings/bindings    "
"                                 "
"""""""""""""""""""""""""""""""""""
scriptencoding utf-8
set encoding=utf-8
set clipboard+=unnamedplus         " Use system clipbaord in addition to 0
set colorcolumn=+1                 " line length matters
set foldmethod=indent              " set a foldmethod
set nofoldenable
set mouse=a                        " enable mouse
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
set list                           " Show trailing spaces and all tabs/newlines
set listchars=tab:›\ ,eol:¬,trail:⋅

:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Python magic
let g:python_host_prog = '/Users/vigneshshankar/.pyenv/shims/python'
let g:python3_host_prog = '/Users/vigneshshankar/.pyenv/shims/python3'


let mapleader = "\<Space>"         " Use space as leader

map <Enter> o<ESC>
map <S-Enter> O<ESC>

imap jk <Esc>

" Quick moves
nmap J 15j
vmap J 15j
nmap K 15k
vmap K 15k
nmap H 0
vmap H 0
nmap L $
vmap L $

let s:line_highlight = { 'gui': '#1c1f2b', 'cterm': 235 }
set cursorline

" Line numbers optional
set nonumber
nnoremap <leader>n :set nu!<CR>

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
nnoremap <leader>L :nohl<CR>

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
nnoremap <leader>b :MRU<CR>

" Navigate buffers using leader h/l.
noremap <leader>h :bp <CR>
nnoremap <leader>l :bn <CR>

" Call "make".
nnoremap <leader>mm :!make<CR>

" Close netrw buffers when we open a file.
let g:netrw_fastbrowse = 0

" Never use paste mode
au InsertLeave * set nopaste

""""""""""""""""""
"                "
"    Autocmds    "
"                "
""""""""""""""""""
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
  autocmd Filetype cpp        setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype thrift     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype vim        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype xml        setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype yaml       setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup CompetitiveProgramming
  autocmd Filetype python nnoremap <F9> :w <bar> !python3 %:r.py < %:r.test<CR>
  autocmd Filetype cpp nnoremap <F9> :w <bar> !g++ -Wall -Wno-unused-result -std=c++11   -O0   % -o %:r && ./%:r < %:r.test<CR>
  autocmd Filetype cpp nnoremap <F10> :!./%:r<CR>
  autocmd Filetype cpp,python nnoremap <leader>te gg:r ~/workspace/algo-practice/template.cpp<CR>
  autocmd Filetype cpp,python nnoremap <leader>tc :vsp %:r.test<CR>
  autocmd Filetype cpp,python nnoremap <leader>tp :vsp %:r.test<CR>gg0VGp:w<CR><c-w>h
augroup END

augroup FileTypeAliases
  autocmd!
  autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
  autocmd BufNewFile,BufRead Brewfile set filetype=ruby
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
  autocmd BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  autocmd BufRead,BufNewFile *.eex set filetype=eelixir
augroup END

augroup CS3203
  autocmd BufRead */3203/*Test*.cpp  nnoremap <leader>t mb?TEST_CASEf(llya"'b:nohl<CR>:VtrSendCommandToRunner! make unit_testing TEST_TARGET=<C-R>+<CR>
  autocmd BufRead */3203/* nnoremap <leader>T :VtrSendCommandToRunner! make unit_testing<CR>
  autocmd BufRead */3203/* nnoremap <leader>mu :VtrSendCommandToRunner! make unit_testing<CR>
  autocmd BufRead */3203/* nnoremap <leader>mi :VtrSendCommandToRunner! make integration_testing<CR>
  autocmd BufRead */3203/* nnoremap <leader>mb :VtrSendCommandToRunner! make build<CR>
  autocmd BufRead */3203/* nnoremap <leader>mc :VtrSendCommandToRunner! make clean<CR>
  autocmd BufRead */3203/* nnoremap <leader>mf :VtrSendCommandToRunner! make format<CR>
augroup END

function! Formatonsave()
  let l:formatdiff = 1
  pyf ~/workspace/dotfiles/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()


"""""""""""""""
"             "
"    Boxes    "
"             "
"""""""""""""""
if executable('boxes')
  let g:boxes_types = {
        \"bash": "shell",
        \"vim":  "vim-box",
        \}
  let g:boxes_config_file = '~/boxes-config'

  function CallBoxes(line_or_lines, v, h)
    let boxed_title_lines = systemlist('boxes'
          \. ' -p ' . 'v' . a:v . 'h' . a:h
          \. ' -f ' . g:boxes_config_file
          \. ' -d ' . get(g:boxes_types, &filetype, "shell")
          \, a:line_or_lines)
    return append(line('.'), boxed_title_lines)
  endfun

  function BoxCurrentLine(v, h)
    let current_line = trim(getline("."))
    call CallBoxes(current_line, a:v, a:h)
    call deletebufline(bufname(), line("."))
  endfun

  function BoxLines(v, h) range
    let visual_lines = map(getline(line("'<"), line("'>")), {_, val -> trim(val)})
    call deletebufline(bufname(), line("'<"), line("'>"))
    normal k
    call CallBoxes(visual_lines, a:v, a:h)
    normal 2j
  endfun

  nmap <leader>dt :call BoxCurrentLine(1,4)<CR>
  nmap <leader>ds :call BoxCurrentLine(0,4)<CR>
  vmap <leader>dt :call BoxLines(1,4)<CR>
  vmap <leader>ds :call BoxLines(0,4)<CR>
endif

""""""""""""""
"            "
"    Plug    "
"            "
""""""""""""""
call plug#begin('~/.config/nvim/plugged')
nnoremap <leader>P :PlugInstall<CR>

"""""""""""""""""""""""""""
"    FZF & Rg | Search    "
"""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf
Plug '/usr/local/bin/fzf'
Plug 'junegunn/fzf.vim'

" MRU Buffers
Plug 'yegappan/mru'

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

"""""""""""""""""""""""""
"    Themes / Colors    "
"""""""""""""""""""""""""
" Color
Plug 'drewtempelmeyer/palenight.vim'
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


" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "palenight"
let g:airline#extensions#tabline#enabled = 1
let g:airline_disabled=0


""""""""""""""""""""""""""""""""""""
"    GitGutter, Fugitive | Git.    "
""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""
"    Vinegar    "
"""""""""""""""""
Plug 'tpope/vim-vinegar'

"""""""""""""""""""""""""""""""""""""""""""""""""""
"    Surround, Brackets, Selection, Commenting    "
"""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'tpope/vim-surround'

" Highlight word under cursor
Plug 'pboettch/vim-highlight-cursor-words'

" Comment stuff
Plug 'scrooloose/nerdcommenter'

Plug 'jiangmiao/auto-pairs'

""""""""""""""""
"    Syntax    "
""""""""""""""""

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

Plug 'elixir-editors/vim-elixir'

Plug 'neovimhaskell/haskell-vim'

"""""""""""""
"    LSP    "
"""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
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
      \"coc-solargraph",
      \"coc-go",
      \"coc-java",
      \]

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Jump between errors
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

" Goto mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-refactor)

" Preview definition using i
nmap <silent> <leader>i :call CocActionAsync('doHover')<cr>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" TS syntax
Plug 'HerringtonDarkholme/yats.vim'

" Vue syntax
Plug 'posva/vim-vue'

""""""""""""""""""
"    Org mode    "
""""""""""""""""""
Plug 'jceb/vim-orgmode'


"""""""""""""""
"    Cmake    "
"""""""""""""""
Plug 'vhdirk/vim-cmake'

""""""""""""""
"    Tmux    "
""""""""""""""
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
nnoremap <leader>mm :VtrSendCommandToRunner! make<CR>
call plug#end()

" Tmux
let g:VtrOrientation = "v"
let g:VtrPercentage = 35


colorscheme palenight

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
