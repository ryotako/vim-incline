# incline.vim
Linewise inclement

## 要約

vimではノーマルモードで&lt;C-a&gt;、&lt;C-x&gt;を実行することにより、数値のインクリメント・デクリメントを行うことができます。  

*incline* はこの機能を拡張し、カーソルが置かれた行にある数字すべてを対象に、インクリメント・デクリメントを実行します。  

20&lt;C-a&gt;のような増やす数字を指定したインクリメントやドット(.)による繰り返しなど、標準の&lt;C-a&gt;、&lt;C-x&gt;と同じように使うことができます。  
 
ただしドットリピートの使用には  
tpope/vim-repeat(https://github.com/tpope/vim-repeat)  
をインストールする必要があります。  

また、Vim 8.0ではビジュアルモードでg&lt;C-a&gt;、g&lt;C-x&gt;を実行することにより、容易に連番を生成することができるようになりました。  
この機能は各行の最初の数値を対象に連番を生成しますが、*incline* では行中の全ての数値を対象に連番を生成することができます。  

##使い方
数値を増減する&lt;C-a&gt;や&lt;C-x&gt;のように使います。  

```vim
map <C-g><C-a> <Plug>(incline-inc)
map <C-g><C-x> <Plug>(incline-dec)
map g<C-g><C-a> <Plug>(incline-inc-inclined)
map g<C-g><C-x> <Plug>(incline-dec-inclined)
```

ここでは、上記のようなキーマッピングをしたものとして説明します。  

```vim
print 0, some_function(0)
```

上のような文にカーソルを置き3&lt;C-g&gt;&lt;C-a&gt;を実行すると、次の結果が得られます。  

```vim
print 3, some_function(3)
```

ビジュアルモードで複数行を対象とすることもできます。  

```vim
print 0, some_function(0)
print 0, some_function(0)
print 0, some_function(0)
```

上の3行をビジュアル選択し3&lt;C-g&gt;&lt;C-a&gt;を実行すると次の結果が得られます。  

```vim
print 3, some_function(3)
print 3, some_function(3)
print 3, some_function(3)
```

3&lt;C-g&gt;&lt;C-a&gt;のかわりにg&lt;C-g&gt;&lt;C-a&gt;とすれば、各行のすべての数字を以下のような連番にすることができます。  

```vim
print 1, some_function(1)
print 2, some_function(2)
print 3, some_function(3)
```

ここでは&lt;C-g&gt;を組み合わせたキーマッピングを紹介しましたが、以下のようにすると「行選択モードで選択した場合のみ、行全体の数値ををインクリメントする」ことができます。  

```vim
" 行選択モードでのみ、行全体インクリメントを適用します
" ビジュアルモードや矩形選択モードでは<C-a>, <C-x>を適用します。
vmap <expr><C-a> mode() ==# "V" ? "\<Plug>(incline-inc)" : "\<C-a>"
vmap <expr><C-x> mode() ==# "V" ? "\<Plug>(incline-dec)" : "\<C-x>"
vmap <expr> g<C-a> mode() ==# "V" ? "\<Plug>(incline-inc-inclined)" :"g\<C-a>"
vmap <expr> g<C-x> mode() ==# "V" ? "\<Plug>(incline-dec-inclined)" :"g\<C-x>"
```

この方法はマッピングのためのキーの消費を抑えることができ、また「行を選ぶ」という行選択モードとの連想により、マッピングを覚えることができます。  

```vim
```

