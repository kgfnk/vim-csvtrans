vnoremap <silent> <Leader>tr :call csvtrans#Transpose()<CR>
vnoremap <silent> <Leader>tss :call csvtrans#SqlSelect(input("select table?:", expand("%:t:r")))<CR>
vnoremap <silent> <Leader>tsi :call csvtrans#SqlInsert(input("insert table?:", expand("%:t:r")))<CR>
vnoremap <silent> <Leader>tsu :call csvtrans#SqlUpdate(input("update table?:", expand("%:t:r")))<CR>
vnoremap <silent> <Leader>tsd :call csvtrans#SqlDelete(input("delete table?:", expand("%:t:r")))<CR>
vnoremap <silent> <Leader>tht :call csvtrans#HtmlTable()<CR>
vnoremap <silent> <Leader>thd :call csvtrans#HtmlDiv()<CR>
vnoremap <silent> <Leader>ths :call csvtrans#HtmlSelect()<CR>
vnoremap <silent> <Leader>thl :call csvtrans#HtmlUl()<CR>
vnoremap <silent> <Leader>thi :call csvtrans#HtmlInput(input("imput type?", "text"))<CR>
vnoremap <silent> <Leader>tmt :call csvtrans#MarkdownTable()<CR>
vnoremap <silent> <Leader>tj :call csvtrans#Json()<CR>
