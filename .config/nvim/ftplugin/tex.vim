let g:tex_flavor='latex'
let g:tex_conceal='abdmgs' 
set conceallevel=2
" setlocal spell
" set spelllang=en_gb,uk,ru
nnoremap <leader>l :TexlabForward<CR>
nnoremap <leader>b :TexlabBuild<CR>
" Inkscape figures
" inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
" nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
