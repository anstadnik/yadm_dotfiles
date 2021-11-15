" set foldmethod=syntax
" set keywordprg=cppman

" set sts=2
" set ts=2
" set sw=2
" set expandtab
" set cscopetag

nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo run' ENTER <CR>
nnoremap <silent> <leader><CR> :RustDebuggables<CR>
