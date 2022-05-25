if expand("%:p:h") =~ '/home/astadnik/.leetcode/code/*'
	nnoremap <silent> <CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:terminal leetcode test $PROBLEM_ID<CR>
	nnoremap <silent> <leader><CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:terminal leetcode exec $PROBLEM_ID<CR>
else
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py %' ENTER <CR>
endif
