# vim-csvtrans
=======

CSVファイルを加工するvimプラグイン
ヴィジュアルモードで選択したCSVデータを他の形式へ変換を行う。

## インストール

* vimでpythonインターフェースが利用できること。

.vimrc
```
NeoBundle "kgfnk/vim-csvtrans"
```

要インストール： [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim)

## コマンド

`<Leader>tr` 行列入れ替え

```
1,2,3,4
A,B,C,D
E,F,G,H
```

↓

```
1,A,E
2,B,F
3,C,G
4,D,H
```

### SQLへ変換

`<Leader>tsi` SQL INSERT文へ変換

```
col1,col2,col3,col4,col5
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
insert into hoge (col1, col2, col3, col4, col5) values (1, 'A', 'E', '01', 1)
insert into hoge (col1, col2, col3, col4, col5) values (2, 'B', 'F', '02', 2)
insert into hoge (col1, col2, col3, col4, col5) values (3, 'C', 'G', '03', 3)
```

`<Leader>tsu` SQL UPDATE文へ変換

```
col1,col2,col3,col4,col5
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
update hoge set col2 = 'A', col3 = 'E', col4 = '01', col5 = 1 where col1 = 1
update hoge set col2 = 'B', col3 = 'F', col4 = '02', col5 = 2 where col1 = 2
update hoge set col2 = 'C', col3 = 'G', col4 = '03', col5 = 3 where col1 = 3
```

`<Leader>tss` SQL SELECT文へ変換

```
col1,col2,col3,col4,col5
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
select col1, col2, col3, col4, col5 from hoge where col1 = 1
select col1, col2, col3, col4, col5 from hoge where col1 = 2
select col1, col2, col3, col4, col5 from hoge where col1 = 3
```

### HTMLへ変換

`<Leader>tht`

```
col1,col2,col3
data1-1,data1-2,data1-3
data2-1,data2-2,data2-3
```

↓

```
<table>
  <tr>
    <td>col1</td>
    <td>col2</td>
    <td>col3</td>
  </tr>
  <tr>
    <td>data1-1</td>
    <td>data1-2</td>
    <td>data1-3</td>
  </tr>
  <tr>
    <td>data2-1</td>
    <td>data2-2</td>
    <td>data2-3</td>
  </tr>
</table>
```

`<Leader>thd`

```
col1,col2,col3
data1-1,data1-2,data1-3
data2-1,data2-2,data2-3
```

↓

```
<div>
  <div>col1</div>
  <div>col2</div>
  <div>col3</div>
</div>
<div>
  <div>data1-1</div>
  <div>data1-2</div>
  <div>data1-3</div>
</div>
<div>
  <div>data2-1</div>
  <div>data2-2</div>
  <div>data2-3</div>
</div>
```

`<Leader>thl`

```
リスト1
リスト2
リスト3
リスト4
```

↓

```
<ul>
  <li>リスト1</li>
  <li>リスト2</li>
  <li>リスト3</li>
  <li>リスト4</li>
</ul>
```

`<Leader>ths`

```
1,選択1
2,選択2
3,選択3
4,選択4
```

↓

```
<select>
  <option value="1">選択1</option>
  <option value="2">選択2</option>
  <option value="3">選択3</option>
  <option value="4">選択4</option>
</select>
```

`<Leader>thi`

```
name1,値1
name2,値2
name3,値3
name4,値4
```

↓

```
<input type="hidden" id="name1" name="name1" value="値1" />
<input type="hidden" id="name2" name="name2" value="値2" />
<input type="hidden" id="name3" name="name3" value="値3" />
<input type="hidden" id="name4" name="name4" value="値4" />
```

### Markdown Tableへ変換

`<Leader>tmt`

```
col1,col2,col3
data1-1,data1-2,data1-3
data2-1,data2-2,data2-3***
data3-1,data3-2*****,data3-3
```

↓

```
|col1   |col2        |col3      |
|-------|------------|----------|
|data1-1|data1-2     |data1-3   |
|data2-1|data2-2     |data2-3***|
|data3-1|data3-2*****|data3-3   |
```
