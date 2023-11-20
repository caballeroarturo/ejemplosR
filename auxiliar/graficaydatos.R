# función para la gráfica 
grafica1 <- function(df, pais) {
  if(pais == "Todos"){
    japan_timeseries <- ts(df$Visitantes,start=c(2017,1),end=c(2023,12),frequency=12)
  }else {
    japan_timeseries <- ts(df[df$Pais == pais,]$Visitantes,start=c(2017,1),end=c(2023,12),frequency=12)
  }
  plot(japan_timeseries, ylab = paste0("Visitantes de ",pais,", de 2017 a 2023"), xlab = "Tiempo" )
  
}

# funcion de la gráfica de descomposicion
grafica2 <- function(df, pais) {
  
  if(pais != "Todos") {
    df <- df %>% filter(Pais== pais)
  }
  
  japan_mex_timeseries <- ts(df$Visitantes,start=c(2017,1),end=c(2023,12),frequency=12)
  japan_mex_timeseries.decomp <- decompose(japan_mex_timeseries, type = "mult")
  
  plot(japan_mex_timeseries.decomp, xlab = paste0("Seríe de datos de ",pais), 
       sub = "Descomposición de los datos de producción de electricidad")
  
}

# función para leer los datos 
leeDatos <- function(df){
  nombresPaises <- c("Todos",unique(df$Pais))
  return(nombresPaises)
}
