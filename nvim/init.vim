"""
" Plugins
"

call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-git'
Plug 'chriskempson/base16-vim'

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
set termguicolors

set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set copyindent

" Show tabs and end-of-line whitespace
set listchars=tab:»·,trail:·,nbsp:◊
set list

" List of vim syntaxes to highlight in rST code blocks
let g:rst_syntax_code_list = ['vim', 'c', 'cpp', 'python', 'sh']



"""
" Mappings
"

nmap <silent> <Leader>/ :nohlsearch<CR>

" Easier window moving
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk



"""
" CtrlP
"

let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'undo', 'line',
                         \ 'changes', 'mixed', 'bookmarkdir']

noremap <silent> <Leader>pf :Denite file_rec<CR>
noremap <silent> <Leader>pm :Denite file_mru<CR>
noremap <silent> <Leader>pb :Denite buffer<CR>
noremap <silent> <Leader>px :Denite buffer file_mru file_rec<CR>
noremap <silent> <Leader>pg :Denite grep<CR>



"""
" Statusline
"

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



"""
" Syntax highlighting
"

" Colorscheme
colorscheme base16-atelier-dune

" Color spaces at end of lines bright red for visibility
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()



"""
" Indentation
"

augroup indentation
	autocmd!
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 noet
augroup END


" Horrible hack to work-around weird corrupted lines on window resize
" https://github.com/neovim/neovim/issues/7861
autocmd VimResized * redraw!
