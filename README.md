# vim-incline
Linewise increment

### 概要

*incline* は行全体を対象にインクリメントを行うプラグインです。

`tpope/vim-repeat`(https://github.com/tpope/vim-repeat) をインストールすれば、ドット(.)による繰り返しを行うことができます。
また、ビジュアルモードで`g<C-a>`を押したときのような、傾斜付きインクリメントによる連番生成が可能です。

### 設定例
```vim
" <C-a>や<C-x>のように使います。
" 3gaとすれば現在の行に含まれる数値が3ずつインクリメントされます。
nnoremap ga <Plug>(incline-inc)
nnoremap gx <Plug>(incline-dec)

" 行選択モードでのみ、行全体インクリメントを適用します。
" ビジュアルモードや矩形選択モードでは標準の<C-a>, <C-x>を適用します。
vmap <expr> <C-a> mode() ==# "V" ? "\<Plug>(incline-inc)" : "\<C-a>"
vmap <expr> <C-x> mode() ==# "V" ? "\<Plug>(incline-dec)" : "\<C-x>"

" 行選択モードで選択した行のインクリメントを行いますが、インクリメントする数値が後の行ほど増えます。
" 連番の生成をするのに便利です。
vmap <expr> g<C-a> mode() ==# "V" ? "\<Plug>(incline-inc-inclined) : "g\<C-a>"
vmap <expr> g<C-x> mode() ==# "V" ? "\<Plug>(incline-dec-inclined) : "g\<C-x>"
```

