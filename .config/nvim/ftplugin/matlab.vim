setlocal commentstring=%%s
if has('unix')
	let g:neoterm_default_mod = ':vertical'
	" nnoremap <leader>r :T octave --no-gui<CR>
	" nnoremap <CR> :?%%?+, /%%/- TREPLSendLine<CR>:noh<CR>
	" " nnoremap <CR> :TREPLSendLine<CR>
	" vnoremap <CR> :TREPLSendSelection<CR>
	let g:neoterm_repl_octave_qt = 1
else
	" autocmd VimEnter * call timer_start(20, { tid -> execute('MatlabLaunchServer')})
	autocmd FileType matlab setlocal commentstring=%\ %s
	let g:matlab_auto_mappings = 0
	" " nnoremap <buffer>         <leader>rn :MatlabRename
	" " nnoremap <buffer><silent> <leader>fn :MatlabFixName<CR>
	vnoremap <buffer> <CR>              : <C-u>MatlabCliRunSelection<CR>
	nnoremap <buffer><silent> <CR>      : MatlabCliRunCell<CR>
	" nnoremap <buffer><silent> <C-h> :MatlabCliRunLine<CR>
	nnoremap <buffer><silent> <C-m>i    : MatlabCliViewVarUnderCursor<CR>
	" vnoremap <buffer><silent> ,i <ESC>:MatlabCliViewSelectedVar<CR>
	nnoremap <buffer><silent> K         : MatlabCliHelp<CR>
	" nnoremap <buffer><silent> ,e <ESC>:MatlabCliOpenInMatlabEditor<CR>
	nnoremap <buffer><silent> <leader>c : MatlabCliCancel<CR>
	nnoremap <buffer><silent> <C-m>l    : MatlabNormalModeCreateCell<CR>
	vnoremap <buffer><silent> <C-m>l    : <C-u>MatlabVisualModeCreateCell<CR>
	" inoremap <buffer><silent> <C-m>l <C-o>:MatlabInsertModeCreateCell<CR>
endif
