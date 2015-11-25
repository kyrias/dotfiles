" Respect XDG
set directory=$XDG_CACHE_HOME/nvim/swap,/tmp
set backupdir=$XDG_CACHE_HOME/nvim/backup,/tmp
set undodir=$XDG_CACHE_HOME/nvim/undo,/tmp
set runtimepath=$XDG_CONFIG_HOME/nvim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after


call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

" Unite and create user interfaces
"NeoBundle 'Shougo/unite.vim'

" Emmet-like snippet system
Plug 'mattn/emmet-vim'

" Easy text exchange operator
Plug 'tommcdo/vim-exchange'

" Vim runtime files
Plug 'tpope/vim-git'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Fuzzy file/buffer/mru/tag/etc. finder
Plug 'ctrlpvim/ctrlp.vim'

" Asynchronous :make using Neovim's job-control
" Upstream: Plug 'benekastah/neomake'
Plug 'kyrias/neomake', { 'branch': 'clang-check' }

call plug#end()


syntax on
filetype plugin indent on
set copyindent
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

" Use space as a leader
map <space> <Leader>
nmap <silent> <Leader>/ :nohlsearch<CR>

" Toggle spell checking
nmap <silent> <Leader>s :set spell!<CR>

cmap w!! w !sudo tee % >/dev/null

" Tabs are 4 spaces wide
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Automatically hide buffers instead of requiring bangcommands
set hidden

" Easier window moving
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk

" Show tabs and end-of-line whitespace
set listchars=tab:»·,trail:·
set list

" Use clang_check for syntax checking
let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_cpp_checkers = ['clang_check']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" List of vim syntaxes to highlight in rST code blocks
let g:rst_syntax_code_list = ['vim', 'c', 'cpp', 'python', 'sh']

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

" Show syntastic warnings
"if neobundle#is_sourced('syntastic')
"	set statusline+=%#warningmsg#
"	set statusline+=%{SyntasticStatuslineFlag()}
"	set statusline+=%*
"endif

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



" Why does vim set the filetype of .h files as C++?
augroup filetypes
	autocmd!
	autocmd BufRead,BufNewFile *.h set filetype=c
augroup END

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
