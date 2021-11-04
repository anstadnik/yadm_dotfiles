xmap <silent> <leader>c <Plug>SlimeRegionSend
nmap <silent> <leader>c <Plug>SlimeMotionSend
nmap <silent> <leader><CR> <Plug>SlimeParagraphSend
let g:slime_default_config = {"socket_name": "default", "target_pane": "debug:1.1"}
nmap <leader><CR> <Plug>SlimeParagraphSend
nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py %' ENTER <CR>

autocmd FileType python let b:coc_root_patterns = ['.git', '__init__.py', 'main.py']

"""""""""""""
"  RUNNING  "
"""""""""""""

if expand("%:p:h") =~ '/home/astadnik/codewars/*'
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t edu:1.2 'clear' ENTER 'py main.py' ENTER <CR>
	" nnoremap <silent> <CR> :AsyncRun tmux send-keys -t codewars:1.2 'clear' ENTER 'py game.py' ENTER <CR>
	" nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py main.py' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/univ/sem_5/games/mario/*'
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/univ/sem_5/games/mario/main.py' ENTER <CR>
elseif expand("%:p:h") =~ 'home/astadnik/gl-vision/apps/gt_data_converter/*'
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/gl-vision/apps/gt_data_converter/main.py' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/gl-vision/apps/explore_gt_data/*'
	nnoremap <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'py /home/astadnik/gl-vision/apps/explore_gt_data/main.py' ENTER <CR>
endif
