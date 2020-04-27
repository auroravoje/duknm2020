#duk nm info app
library(shiny)
library(shinyjs)
#library(shiny.semantic)
library(shinydashboard)
#library(ShinyRatingInput)
library(shinydashboardPlus)
#library(bs4Dash)
#library(shinyEffects)
library(leaflet)
library(leaflet.extras)
library(shinyWidgets)
library(tidyverse)


ui <- dashboardPage(skin="black",
  dashboardHeader(title="DRØBAK UNDERVANNSKLUBB",
                  tags$li(a(href = 'https://dukk.no/index.php/77-duk/247-norgesmesterskap-i-undervannsfoto-2020',
                            img(src = 'duk_logo.jpg',
                                title = "DUK", height = "30px"),
                            style = "padding-top:10px; padding-bottom:10px;"),
                          class = "dropdown")
                  ),
  dashboardSidebar(sidebarMenu(id="menu",
                               menuItem("Timeplan", tabName = "timetable", icon=icon("calendar-alt")),
                               menuItem("Parkering og båt", tabName = "parking", icon=icon("map")),
                               menuItem("Utstyr", tabName = "equipment", icon=icon("cubes")),
                               menuItem("Kontakt", tabName = "contact", icon=icon("phone")),
                               menuItem("Test geolokasjon", tabName = "testing", icon=icon("chart-bar"))
  )),
  dashboardBody(
    ##background color:
    # tags$head(tags$style(HTML('
    # 
    #                             /* body */
    #                             .content-wrapper, .right-side {
    #                             background-color: #ebebe8;
    #                             }
    # 
    #                             '))),
    #
    
##################################### geo location ################################################
    
    tags$script('
              $(document).ready(function () {
              
                function getLocation(callback){
                var options = {
                  enableHighAccuracy: true,
                  timeout: 5000,
                  maximumAge: 0
                };
                
                navigator.geolocation.getCurrentPosition(onSuccess, onError);
                
                function onError (err) {
                  Shiny.onInputChange("geolocation", false);
                }
                
                function onSuccess (position) {
                  setTimeout(function () {
                    var coords = position.coords;
                    var timestamp = new Date();
                    
                    console.log(coords.latitude + ", " + coords.longitude, "," + coords.accuracy);
                    Shiny.onInputChange("geolocation", true);
                    Shiny.onInputChange("lat", coords.latitude);
                    Shiny.onInputChange("long", coords.longitude);
                    Shiny.onInputChange("accuracy", coords.accuracy);
                    Shiny.onInputChange("time", timestamp)
                  
                    console.log(timestamp);
                
                    if (callback) {
                      callback();
                    }
                  }, 1100)
                }
              }
              
              var TIMEOUT = 1000; //SPECIFY
              var started = false;
              function getLocationRepeat(){
                //first time only - no delay needed
                if (!started) {
                  started = true;
                  getLocation(getLocationRepeat);
                  return;
                }
              
                setTimeout(function () {
                  getLocation(getLocationRepeat);
                }, TIMEOUT);
                
              };
                
              getLocationRepeat();
                
            });
            '),
    
    
###################################################################################################
    
    
    
    
    
    tabItems(
      tabItem(tabName="timetable",
              h2("NM i Undervannsfoto"),
              fluidRow(
                tabBox(width = 12,
                       tabPanel("Dag 1",
                                #uiOutput("dives_list2020")
                                #h4("Timeplan 10.09.2020")
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 1",
                                    subtitle = "10.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 1",
                                        date = "09:00 - 10:00",
                                        "Detaljert info aktivitet 1"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 2",
                                        date = "10:00 - 11:00",
                                        "Detaljert infor aktivitet 2"
                                      )
                                    ),
                                    footer = "Undertekst her"
                                  ),#end social box
                                  box(title = "Dykkeplasser - trykk på markørene for info",
                                      width=12,
                                      status = "info",
                                      collapsible=F,
                                      collapsed=F,
                                      leafletOutput("divemap1")
                                  )
                                )#end fluidRow
                                
                                ),
                       tabPanel("Dag 2",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 2",
                                    subtitle = "11.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 1",
                                        date = "09:00 - 10:00",
                                        "Detaljert info aktivitet 1"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 2",
                                        date = "10:00 - 11:00",
                                        "Detaljert infor aktivitet 2"
                                      )
                                    ),
                                    footer = "Undertekst her"
                                  )#end social box
                                )
                                ),
                       tabPanel("Dag 3",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 3",
                                    subtitle = "12.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 1",
                                        date = "09:00 - 10:00",
                                        "Detaljert info aktivitet 1"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 2",
                                        date = "10:00 - 11:00",
                                        "Detaljert infor aktivitet 2"
                                      )
                                    ),
                                    footer = "Undertekst her"
                                  )#end social box
                                )
                                ),
                       tabPanel("Dag 4",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 4",
                                    subtitle = "13.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 1",
                                        date = "09:00 - 10:00",
                                        "Detaljert info aktivitet 1"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Aktivitet 2",
                                        date = "10:00 - 11:00",
                                        "Detaljert infor aktivitet 2"
                                      )
                                    ),
                                    footer = "Undertekst her"
                                  )#end social box
                                )
                                
                       )
                       
                )
                
              )  #end fluidRow
              
              ),
      tabItem(tabName="parking",
              h2("Parkering og båt"),
              fluidRow(
                box(title = "Oversiktskart - trykk på markørene for info",
                    width=12,
                    status = "info",
                    collapsible=F,
                    collapsed=F,
                    leafletOutput("mainmap"))
              )
      ),
      tabItem(tabName="equipment",
              h2("Utstyr")
      ),
      tabItem(tabName="contact",
              h2("Kontaktinfo")
      ),
      tabItem(tabName= "testing",
              h4("geolocation test"),
              fluidRow(column(width = 5,
                              verbatimTextOutput("lat"),
                              verbatimTextOutput("long"),
                              verbatimTextOutput("geolocation"),
                              verbatimTextOutput("accuracy"),
                              verbatimTextOutput("time"))
                       
              ),
              fluidRow(
                box(leafletOutput("geolocmap"))
              )
              )#end tabItem
    )

  
    )#end dashboardBody
)

