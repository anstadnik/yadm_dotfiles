" setlocal commentstring=%%s
nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'octave %' ENTER <CR>
