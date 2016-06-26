scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

" Mapping just for vim-repeat
nnoremap <silent><Plug>(incline-inc-repeat)          :<C-u>call <SID>linewise_increment_repeat()<CR>
nnoremap <silent><Plug>(incline-dec-repeat)          :<C-u>call <SID>linewise_decrement_repeat()<CR>
nnoremap <silent><Plug>(incline-inc-inclined-repeat) :<C-u>call <SID>inclined_increment_repeat()<CR>
nnoremap <silent><Plug>(incline-dec-inclined-repeat) :<C-u>call <SID>inclined_decrement_repeat()<CR>

function! incline#inclined_increment() range
  let cnt=v:count1
  let s:fst=a:firstline
  let s:lst=a:lastline
  call s:inclined_action("\<C-a>",cnt)
  silent! call repeat#set("\<Plug>(incline-inc-inclined-repeat)",cnt) 
endfunction
function! incline#inclined_decrement() range
  let cnt=v:count1
  let s:fst=a:firstline
  let s:lst=a:lastline
  call s:inclined_action("\<C-x>",cnt)
  silent! call repeat#set("\<Plug>(incline-dec-inclined-repeat)",cnt) 
endfunction

function! s:inclined_increment_repeat() range
  let cnt=v:count1
  let s:lst=line(".")+s:lst-s:fst
  let s:fst=line(".")
  call s:inclined_action("\<C-a>",cnt)
  silent! call repeat#set("\<Plug>(incline-inc-inclined-repeat)",cnt) 
endfunction
function! s:inclined_decrement_repeat() range
  let cnt=v:count1
  let s:lst=line(".")+s:lst-s:fst
  let s:fst=line(".")
  call s:inclined_action("\<C-x>",cnt)
  silent! call repeat#set("\<Plug>(incline-dec-inclined-repeat)",cnt) 
endfunction

function! incline#linewise_increment() range
  let cnt=v:count1
  let s:fst=a:firstline
  let s:lst=a:lastline
  call s:multiline_action("\<C-a>",cnt)
  silent! call repeat#set("\<Plug>(incline-inc-repeat)",cnt) 
endfunction
function! incline#linewise_decrement() range
  let cnt=v:count1
  let s:fst=a:firstline
  let s:lst=a:lastline
  call s:multiline_action("\<C-x>",cnt)
  silent! call repeat#set("\<Plug>(incline-dec-repeat)",cnt) 
endfunction

function! s:linewise_increment_repeat()
  let cnt=v:count1
  let s:lst=line(".")+s:lst-s:fst
  let s:fst=line(".")
  call s:multiline_action("\<C-a>",cnt)
  silent! call repeat#set("\<Plug>(incline-inc-repeat)",cnt) 
endfunction
function! s:linewise_decrement_repeat()
  let cnt=v:count1
  let s:lst=line(".")+s:lst-s:fst
  let s:fst=line(".")
  call s:multiline_action("\<C-x>",cnt)
  silent! call repeat#set("\<Plug>(incline-dec-repeat)",cnt) 
endfunction

function! s:inclined_action(act,cnt)
  for i in range(s:fst,s:lst)
    call cursor(i,1)
    call s:oneline_action(a:act,a:cnt*(1+i-s:fst)) 
  endfor
  call cursor(s:fst,1)
endfunction

function! s:multiline_action(act,cnt)
  for i in range(s:fst,s:lst)
    call cursor(i,1)
    call s:oneline_action(a:act,a:cnt) 
  endfor
  call cursor(s:fst,1)
endfunction

function! s:oneline_action(act,cnt)
  " normal! ^
  execute "normal! ".a:cnt.a:act
  while col(".")+1 < col("$")
    execute "normal! \<right>"
    let col=col(".")
    let char=getline(".")[col-1] 
    execute "normal! ".a:cnt.a:act
    if(col == col(".") && char ==# getline(".")[col-1])
      break
    endif
  endwhile
  " normal! ^
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
