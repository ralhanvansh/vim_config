"Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
source ~/.vimrc.before
endif

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

au BufRead,BufNewFile *.vue set ft=html

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'darthmall/vim-vue'
call vundle#end()
filetype plugin indent on


call plug#begin('~/.vim/plugged')

Plug 'hwartig/vim-seeing-is-believing'  " get the result of ruby code
Plug 'ervandew/supertab'
Plug 'kchmck/vim-coffee-script'
Plug 'skwp/greplace.vim'
Plug 'tomtom/tcomment_vim'              " Toggle comments easily
Plug 'thoughtbot/vim-rspec'
Plug 'Townk/vim-autoclose'              " Insert matching pair () {} []
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'               " Run commands in tmux pane
Plug 'tpope/vim-endwise'                " Add end after ruby blocks
Plug 'tpope/vim-fugitive'               " Git wrapper
Plug 'tpope/vim-rails'                  " Rails support
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'               " Easily change quotes/bracket pairs
Plug 'tpope/vim-unimpaired'             " Misc mappings like ]<space> or ]c
Plug 'vim-ruby/vim-ruby'                " support for ruby
Plug 'ctrlpvim/ctrlp.vim'               " searching in vim
Plug 'rizzatti/dash.vim'                " support for dash
Plug 'mileszs/ack.vim'                  " Use Ag for search
Plug 'terryma/vim-multiple-cursors'     " Sublime text style multiple cursors
Plug 'dyng/ctrlsf.vim'                  " Find in multiple files
Plug 'tpope/vim-haml'
Plug 'nanotech/jellybeans.vim'          "vim color scheme
Plug 'KeitaNakamura/neodark.vim'
Plug 'scwood/vim-hybrid'
Plug 'nightsense/carbonized'
Plug 'nightsense/office'
Plug 'nightsense/seagrey'
Plug 'nightsense/vrunchbang'
call plug#end()  " All of your Plugins must be added before the following line

" ================ General Config ====================

" colorscheme jellybeans
" colorscheme neodark
" colorscheme sialoquent
 colorscheme hybrid
" colorscheme carbonized-dark
" let g:carbonized_dark_LineNr = 'off'
" colorscheme office-dark
" colorscheme seagrey-dark
"  colorscheme vrunchbang-dark
  let g:vrunchbang_dark_LineNr = 'off'

set background=dark
highlight Normal ctermfg=grey ctermbg=black

set termguicolors
set number relativenumber              "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set nu
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","
set timeout timeoutlen=1500

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set linebreak    "Wrap lines at convenient points

" ================ Custom Settings ========================

" Window pane resizing
nnoremap <silent> <Leader>[ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>] :exe "resize " . (winheight(0) * 2/3)<CR>

" ===== Seeing Is Believing =====
" " Assumes you have a Ruby with SiB available in the PATH
" " If it doesn't work, you may need to `gem install seeing_is_believing -v
" 3.0.0.beta.6`
" " ...yeah, current release is a beta, which won't auto-install
"
" " Annotate every line
"
nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"
"  " Annotate marked lines
"
nmap <leader>n :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
"
"  " Remove annotations
"
nmap <leader>c :%.!seeing_is_believing --clean<CR>;
"
"  " Mark the current line for annotation
"
nmap <leader>m A # => <Esc>
"
"  " Mark the highlighted lines for annotation
"
vmap <leader>m :norm A # => <Esc>

autocmd StdinReadPre * let s:std_in=1

map <Leader>y "+y
map <Leader>d "+d

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

let g:spec_runner_dispatcher = "VtrSendCommand! {command}"

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>

" For ruby block selections
runtime macros/matchit.vim

" For Running plain Ruby test scripts
nnoremap <leader>r :RunSpec<CR>
nnoremap <leader>l :RunSpecLine<CR>
nnoremap <leader>e :RunSpecLastRun<CR>
nnoremap <leader>cr :RunSpecCloseResult<CR>

" ================ My own customization ==============

set lazyredraw " Don't redraw screen when running macros.

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map  <leader>dd   :Dash<cr>
map  <leader>mv   :call RenameFile()<cr>
map  <leader>rm   :!rm %
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

map <Leader>ac :sp app/controllers/application_controller.rb<cr>
map <Leader>bb :!bundle install<cr>
map <Leader>d orequire 'byebug'<cr>byebug<esc>:w<cr>
map <Leader>l oRails.logger.info "DEBUG: "
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>F :CtrlSF -R "<C-R><C-W>"
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=80
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" Set the tag file search order
set tags=./tags;

" Use Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Ignore stuff that can't be opened
set wildignore+=tmp/**

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Use ag for text search
let g:ackprg = 'ag --vimgrep'

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp file

let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_position = 'bottom'

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-d>'