server <- function(input, output, session) { 
########################## geolocation ############################  
  
  output$lat <- renderPrint({
    input$lat
  })
  
  output$long <- renderPrint({
    input$long
  })
  
  output$geolocation <- renderPrint({
    input$geolocation
  })
  
  output$accuracy <- renderPrint({
    input$accuracy
  })
  
  output$time <- renderPrint({
    input$time
  })
  
##################################################################### 
 #custom icons:
  icon_usr <- awesomeIcons(icon = 'male',iconColor = 'black',library = 'fa',markerColor = "red")
  icon_parking <- awesomeIcons(icon = 'car',iconColor = 'black',library = 'fa',markerColor = "blue")
  icon_boat <- awesomeIcons(icon = 'ship',iconColor = 'black',library = 'fa',markerColor = "green")
 
  icon_dive1 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'green')
  icon_dive2 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'purple')
  icon_dive3 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'blue')
  icon_dive4 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'red')
  
############### leaflet geolocation map ##################  
  output$geolocmap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addAwesomeMarkers(lat = input$lat, lng = input$long, popup="du er her",icon=icon_usr)    
  })  
  
  # observe({
  #   icon_usr <- awesomeIcons(
  #     icon = 'male',
  #     iconColor = 'black',
  #     library = 'fa',
  #     markerColor = "red"
  #   ) 
  #   
  #   leafletProxy("geolocmap") %>%
  #     #clearMarkers() %>%
  #   
  #   addAwsomeMarkers(lat = input$lat, lng = input$long, popup="du er her",icon=icon_usr) 
  # })
    
############### leaflet main map ##################  
  output$mainmap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addAwesomeMarkers(lat = 59.678457, lng = 10.624653, popup="Info parkering her",icon=icon_parking) %>% 
      addAwesomeMarkers(lat = 59.676348, lng = 10.607065, popup="Info båt her",icon=icon_boat)  

    
  })
  
  
  output$divemap1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addAwesomeMarkers(lat = 59.682692, lng = 10.563494, popup="Dykk 1 - Møkkalasset",icon=icon_dive1) %>% 
      addAwesomeMarkers(lat = 59.702275, lng = 10.592654, popup="Dykk 2 - Askholmene",icon=icon_dive2) %>%  
      addAwesomeMarkers(lat = 59.682692+0.02, lng = 10.563494+0.01, popup="Dykk 3 - Navn dykkeplass",icon=icon_dive3) %>% 
      addAwesomeMarkers(lat = 59.702275 -0.01, lng = 10.592654-0.001, popup="Dykk 4 - Navn dykkeplass",icon=icon_dive4)
    
  })
  
   
  
  }

shinyApp(ui, server)