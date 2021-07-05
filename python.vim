" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1


" Visual guide for 79 char max line lenght as recommended by PEP 8
setlocal textwidth=79
setlocal colorcolumn=80
highlight ColorColumn ctermbg=88

