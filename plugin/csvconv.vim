if exists("g:loaded_typecorr")
  finish
endif
let g:loaded_typecorr = 1

let s:save_cpo = &cpo
set cpo&vim

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

function! csvconv#HtmlTable() range
	'<,'>python c.range[:] = html_table(c.range)
endfunction

function! csvconv#HtmlDiv() range
	'<,'>python c.range[:] = html_div(c.range)
endfunction

function! csvconv#HtmlSelect() range
	'<,'>python c.range[:] = html_select(c.range)
endfunction

function! csvconv#HtmlUl() range
	'<,'>python c.range[:] = html_ul(c.range)
endfunction

function! csvconv#HtmlInput(type) range
	'<,'>python c.range[:] = html_input(c.range)
endfunction

vnoremap <silent> <Leader>tr :call csvconv#Transpose()<CR>
vnoremap <silent> <Leader>tss :call csvconv#SqlSelect(input("select table?:"))<CR>
vnoremap <silent> <Leader>tsi :call csvconv#SqlInsert(input("insert table?:"))<CR>
vnoremap <silent> <Leader>tsu :call csvconv#SqlUpdate(input("update table?:"))<CR>
vnoremap <silent> <Leader>tht :call csvconv#HtmlTable()<CR>
vnoremap <silent> <Leader>thd :call csvconv#HtmlDiv()<CR>
vnoremap <silent> <Leader>ths :call csvconv#HtmlSelect()<CR>
vnoremap <silent> <Leader>thl :call csvconv#HtmlUl()<CR>
vnoremap <silent> <Leader>thi :call csvconv#HtmlInput(input("imput type?"))<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
