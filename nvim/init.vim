"""
" Plugins
"

call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

Plug 'chriskempson/base16-vim' " Base16 colorschemes
Plug 'itchyny/lightline.vim'   " Modeline replacement

Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-git'

call plug#end()


"""
" Plugin settings
"

" Base16
let base16colorspace=256

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


"""
" Builtin things
"

" List of vim syntaxes to highlight in rST code blocks
let g:rst_syntax_code_list = ['vim', 'c', 'cpp', 'python', 'sh']


"""
" NVim settings
"

syntax on
filetype plugin indent on
set hidden            " Automatically hide buffers with changes instead of requiring bangcommands
set number            " Always show line numbers
set ignorecase        " Ignore case of normal letters
set smartcase         " Case-sensitive search unless pattern is all lowercase
set wildignore=*.swp,*.bak,*.pyc,*.o  " File patterns to ignore on wildcard expansion
set title             " Change the terminal's title to the filename
set visualbell        " Don't beep
set backup            " Always keep backup files in case of crashes
set undofile          " Save undo's after file closes
set shortmess+=I      " Don't show the nag-screen
set showcmd           " Show partial command in the last line of the screen
set scrolloff=4       " Minimum number of screen lines under/above the cursor
set linebreak         " Don’t wrap lines in the middle of a word
set spelllang=en_us
set backupdir=$XDG_DATA_HOME/nvim/backup " Don't write backups in current dir
set termguicolors     " Use -guifg/-guibg attributes (24-bit colors)

set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set copyindent

" Show tabs, end-of-line whitespace, and non-breaking spaces
set listchars=tab:»·,trail:·,nbsp:◊
set list

" Colors
colorscheme base16-atelier-dune

" Color spaces at end of lines bright red for visibility
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()



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
" Filetypes
"
augroup filetypedetect
	autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
	autocmd BufRead,BufNewFile *.h                  setfiletype c
augroup END


" Horrible hack to work-around weird corrupted lines on window resize
" https://github.com/neovim/neovim/issues/7861
autocmd VimResized * redraw!
