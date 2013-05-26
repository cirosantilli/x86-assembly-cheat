if expand('%:e') =~ '\(asm\|S\)'
  call MapAllBuff( '<F6>'  , ':call RedirStdoutNewTabSingle("make run RUN=''\"' . expand('%:r')  . '\"''")<CR>' )
    "run individual files by basename
  call MapAllBuff( '<F9>'  , ':call RedirStdoutNewTabSingle("make profile RUN=''\"' . expand('%:r')  . '\"''")<CR>' )
    "profile individual files by basename
else
  call MapAllBuff( '<F5>'  , ':w<CR>:make<CR>' )
  call MapAllBuff( '<F6>'  , ':call RedirStdoutNewTabSingle("make run")<CR>' )
  call MapAllBuff( '<F9>'  , ':w<CR>:call RedirStdoutNewTabSingle("make profile")<CR>' )
endif
