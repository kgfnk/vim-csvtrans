if !has("python")
	finish
endif

pyfile csvconv.py
python from vim import current as c

function! Transpose() range
	'<,'>python c.range[:] = transpose(c.range)
endfunction

vnoremap <Leader>tr :call Transpose()<CR>

