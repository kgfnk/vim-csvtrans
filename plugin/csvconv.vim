if !has("python")
	finish
endif

let s:pyscript = resolve(expand('<sfile>:p:h:h')) . '/plugin/csvconv.py'
execute 'pyfile ' . s:pyscript

"pyfile csvconv.py
python from vim import current as c

function! csvconv#Transpose() range
	'<,'>python c.range[:] = transpose(c.range)
endfunction

vnoremap <Leader>tr :call csvconv#Transpose()<CR>
