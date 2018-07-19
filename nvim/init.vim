"""
" Plugins
"

call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

" Base16 colorschemes
Plug 'chriskempson/base16-vim'

" Statusline replacement
Plug 'itchyny/lightline.vim'

" Change working directory to project root when opening file
Plug 'airblade/vim-rooter'

" Fuzzy finder.  Requires fzf package to be installed
Plug 'junegunn/fzf.vim'

" Better language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
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

" Fzf
let g:fzf_command_prefix = 'Fzf'

" Language Client
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> <Leader>f :call LanguageClient_textDocument_formatting()<CR>

" rust.vim
let g:rust_clip_command = 'xclip -selection clipboard'
vnoremap <Leader>= :'<,'>RustFmtRange<CR>
nnoremap <Leader>= :RustFmt<CR>


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
" Filetypes
"
augroup filetypedetect
	autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
	autocmd BufRead,BufNewFile *.h                  setfiletype c
augroup END


" Horrible hack to work-around weird corrupted lines on window resize
" https://github.com/neovim/neovim/issues/7861
autocmd VimResized * redraw!


"""
" Mappings
"

nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Easier window moving
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <Leader>p :FzfFiles<CR>
nnoremap <leader>b :FzfBuffers<CR>
