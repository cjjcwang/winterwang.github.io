map <- Leaflet$new()
map$setView(c(51.505, -0.09), zoom = 13)
map$tileLayer(provider = 'Stamen.Watercolor')
map$marker(
  c(51.5, -0.09),
  bindPopup = 'Hi. I am a popup'
)
map

map <- ichoropleth(Crime ~ State, data = subset(violent_crime, Year == 2010))
map2 <- ichoropleth(Crime ~ State, data = violent_crime, animate = "Year")
map3 <- ichoropleth(Crime ~ State, data = violent_crime, animate = "Year", play = TRUE)


library(rMaps)
crosslet(
  x = "country", 
  y = c("web_index", "universal_access", "impact_empowerment", "freedom_openness"),
  data = web_index
)


library(rMaps)
map <- Leaflet$new()
map$setView(c(51.505, -0.09), zoom = 13)
map$tileLayer(provider = 'Stamen.Watercolor')
map$tileLayer(provider = "MapQuestOpen.OSM")
map$marker(
  c(51.5, -0.09),
  bindPopup = 'Hi. I am a popup'
)
map

L2 <- Leaflet$new()
L2$setView(c(29.7632836,  -95.3632715), 10)
L2$tileLayer(provider = "MapQuestOpen.OSM")
L2


L2 <- Leaflet$new()
L2$setView(c(35.175776,  137.040663), 13)
L2$tileLayer(provider = "MapQuestOpen.OSM")
L2$marker(
  c(35.191379, 137.047885),
  bindPopup = 'Hi. I am here. | 快来打我啊！'
)
L2




library(devtools)  #百度的地图开发包
install_github('lchiffon/REmap')
library(REmap)
city_vec = c("北京","Shanghai","广州")
get_city_coord("Shanghai")
#get_city_coord(city_vec)
get_geo_position(city_vec)


绘制迁徙地图

绘制地图使用的是主函数`remap`

remap(mapdata, title = "", subtitle = "", 
      theme =get_theme("Dark"))

set.seed(125)
origin = rep("北京",10)
destination = c('上海','广州','大连','南宁','南昌',
                '拉萨','长春','包头','重庆','常州')
dat = data.frame(origin,destination)
out = remap(dat,title = "REmap实例数据",subtitle = "theme:Dark")
plot(out)
 


尝试绘制日本地图
＃导入leaflet 和rgdal包
library(leaflet)
library(rgdal)
＃设置你下载的shapefile的路径
dns <- "/media/ccwang-letsnote/Windows/Users/Chaochen_Wang/Dropbox/github_projects/Japanshape"
＃获取shape文件
fn <- list.files(dns, pattern=".shp", full.names=FALSE)
fn<-gsub(".shp", "", fn)
＃读取shape文件
shape <- readOGR(dns, fn[1])
Japan <- leaflet(shape) %>% addTiles() %>%
  setView(136.9064, 35.18145, zoom = 14)
