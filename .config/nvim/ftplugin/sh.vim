" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif


"""""""""""""
"  RUNNING  "
"""""""""""""

if expand("%:p:h") =~ '/home/astadnik/gl-vision/apps/explore_gt_data/*'
	nnoremap <silent> <CR> :NeomakeSh tmux send-keys -t debug:1.2 'clear' ENTER 'sh /home/astadnik/gl-vision/apps/explore_gt_data/run_gt_for_ds.sh /home/astadnik/gl-vision/apps/explore_oxts/dataset_configs/dataset-india_20200127T110828_20200127T110928.conf' ENTER <CR>
endif

