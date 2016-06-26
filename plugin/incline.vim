if exists('g:loaded_incline')
  finish
endif
let g:loaded_incline = 1

let s:save_cpo = &cpo
set cpo&vim


nnoremap <silent><Plug>(incline-inc)          :<C-u>call incline#linewise_increment()<CR>
nnoremap <silent><Plug>(incline-dec)          :<C-u>call incline#linewise_decrement()<CR>
vnoremap <silent><Plug>(incline-inc)          :call incline#linewise_increment()<CR>
vnoremap <silent><Plug>(incline-dec)          :call incline#linewise_decrement()<CR>
vnoremap <silent><Plug>(incline-inc-inclined) :call incline#inclined_increment()<CR>
vnoremap <silent><Plug>(incline-dec-inclined) :call incline#inclined_decrement()<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
