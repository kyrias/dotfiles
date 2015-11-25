augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
  autocmd BufRead,BufNewFile *.h                  setfiletype c
  au BufReadPost PKGBUILD set syntax=PKGBUILD
augroup END
