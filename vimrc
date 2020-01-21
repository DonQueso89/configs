" Important things for beginners:
" * Start out small... Don't jam your vimrc full of things you're not ready to
"   immediately use.
" * Read other people's vimrc's.
" * Use a plugin manager for christ's sake! (I highly recommend vundle)
" * Spend time configuring your editor... It's important. Its the tool you
"   spend 8 hours a day crafting your reputation.
" * remap stupid things to new keys that make you more efficient.
" * Don't listen to the haters that complain about using non-default
"   key-bindings. Their argument is weak. I spend most of my time in the editor
"   on my computer, not others, so I don't care if customizing vim means I'll
"   have a harder time using remote vim.
"
" Below I've left some suggestions of good default settings to have in a bare
" minimal vimrc. You only what you want to use, and nothing more. I've heavily
" commented each, and these are what I consider bare necessities, my workflow
" absolutely depends on these things.
"
" If you have any questions, email me at pthrash@me.com

" Setup Vundle:
" For this to work, you must install the vundle plugin manually.
" https://github.com/gmarik/vundle
" To install vundle, copy all the files from the repo into your respective
" folders within ~/.vim
set nocompatible " no VI
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set rtp+=/usr/local/opt/fzf

" Vundle let's you specify a plugin in a number of formats, but my favorite
" allows you to grab plugins straight off of github, just specify the bundle
" in the following format:
" Plugin 'githubUsername/repoName'

" Let vundle manage itself:
Plugin 'VundleVim/Vundle.vim'

" Just a shitload of color schemes.
" https://github.com/flazz/vim-colorschemes#current-colorschemes
Plugin 'flazz/vim-colorschemes'

" Fuzzy finder -- absolutely must have.
Plugin 'kien/ctrlp.vim'

" Support for easily toggling comments.
Plugin 'tpope/vim-commentary'

" Proper JSON filetype detection, and support.
Plugin 'leshill/vim-json'

" vim already has syntax support for javascript, but the indent support is
" horrid. This fixes that.
Plugin 'pangloss/vim-javascript'

" vim indents HTML very poorly on it's own. This fixes a lot of that.
Plugin 'indenthtml.vim'

" I write markdown a lot. This is a good syntax.
Plugin 'tpope/vim-markdown'

" LessCSS -- I use this every day.
Plugin 'groenewege/vim-less'

" Async linting
Plugin 'dense-analysis/ale'

" File explorer
Plugin 'scrooloose/nerdtree'

" Scala linter
Plugin 'derekwyatt/vim-scala'

" Vim status bar
Plugin 'vim-airline/vim-airline'

" Vim code completer TODO
Plugin 'Valloric/YouCompleteMe'

" Black formatter
Plugin 'psf/black'

" Import sorting
Plugin 'fisadev/vim-isort'


call vundle#end()

" We have to turn this stuff back on if we want all of our features.
filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = ","

" Leader command namespace
" Jump to definition
nnoremap <leader>m :YcmCompleter GoTo<CR>

" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

" So we don't have to reach for escape to leave insert mode.
inoremap jf <esc>

" create new vsplit, and switch to it.
noremap <leader>v <C-w>v

" bindings for easy split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use sane regex's when searching
nnoremap / /\v
vnoremap / /\v

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>


" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Plugin settings:
" Below are some 'sane' (IMHO) defaults for a couple of the above plugins I
" referenced.

" Map the key for toggling comments with vim-commentary
nnoremap <leader>c <Plug>CommentaryLine

" Shortcut for black formatter
nnoremap <leader>b :Black<CR>

" Let ctrlp have up to 30 results.
let g:ctrlp_max_height = 10

" Always keep the sign gutter open
let g:ale_sign_column_always = 1

let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint', 'jscs'],
\   'python': ['flake8'],
\   'scala': ['scalac'],
\}

" Solve issue with disappearing cursor when there are linting warnings
let g:ale_echo_cursor = 0

let g:vim_isort_map= '<C-i>'

" Finally the color scheme. Choose whichever you want from the list in the
" link above (back up where we included the bundle of a ton of themes.)
colorscheme molokai

" Open NERDtree automatically when starting vim
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Force write when editing file owned by root
cmap w!! q !sudo tee %

" Linenumbers
set number

" 80 character line
set colorcolumn=80

" Fix backspace
set backspace=indent,eol,start

set encoding=utf-8
