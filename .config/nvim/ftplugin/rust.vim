" set foldmethod=syntax
" set keywordprg=cppman

" set sts=2
" set ts=2
" set sw=2
" set expandtab
" set cscopetag

nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo run' ENTER <CR>
if expand("%:p:h") =~ '/home/astadnik/edu/competitive/*'
	" nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo test -- --nocapture' ENTER <CR>
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo test -- --nocapture --test-threads 1' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/edu/rustlings/*'
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'rustlings verify' ENTER <CR>
endif
" nnoremap <silent> <CR> :RustRunnables<CR>
" nnoremap <silent> <leader><CR> :RustDebuggables<CR>
