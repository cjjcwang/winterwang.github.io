---
layout: post
title: "日本の塗り分け地図を描く"
mathjax: true
comments: true
category: R
tags: [R, REmap, interactive]
---


日本を人口動態データを結合したinteractiveな塗り分け地図をRのパッケージ`leaflet`を利用して描く．

流れは以下：
1. 日本都道府県地図データ(.shape)を[入手する](http://www.gadm.org/download)；
2. 人口動態データを入手し，地図データと結合する；
3. 必要なパッケージ`leaflet, maps, rgdal`により，塗り分け地図を描く．


### 地図データを[Global Administrative Areas](http://www.gadm.org/country)からダウロード：

`Country`のプールダウンメニューから`Japan`を選び，`File Format`を`shapefile`にしてOKを押せば，ダウロードが可能．  
解凍すれば`JPN_adm(0-2).(shp/shx/cpg/dbf/csv/prj)`の合計１８個ファイルが入っている．
そのうち都道府県の境界データが`JPN_adm1.shp`にあるため，これと`.dbf; .shx`の３つを作業するフォルダにコピペ．


```r
#必要なパッケージを読み込む
library(leaflet)
library(rgdal)
#ダウロードした地図ファイルの保存先を決める"JPN_adm1.shp; JPN_adm1.dbf; JPN_adm1.shx"の３つだけをそこに置く
dns <- "/media/ccwang-letsnote/Windows/Users/Chaochen_Wang/Dropbox/github_projects/winterwang.github.io/files/" # <- 自分の保存先のアドレスに変える
# Shape ファイルを認識させる：
fn <- list.files(dns, pattern = ".shp", full.names = FALSE)
fn <- gsub(".shp","",fn)
# Shape地図を読み込む
shape <- readOGR(dns, fn)
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "/media/ccwang-letsnote/Windows/Users/Chaochen_Wang/Dropbox/github_projects/winterwang.github.io/files/", layer: "JPN_adm1"
## with 47 features
## It has 12 fields
```

```r
  #地図データをチェックする：
leaflet(shape) %>% addTiles() %>%
  setView( 137, 36, zoom = 5) 
```

<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
/fig/jpmap.html
"></iframe>


### 人口動態データのダウロード：
人口動態データはいくつかのサイトから入手することが可能だが，今回は[**がん登録・統計**](http://ganjoho.jp/reg_stat/statistics/dl/index.html)の公開したデータを利用する．
５番目の**"都道府県別死亡データ"**の項目における，**全がん死亡数・粗死亡率・年齢調整死亡率**のExcelファイルをダウロードする．
ファイルの中身をチェックしてみると：  

①のpopの中にある②全年齢の人口データをRのなかに読み込んいけばよい．  

![pop](http://winterwang.github.io/image/pop.png)

