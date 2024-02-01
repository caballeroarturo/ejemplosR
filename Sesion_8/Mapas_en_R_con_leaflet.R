pacman::p_load(dplyr, leaflet, sf, foreign, viridisLite)

gc()
gc()

" Donde estoy??? "
getwd()

path <- "/home/caballero/Descargas"
setwd(path)
getwd()

## -------------------------  
" Leer el DBF"

cp <- read.dbf("cp_cdmx/CP_09CDMX_v7.dbf")

# Abrir geojson
url <- "https://datos.cdmx.gob.mx/dataset/7abff432-81a0-4956-8691-0865e2722423/resource/95482697-af9d-440a-a65b-4d289e5fcd5c/download/correos-postales.json"

cp <- sf::st_read(url) %>% sf::st_transform('+proj=longlat +datum=WGS84')
cp

cp %>% # datos
  leaflet() %>% # voy hacer un mapa
  addPolygons() %>% # tipo de geometría 
  addTiles()


##################################

url <- "https://datos.cdmx.gob.mx/dataset/7a017dd2-0dec-44f2-b550-10af1a6ee120/resource/8e282e10-f39c-4b02-8e0b-b7f6835218be/download/infraestructura-vial-ciclista.json"

mapa <- sf::st_read(url)%>%
  sf::st_transform('+proj=longlat +datum=WGS84')
mapa
unique(mapa$NOMBRE)
# Color de las vías (LINEAS)
paleta <- colorFactor("viridis",unique(mapa$NOMBRE))

mapa %>% # datos
  leaflet() %>% # aquí digo q haré un mapa
  addProviderTiles("CartoDB.Positron") %>% # el fondo (mapabase) 
  addPolylines(label =  ~NOMBRE,
               color = paleta(unique(mapa$NOMBRE))) %>% # son lineas, Geometry type: MULTILINESTRING
  addLegend(pal = paleta, values = ~ NOMBRE) # esto es la leyenda 


mapa %>% # datos
  leaflet() %>% # aquí digo q haré un mapa
  addProviderTiles("CartoDB.Positron") %>% # el fondo (mapabase) 
  addPolygons(data=cp, color = "lightblue", label = ~d_cp) %>% 
  addPolylines(label =  ~NOMBRE,
               color = paleta(unique(mapa$NOMBRE))) %>% # son lineas, Geometry type: MULTILINESTRING
  addLegend(pal = paleta, values = ~ NOMBRE) # esto es la leyenda 


##################################
 #Colinias

url <- "https://datos.cdmx.gob.mx/dataset/67cbf831-8432-4b74-94ca-90f974bf7663/resource/0de96dd6-dbf7-4c8b-8642-d1c27e82ed92/download/centros-de-atencin-a-la-violencia-contra-las-mujeres-por-colonia-en-la-ciudad-de-mxico.json"
mapa <- sf::st_read(url)%>%
  sf::st_transform('+proj=longlat +datum=WGS84')
mapa

mapa %>% # datos
  leaflet() %>% # voy a hacer un mapa 
  addProviderTiles("CartoDB.Positron") %>% #basemap mapa base
  addPolygons() #son poligonos























