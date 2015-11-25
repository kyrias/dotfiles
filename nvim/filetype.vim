augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
  au BufReadPost PKGBUILD set syntax=PKGBUILD
augroup END
