library(shiny)
library(shinydashboard,  warn.conflicts = FALSE)
library(shinyWidgets,  warn.conflicts = FALSE)
library(bslib)
library(DT)
library(dplyr)
library(stringr)

# los datos y el codigo están en la carpeta "auxiliar"
load("auxiliar/df.RData")
source("auxiliar/graficaydatos.R")

#Aquí por default le está aplicando a los datos una función
nombresPaises <- leeDatos(df)


# ------------------------------------------
# UI
# ------------------------------------------

ui <- fluidPage(
  setBackgroundImage(src = 'fondo1.png'),
  
  
  title = "BEDU: Análisis de datos con R",
  collapsible = TRUE,
  
  
  tabsetPanel(type = "tabs", 
              
    tabPanel(h4("Intro"), icon = icon("map", style="font-size: 30px"),
             fluidRow(
               column(1),
               column(8,      
                 br(), # el comando br() da renglones vacíos 
                 br(),
                 h4("Módulo: Estadística y Programación con R", style ={"color:#FF5733;"}),
                 br(),br(),
                 h1("Pronosticar la cantidad de visitantes o turistas por país", style="color:#2874A6;font-weight:bold;"),
                 br(),
                 h5("Nuestro objetivo es .... , con esto se podría solucionar el problema... Y se lograría que ... "),
               ))
             ),
    
    tabPanel(h4("Datos"), icon = icon("github", style="font-size: 30px"),
             fluidRow(     
               column(3, # es la cantidad de espacios que ocupa la columna, solo puede hasta 12
                br(),
                selectInput(
                  inputId = "pais",
                  label = "Selecciona el país",
                  choices = nombresPaises,
                  selected = "Todos",
                  width = "100%"
                )),
                column(9,
                       br(),
                       h3("Título de la tabla"),
                       DTOutput(outputId = "dfVisitantes", width = "100%")
                      )
                       
             )),
    
    tabPanel(h4("Análisis"), icon = icon("flask", style="font-size: 30px"),
             # aquí va lo que quieran agregar
             fluidRow(     
               column(6,
                 br(),
                 h3("Título de la gráfica 1"),
                 plotOutput("plotVisitantes")
                 ),
               column(6,
                  br(),
                  h3("Descomposición de la serie"),
                  p("Método multiplicativo"),
                  plotOutput("seriedescomp")
                ),
            )),
    
    tabPanel(h4("Resultados"), icon = icon("medal", style="font-size: 30px")
             # aquí va lo que quieran agregar
             ),
    
    tabPanel(h4("Equipo"), icon = icon("people-group", style="font-size: 30px")
             # aquí va lo que quieran agregar
             )
  
    )
)

  # ------------------------------------------
  # Server
  # ------------------------------------------
  server <- function(input, output, session) {
    
    #output grafica 1
    output$plotVisitantes <- renderPlot({
      grafica1(df,input$pais)
    })
    
    #output grafica 2
    output$seriedescomp <- renderPlot({
      grafica2(df,input$pais)
    })
    
    #output Tabla
    output$dfVisitantes <- renderDT({
      if(input$pais == "Todos"){
        japan_df <- df
      }else {
        japan_df <- df[df$Pais == input$pais,]
      }
      dfFiltrado <- japan_df
    })
  }
  
  shinyApp(ui, server)
  
  
  
  
  
  
  
  
  
  
  
  
  