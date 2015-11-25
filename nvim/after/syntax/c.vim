" Highlight Function names
syn match    cCustomParen    "(" contains=cParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen

hi def link cCustomFunc  Function
