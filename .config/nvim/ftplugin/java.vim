set foldmethod=syntax
" set keywordprg=cppman

set sts=2
set ts=2
set sw=2
set expandtab
set cscopetag
" let g:loaded_gentags#gtags = 1
" let g:gen_tags#ctags_opts = '--fields=+l'
" let g:gen_tags#use_cache_dir = 0
" let g:gen_tags#ctags_auto_gen = 1
" let g:gen_tags#gtags_default_map = 0
" set tags=./.git/tags_dir/prg_tags;

" Neomake
let g:neomake_open_list = 2
let g:neomake_place_signs = 0
let g:neomake_virtualtext_current_error = 0

packadd termdebug

if expand("%:p:h") =~ '/home/astadnik/univ/sem_5/java/'
	au Filetype cpp nnoremap <silent> <CR> :NeomakeSh tmux send-keys -t debug:1.1 'clear' ENTER 'javac *.java; java' ENTER <CR>
	" nnoremap <silent> <leader><CR> :NeomakeSh tmux send-keys -t debug:1.1 'clear' ENTER 'xmake; xmake r -d' ENTER <CR>
	au Filetype cpp nnoremap <silent> <leader><CR> :NeomakeSh tmux send-keys -t debug:1.1 'clear' ENTER 'javac *.java; jdb' ENTER <CR>
else
	" au Filetype cpp nnoremap <leader><CR> :NeomakeSh make -j8 -C
	" au Filetype cpp nnoremap <leader><leader><CR> :!NeomakeSh make -j8 -C
endif
