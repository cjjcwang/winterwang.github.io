---
layout: post
title: "日本の塗り分け地図を描く"
mathjax: true
comments: true
category: R
tags: [R, leaflet, interactive, 日本人口]
---



日本を人口動態データを結合したinteractiveな塗り分け地図を`leaflet`のパッケージを利用して描く．

流れは以下：  

1. 日本都道府県地図データ(.shape)を[入手する](http://www.gadm.org/download)；
2. 人口動態データを入手し，地図データと結合する；
3. 必要なパッケージ`leaflet, rgdal`により，塗り分け地図を描く．


### 地図データを[Global Administrative Areas](http://www.gadm.org/country)からダウロード：

`Country`のプールダウンメニューから`Japan`を選び，`File Format`を`shapefile`にしてOKを押せば，ダウロードが可能．  
解凍すれば`JPN_adm(0-2).(shp/shx/cpg/dbf/csv/prj)`の合計１８個ファイルが入っている．
そのうち都道府県の境界データが`JPN_adm1.shp`にあるため，これと`.dbf; .shx`の３つを作業するフォルダにコピペ．


{% highlight r %}
#必要なパッケージを読み込む
library(leaflet)
library(rgdal)
#ダウロードした地図ファイルの保存先を決める"JPN_adm1.shp; JPN_adm1.dbf; JPN_adm1.shx"の３つだけをそこに置く
dns <- "/github_projects/winterwang.github.io/files/" # <- 自分の保存先のアドレスに変える
# Shape ファイルを認識させる：
fn <- list.files(dns, pattern = ".shp", full.names = FALSE)
fn <- gsub(".shp","",fn)
# Shape地図を読み込む
shape <- readOGR(dns, fn)
{% endhighlight %}


{% highlight r %}

## OGR data source with driver: ESRI Shapefile
## Source: "/github_projects/winterwang.github.io/files/", layer: "JPN_adm1"
## with 47 features
## It has 12 fields
{% endhighlight %}


{% highlight r %}
#地図データをチェックする：
leaflet(shape) %>% addTiles() %>%
  setView( 137, 36, zoom = 5)
{% endhighlight %}


  <iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
  /fig/jpmap.html
  "></iframe>




### 人口動態データのダウロード：
人口動態データはいくつかのサイトから入手することが可能だが，今回は[**がん登録・統計**](http://ganjoho.jp/reg_stat/statistics/dl/index.html)の公開したデータを利用する．
５番目の**"都道府県別死亡データ"**の項目における，**全がん死亡数・粗死亡率・年齢調整死亡率**のExcelファイルをダウロードする．
ファイルの中身をチェックしてみると：  
①のpopの中にある②全年齢の人口データをRのな中読み込んいけばよい．
![pop](http://winterwang.github.io/image/pop.png)



{% highlight r %}
library(reshape2) # for data manipulation
#Excelなどで不要な部分を削除しデータファイルを作業するフォルダに置く"population.csv"
population <- read.csv("github_projects/winterwang.github.io/files/population.csv", header  = TRUE, colClasses = "character")

str(population)
{% endhighlight %}


{% highlight r %}
## 'data.frame':	2880 obs. of  5 variables:
##  $ 都道府県番号: chr  "0" "0" "0" "1" ...
##  $ 都道府県    : chr  "全国" "全国" "全国" "北海道" ...
##  $ 年          : chr  "1995" "1995" "1995" "1995" ...
##  $ 性別        : chr  "男女計" "男" "女" "男女計" ...
##  $ 全年齢      : chr  "125570246" "61574398" "63995848" "5692321" ...
{% endhighlight %}


{% highlight r %}
head(population)
{% endhighlight %}


{% highlight r %}
##   都道府県番号 都道府県   年   性別    全年齢
## 1            0     全国 1995 男女計 125570246
## 2            0     全国 1995     男  61574398
## 3            0     全国 1995     女  63995848
## 4            1   北海道 1995 男女計   5692321
## 5            1   北海道 1995     男   2736844
## 6            1   北海道 1995     女   2955477
{% endhighlight %}


{% highlight r %}
names(population)
{% endhighlight %}


{% highlight r %}
## [1] "都道府県番号" "都道府県"     "年"           "性別"        
## [5] "全年齢"
{% endhighlight %}


{% highlight r %}
#2014年調査人口データの部分だけを抽出する
names(population) <- c("Pref_n", "NL_NAME_1", "Year", "Sex", "Population")
pop_all2014 <- subset(population, Year == "2014")
pop_all2014 <- subset(pop_all2014, Pref_n != "0") #全国人口の行を削除する
pop_all2014 <- pop_all2014[, -1]
pop_all2014.w <- dcast(pop_all2014, NL_NAME_1 ~ Sex, value.var="Population") # データの形をlongからwide変形する．

head(pop_all2014.w)#県の名前の最後に”県”がない
{% endhighlight %}


{% highlight r %}
##   NL_NAME_1      女      男  男女計
## 1      三重  936000  890000 1825000
## 2      京都 1359000 1250000 2610000
## 3      佐賀  442000  393000  835000
## 4      兵庫 2896000 2645000 5541000
## 5    北海道 2855000 2545000 5400000
## 6      千葉 3115000 3082000 6197000
{% endhighlight %}


{% highlight r %}
head(shape@data)#県の名前の最後に全部”県”が付いている
{% endhighlight %}


{% highlight r %}
##   ID_0 ISO NAME_0 ID_1 NAME_1 HASC_1 CCN_1 CCA_1 TYPE_1  ENGTYPE_1
## 0  114 JPN  Japan    1  Aichi  JP.AI     0  <NA>    Ken Prefecture
## 1  114 JPN  Japan    2  Akita  JP.AK     0  <NA>    Ken Prefecture
## 2  114 JPN  Japan    3 Aomori  JP.AO     0  <NA>    Ken Prefecture
## 3  114 JPN  Japan    4  Chiba  JP.CH     0  <NA>    Ken Prefecture
## 4  114 JPN  Japan    5  Ehime  JP.EH     0  <NA>    Ken Prefecture
## 5  114 JPN  Japan    6  Fukui  JP.FI     0  <NA>    Ken Prefecture
##   NL_NAME_1  VARNAME_1
## 0    愛知県       Aiti
## 1    秋田県       <NA>
## 2    青森県       <NA>
## 3    千葉県 Tiba|Tsiba
## 4    愛媛県       <NA>
## 5    福井県      Hukui
{% endhighlight %}


{% highlight r %}
pop_all2014.w$NL_NAME_1 <- paste(pop_all2014.w$NL_NAME_1, "県", sep = "")
pop_all2014.w$NL_NAME_1[pop_all2014.w$NL_NAME_1 == "東京県"] <- "東京都"
pop_all2014.w$NL_NAME_1[pop_all2014.w$NL_NAME_1 == "大阪県"] <- "大阪府"
pop_all2014.w$NL_NAME_1[pop_all2014.w$NL_NAME_1 == "京都県"] <- "京都府"
pop_all2014.w$NL_NAME_1[pop_all2014.w$NL_NAME_1 == "北海道県"] <- "北海道"

#県の名前により，dataframeの結合
shape <- merge(shape, pop_all2014.w, by = "NL_NAME_1")

#Popup messageを設定する
i_popup <- paste0(shape$NL_NAME_1,
                  "<br>",
                  shape$"男女計",
                  "<br>",
                  "男",shape$"男",
                  "<br>",
                  "女",shape$"女")
#色の範囲を設定する                
pal <- colorNumeric("YlGnBu", domain = as.numeric(shape$"男女計"), n = 20)
#塗り分け地図作成
leaflet(shape) %>% addTiles() %>%
  setView(137, 36, zoom = 5) %>%
  addPolygons(fillColor = ~pal(as.numeric(shape$"男女計")),
              fillOpacity = 1,
              color = "#000000",
              weight = 1, popup = i_popup) %>%
  addLegend("bottomright", pal = pal, values = ~as.numeric(shape$"男女計"),
    title = "Population of Japan in 2014",
    opacity = 1)
{% endhighlight %}


<iframe chart_1="" height="500" width="800" id="iframe-" class="rChart datamaps " seamless="" scrolling="no" src="
/fig/jpmap2.html
"></iframe>
