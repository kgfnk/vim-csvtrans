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

function! csvconv#SqlSelect(table) range
	'<,'>python c.range[:] = sql_select(c.range)
endfunction

function! csvconv#SqlInsert(table) range
	'<,'>python c.range[:] = sql_insert(c.range)
endfunction

function! csvconv#SqlUpdate(table) range
	'<,'>python c.range[:] = sql_update(c.range)
endfunction

vnoremap <Leader>tr :call csvconv#Transpose()<CR>

vnoremap <Leader>tss :call csvconv#SqlSelect(input("table:"))<CR>

vnoremap <Leader>tsi :call csvconv#SqlInsert(input("table:"))<CR>

vnoremap <Leader>tsu :call csvconv#SqlUpdate(input("table:"))<CR>
