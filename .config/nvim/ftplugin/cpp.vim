" set foldmethod=syntax
" set keywordprg=cppman

set sts=2
set ts=2
set sw=2
set expandtab
set cscopetag

let g:termdebug_map_K = 0
let g:termdebug_wide = 1
packadd termdebug

nnoremap <leader>A :ClangdSwitchSourceHeader<CR>

if expand("%:p:h") =~ '/home/astadnik/edu/competitive/*'
	nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'ninja -C build && ./build/app' ENTER <CR>
	nnoremap <buffer> <silent> <leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && gdb ./build/app' ENTER <CR>
	" nnoremap <buffer> <silent> <leader><leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && gdb ./build/app' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/gl-vision/*'
	set makeprg=ninja\ -C\ \/home\/astadnik\/gl-vision\/build
	nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DBUILD_APPS=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DWITH_PYBIND=ON -G Ninja -B build && ninja -C build generate-lidar-scene3 && ./build/apps/generate-lidar-scene3/generate-lidar-scene3' ENTER <CR>
	" nnoremap <buffer> <silent> <leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug .. && make -j 6 && gdb ./app' ENTER <CR>
	nnoremap <buffer> <leader><CR> :Termdebug ./build/apps/generate-lidar-scene3/generate-lidar-scene3<CR>
elseif expand("%:p:h") =~ '/home/astadnik/edu/univ/*'
	set makeprg=ninja\ -C\ \/home\/astadnik\/edu\/univ\/sem_6\/additional_sections\/lab_2\/build
	" nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && ./build/app' ENTER <CR>
	" nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'ninja -C build && ./build/tests/test && ./build/app' ENTER <CR>
	nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'ninja -C build && ./build/app' ENTER <CR>
	nnoremap <buffer> <leader><CR> :Termdebug ./build/app<CR>
	" nnoremap <buffer> <silent> <leader><leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && lldb ./build/app' ENTER <CR>
	nnoremap <buffer> <silent> <leader><leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && gdb ./build/app' ENTER <CR>
elseif expand("%:p:h") =~ '/home/astadnik/lane_detection/LaneSegmentationCpp/*'
	nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'ninja -C build && ./build/app' ENTER <CR>
	nnoremap <buffer> <leader><CR> :Termdebug ./build/app<CR>
	nnoremap <buffer> <silent> <leader><leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && gdb ./build/app' ENTER <CR>
else
	nnoremap <buffer> <silent> <CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'ninja -C build && ./build/app' ENTER <CR>
	nnoremap <buffer> <leader><CR> :Termdebug ./build/app<CR>
	nnoremap <buffer> <silent> <leader><leader><CR> :AsyncRun tmux send-keys -t debug:1.1 'clear' ENTER 'cmake -DCMAKE_BUILD_TYPE=Debug -G Ninja -B build && ninja -C build && gdb ./build/app' ENTER <CR>
endif
