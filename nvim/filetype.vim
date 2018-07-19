augroup filetypedetect
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
  autocmd BufRead,BufNewFile *.h                  setfiletype c
augroup END
