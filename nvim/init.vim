"""
" Plugins
"

call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

Plug 'ctrlpvim/ctrlp.vim'    " Fuzzy file/buffer/mru/tag/etc. finder
Plug 'mattn/emmet-vim'       " Emmet-like snippet system
Plug 'tommcdo/vim-exchange'  " Easy text exchange operator
Plug 'tpope/vim-git'         " Vim runtime files
Plug 'tpope/vim-fugitive'    " Git wrapper

" Asynchronous :make using Neovim's job-control
" Upstream: Plug 'benekastah/neomake'
Plug 'kyrias/neomake', { 'branch': 'clang-check' }

call plug#end()



"""
" Set options
"

syntax on
filetype plugin indent on
set hidden " Automatically hide buffers instead of requiring bangcommands
set number            " always show line numbers
set ignorecase        " Ignore case of normal letters
set smartcase         " ignore case if search pattern is all lowercase,
                      "   case-sensitive otherwise
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.o
set title             " change the terminal's title
set visualbell        " don't beep
set noerrorbells      " don't beep
set backup            " use backup files
set undofile          " save undo's after file closes
set shortmess+=I      " don't show the nag-screen
set showcmd           " Show partial command in the last line of the screen
set scrolloff=1       " Minimum number of screen lines under/above the cursor
set linebreak         " Don’t wrap lines in the middle of a word
set spelllang=en_us
set backupdir=$XDG_DATA_HOME/nvim/backup " Don't write backups in current dir

" Tabs are 4 spaces wide
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set copyindent

" Show tabs and end-of-line whitespace
set listchars=tab:»·,trail:·
set list

" List of vim syntaxes to highlight in rST code blocks
let g:rst_syntax_code_list = ['vim', 'c', 'cpp', 'python', 'sh']



"""
" Mappings
"

" Toggle spell checking
nmap <silent> <Leader>s :set spell!<CR>

cmap w!! w !sudo tee % >/dev/null
" Easier window moving
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk




let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'undo', 'line',
                         \ 'changes', 'mixed', 'bookmarkdir']

nmap <silent> <Leader>p :CtrlPMixed<CR>



""""""""""""""""""""
"" Statusline

set statusline=
set statusline+=[%n]  " Buffer number
set statusline+=%<\   " Where to truncate
set statusline+=%.99f " Relative path to file
set statusline+=\ %y  " Filetype flag, [c]; [help]
set statusline+=%w    " Preview window flag, [Preview]
set statusline+=%m    " Modified flag, [+]; [-]

" Show a warning if file is read only, [RO]
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"if neobundle#is_sourced('vim-fugitive')
	set statusline+=%{fugitive#statusline()}
"endif

" Show a warning if file format isn’t unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" Show a warning if file encoding isn’t utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*


"" Right side of statusline
set statusline+=%=                   " Left/right separation point
set statusline+=%-15.((%l,%c-%v)\ %) " Line, column, percentage. (20,0)
set statusline+=%P                   " Percentage visible

set laststatus=2 " Always show statusline



""""""""""""""""""""
" Syntax highlighting

" Colorscheme
colorscheme Darkcustomside

" Color spaces at end of lines bright red for visibility
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()



augroup indentation
	autocmd!
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 noet
augroup END


""""""""""""""""""""
" Neomake

" Open the location list when adding entries
let g:neomake_open_list = 2

" Run Neomake automatically when saving and entering a file
autocmd! BufWritePost * Neomake
