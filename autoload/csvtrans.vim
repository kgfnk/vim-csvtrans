if exists('g:loaded_vim_csvtrans')
  finish
endif
let g:loaded_vim_csvtrans = 1

if !has("python3")
	finish
endif

let s:save_cpo = &cpo
set cpo&vim

let s:pyscript = resolve(expand('<sfile>:p:h:h')) . '/plugin/csvtrans.py'
execute 'pyfile ' . s:pyscript

"pyfile csvtrans.py
python from vim import current as c

function! csvtrans#Transpose() range
	'<,'>python c.range[:] = transpose(c.range)
endfunction

function! csvtrans#SqlSelect(table) range
	'<,'>python c.range[:] = sql_select(c.range)
endfunction

function! csvtrans#SqlInsert(table) range
	'<,'>python c.range[:] = sql_insert(c.range)
endfunction

function! csvtrans#SqlUpdate(table) range
	'<,'>python c.range[:] = sql_update(c.range)
endfunction

function! csvtrans#SqlDelete(table) range
	'<,'>python c.range[:] = sql_delete(c.range)
endfunction

function! csvtrans#HtmlTable() range
	'<,'>python c.range[:] = html_table(c.range)
endfunction

function! csvtrans#HtmlDiv() range
	'<,'>python c.range[:] = html_div(c.range)
endfunction

function! csvtrans#HtmlSelect() range
	'<,'>python c.range[:] = html_select(c.range)
endfunction

function! csvtrans#HtmlUl() range
	'<,'>python c.range[:] = html_ul(c.range)
endfunction

function! csvtrans#HtmlInput(type) range
	'<,'>python c.range[:] = html_input(c.range)
endfunction

function! csvtrans#MarkdownTable() range
	'<,'>python c.range[:] = markdown_table(c.range)
endfunction

function! csvtrans#Json() range
	'<,'>python c.range[:] = tojson(c.range)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
