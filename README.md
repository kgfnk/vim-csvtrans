#csvconv
=======

CSVファイルを加工するvimプラグイン
ヴィジュアルモードで選択したCSVデータを加工する。

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

`<Leader>tsi` SQL INSERT文へ変換

```
col1,col2,col3,col4
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
insert into hoge (col1, col2, col3, col4) values (1, 'A', 'E', '01', 1)
insert into hoge (col1, col2, col3, col4) values (2, 'B', 'F', '02', 2)
insert into hoge (col1, col2, col3, col4) values (3, 'C', 'G', '03', 3)
```

`<Leader>tsu` SQL UPDATE文へ変換

```
col1,col2,col3,col4
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
update hoge set col2 = 'A', col3 = 'E', col4 = '01' where col1 = 1
update hoge set col2 = 'B', col3 = 'F', col4 = '02' where col1 = 2
update hoge set col2 = 'C', col3 = 'G', col4 = '03' where col1 = 3
```

`<Leader>tss` SQL SELECT文へ変換

```
col1,col2,col3,col4
1,A,E,01,1
2,B,F,02,2
3,C,G,03,3
```
↓

```
select col1, col2, col3, col4 from hoge where col1 = 1
select col1, col2, col3, col4 from hoge where col1 = 2
select col1, col2, col3, col4 from hoge where col1 = 3
```
