" xmap <silent> <leader>c <Plug>SlimeRegionSend
" nmap <silent> <leader>c <Plug>SlimeMotionSend
" nmap <silent> <leader><CR> <Plug>SlimeParagraphSend
" let g:slime_default_config = {"socket_name": "default", "target_pane": "debug:1.1"}

"""""""""""""
"  RUNNING  "
"""""""""""""

if expand("%:p:h") =~ '/home/astadnik/codewars/*'
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t edu:1.2 'clear' ENTER 'py main.py' ENTER <CR>
	" nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t codewars:1.2 'clear' ENTER 'py game.py' ENTER <CR>
	" nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py main.py' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/.leetcode/code/*'
	" nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cargo test -- --nocapture' ENTER <CR>
	nnoremap <silent> <CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:terminal leetcode test $PROBLEM_ID<CR>
	nnoremap <silent> <leader><CR> :let $PROBLEM_ID=split(expand('%:t'), '\.')[0]<CR>:terminal leetcode exec $PROBLEM_ID<CR>
elseif expand("%:p:h") =~ '/home/astadnik/univ/sem_5/games/mario/*'
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/univ/sem_5/games/mario/main.py' ENTER <CR>
elseif expand("%:p:h") =~ 'home/astadnik/gl-vision/apps/gt_data_converter/*'
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/gl-vision/apps/gt_data_converter/main.py' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/gl-vision/apps/explore_gt_data/*'
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/gl-vision/apps/explore_gt_data/main.py' ENTER <CR>
else
	" nmap <leader><CR> <Plug>SlimeParagraphSend
	nnoremap <silent> <buffer> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py %' ENTER <CR>
endif
