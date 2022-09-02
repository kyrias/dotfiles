"""
" Plugins
"

call plug#begin(expand('$XDG_CONFIG_HOME/nvim/plugs'))

" Base16 colorschemes
Plug 'RRethy/nvim-base16'

" Statusline replacement
Plug 'itchyny/lightline.vim'

" Change working directory to project root when opening file
Plug 'airblade/vim-rooter'

" Fuzzy finder.  Requires fzf package to be installed
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" CoC
set updatetime=300
set signcolumn=yes

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <Leader>=  <Plug>(coc-format-selected)
nmap <Leader>=  <Plug>(coc-format)


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
set colorcolumn=100   " Show colored line at column 100
set inccommand=nosplit

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


" Fzf
let g:fzf_command_prefix = 'Fzf'

command! -bang -nargs=? -complete=dir
  \ FzfFiles call fzf#vim#files(<q-args>, {'source': 'rg --files'}, <bang>0)

noremap <Leader>r :FzfRg<space>

noremap <Leader>p :FzfFiles<CR>
noremap <Leader>P :FzfFiles<space>
noremap <Leader>g :FzfGFiles<CR>

nnoremap <Leader>b :FzfBuffers<CR>

noremap <Leader>l :FzfLines<CR>


" ft_sql can bugger off
let g:omni_sql_no_default_maps = 1
