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
                               menuItem("Velkommen", tabName = "welcome", icon=icon("cake")),
                               menuItem("Transport og logistikk", tabName = "logistics", icon=icon("car")),
                               menuItem("Områdekart", tabName = "map", icon=icon("map-signs")),
                               menuItem("Timeplan", tabName = "timetable", icon=icon("calendar-alt")),
                               menuItem("Dykkeplasser", tabName = "divesites", icon=icon("flag")),
                               menuItem("Utstyr & Info", tabName = "equipment", icon=icon("cubes")),
                               menuItem("Sikkerhetsregler", tabName = "safety", icon=icon("thermometer-empty")),
                               menuItem("Kontakt", tabName = "contact", icon=icon("phone")),
                               menuItem("Sponsorer", tabName = "sponsors", icon=icon("gift")),
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
      tabItem(tabName="welcome",
              h2("Velkomstfane her")
              ),
      tabItem(tabName="logistics",
              h2("Ved Ankomst (prosedyre nedenfor)"),
              # fluidRow(
              #   box(title = "Oversiktskart - trykk på markørene for info",
              #       width=12,
              #       status = "info",
              #       collapsible=F,
              #       collapsed=F,
              #       leafletOutput("mainmap"))
              # )
      ),
      tabItem(tabName = "map",
              h2("Områdekart"),
              fluidRow(
                box(title = "Trykk på markørene for info",
                    width=12,
                    status = "info",
                    collapsible=F,
                    collapsed=F,
                    leafletOutput("mainmap"))
              )
        
      ),
      tabItem(tabName="timetable",
              h2("NM i Undervannsfoto"),
              fluidRow(
                tabBox(width = 12,
                       tabPanel("Dag 1 - Torsdag",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 1",
                                    subtitle = "10.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Levering av utstyr",
                                        date = "12:00 - 17:00",
                                        "Sted: Steinbrygga klubbhuset til DUK"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Informasjonsmøte",
                                        date = "18:00 - 18:30",
                                        "Sted: Oscarsborg Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Omvisning Oscarsborg",
                                        date = "18:30 - 20:00",
                                        "Sted: Oscarsborg"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Kick-off middag",
                                        date = "20:00 - 21:00",
                                        "Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Mingling i baren",
                                        date = "21:00 - 24:00",
                                        "Sted: Oscarsborg Hotell"
                                      )
                                    ),
                                    footer = "For detaljert stedslokasjon se Områdekart i app-meny"
                                  )#end social box
                                )#end fluidRow
                                
                                ),
                       tabPanel("Dag 2 - Fredag",
                                fluidRow(
                                  socialBox(
                                    height=12,
                                    width=12,
                                    title = "Timeplan dag 2",
                                    subtitle = "11.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Frokost",
                                        date = "07:30 - 08:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "08:00 - 09:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 1",
                                        date = "09:00 - 11:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Lunsj",
                                        date = "12:30 - 13:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "13:30 - 14:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 2",
                                        date = "14:30 - 17:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Innlevering av minnebrikker",
                                        date = "17:00 - 18:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Felles middag",
                                        date = "20:00 - 21:00",
                                        "Sted: Oscarsborg Hotell (se kart)"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Mingling i baren",
                                        date = "21:00 - ",
                                        "Sted: Oscarsborg Hotell (se kart)"
                                      )
                                      
                                    ),
                                    footer = "For detaljert stedslokasjon se kart"
                                  )#end social box
                                )
                                ),
                       tabPanel("Dag 3 - Lørdag",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 3",
                                    subtitle = "12.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Frokost",
                                        date = "07:30 - 08:00",
                                        "Sted: Oscarsborg Hotell "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "08:00 - 09:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 1",
                                        date = "09:00 - 11:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Lunsj",
                                        date = "12:30 - 13:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "13:30 - 14:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 2",
                                        date = "14:30 - 16:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Innlevering av minnebrikker",
                                        date = "16:30 - 17:30",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Festmiddag",
                                        date = "19:00 - 21:00",
                                        "Sted: Hovedfortet Oscarsborg (se kart)"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Mingling i baren",
                                        date = "21:00 - 24:00",
                                        "Sted: Hovedfortet Oscarsborg"
                                      )
                                    ),
                                    footer = "For detaljert stedslokasjon se kart"
                                  )#end social box
                                )
                                ),
                       tabPanel("Dag 4 - Søndag",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 4",
                                    subtitle = "13.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Frokost",
                                        date = "08:00 - 10:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Utsjekking",
                                        date = "10:00 - 11:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Premieutdeling",
                                        date = "10:00 - 12:00",
                                        "Sted: "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Hjemreise",
                                        date = "12:00 - 13:00",
                                        "Takk for nå og god tur hjem! :)"
                                      )
                                    ),
                                    footer = "For detaljert stedslokasjon se kart"
                                  )#end social box
                                )
                                
                       )
                       
                )
                
              )  #end fluidRow
              
              ),
      tabItem(tabName="divesites",
              box(title = "Oversikt aktuelle dykkeplasser for gjennomføring av NM",
                  width=12,
                  status = "info",
                  collapsible=F,
                  collapsed=F,
                  h4("For detaljert informasjon om dykkeplassene trykk på markørene på kartet."),
                  leafletOutput("divemap1")
                  )),
     
      tabItem(tabName="equipment",
              h2("Utstyr")
      ),
      tabItem(tabName = "safety",
              fluidPage(
                h1("Sikkerhetsregler for Apparatdykkere i Drøbak Undervannsklubb (DUK)"),
                  
                  box(title="1)	 All dykking i regi av DUK skal foregå med utnevnt dykkeleder (DL).",
                      width = 12,
                      status = "info"),
                  box(title = "2)	 Dykker skal følge DLs retningslinjer og instrukser.",
                      width=12,
                      status = "info"),
                  box(title= "3)	Solo dykking skal ikke tillates hvor DUK står som arrangør",
                      width=12,
                      status = "info"),
                box(title="4)	 Sørg for å være opplagt og i god nok form, både fysisk og mentalt til å dykke.",
                    width=12,
                    status = "info",
                    box(title="Utfyllende informasjon:",
                        width=12,
                        collapsible=TRUE,
                        collapsed=TRUE,
                        tags$ul(
                          tags$li("Det er ingen grunn til å føle skam å trekke seg før, eller under et dykk når man ikke føler seg i form."),
                          tags$li("Ta hensyn til strøm, vind, temperatur, is, sikt i vannet og båttrafikk ved planlegging av dykket."),
                          tags$li("Avtal maks dybde og total dykketid og meddel dykkeleder i god tid."),
                          tags$li("Ved «hopp» fra båt skal ut-ventil på tørrdrakt være stengt, luft i vinge/vest, pusteventil i munnen og maske på."),
                          tags$li("Gi DL OK-signal, eller signal om hjelp i tilfelle problemer."),
                          tags$li("Hold sammen med meddykker(e) under hele nedstigningen, og kontroller underveis for eventuelle lekkasjer eller andre forhold, og vær forberedt å kunne hjelpe.")
                        )
                    )
                ), 
                box(title="5)	 Planlegg dykket med meddykker(e), og avtal dette med DL. ref.",
                    width=12,
                    status = "info",
                        box(title="Utfyllende informasjon:",
                            width=12,
                            collapsible=TRUE,
                            collapsed=TRUE,
                            tags$ul(
                              tags$li("Avtal rutiner hvis det dykkes ulikt, med åpent og lukket pustesystem, og om det benyttes undervannsscooter, foto/video, jakt osv."),
                              tags$li("Sørg for å være kjent med hverandres nivå/erfaringer ifm planlegging av dykket.")
                              
                            )
                        )
                    
                ),
                  box(title="6)	 Gjennomfør kameratsjekk, avklar rutiner for dykket og følg prosedyre:",
                      width=12,
                      status = "info",
                      box(title="Utfyllende informasjon:",
                          width=12,
                          collapsible=TRUE,
                          collapsed=TRUE,
                          tags$ul(
                            tags$li("Mister man kontakt med meddykker under dykket er hovedregelen at man leter i 1 - 2 minutter."),
                            tags$li("Er det resultatløst avbryter man dykket og gjennomfører en forsvarlig oppstigning."),
                            tags$li("Må man gjennomføre deko- eller sikkerhetsstopp anbefales det at man skyter bøye slik at de på 
                                    overflaten unngår en eventuell leteaksjon hvis man blir meldt savnet av meddykker."),
                            h4(""),
                            tags$li("Hvis meddykker ønsker å avslutte dykket, skal han/hun følges til sikker i land eller i båt, 
                                    og avtal med dykkelder for videre dykking. Dette gjelder også hvis det dykkes i team på tre eller flere, 
                                    da skal hele teamet avbryte dykket og følge vedkommende helt til overflaten og påse at hun/han har 
                                    sikret oppdrift og fått kontakt med dykkeleder før teamet kan fortsette dykket. ")
                          )
                      )
                      ),
                  box(title="7)	 Alle dykkere skal ha dykkersertifikat og har fylt 15 år. Du er selv ansvarlig for å være kvalifisert til dykket. 
                      Dykker under 15 år skal meddykker være nærmeste foresatt",
                      width=12,
                      status = "info"),
                  box(title="8)	 Avtal rutiner for samhold.",
                      width=12,
                      status = "info"
                     ),
                box(title="9)	 Planlegg gassforbruk og nok reservegass. Koordineres med meddykker(e).",
                    width=12,
                    status = "info",
                    box(title="Utfyllende informasjon:",
                        width=12,
                        collapsible=TRUE,
                        collapsed=TRUE,
                        tags$ul(
                          tags$li("Sørg for å ha nok pustegass til å kunne håndtere en nødsituasjon under hele dykket for både deg selv og meddykker.")
                        )
                    )
                    
                ),
                box(title="10)	 Alle dykkere er selv ansvarlig for å kontrollere at det dykkes med riktig pustegass på flaskene.",
                    width=12,
                    status = "info",
                    box(title="Utfyllende informasjon:",
                        width=12,
                        collapsible=TRUE,
                        collapsed=TRUE,
                        tags$ul(
                          tags$li("Sørg for å ha egnet pustegass for dykket og at du har nok gass, inkludert reserve."),
                          tags$li("Gjør deg kjent med meddykkers gassplan om den er forskjellig."),
                          tags$li("Om du har fylt flaskene selv, eller fått fylt av andre, 
                                     er du selv ansvarlig for å kontrollere at du har riktig pustegass (luft/Nitrox/Trimix) på flasken(e)"),
                          tags$li("Analyser gassen før dykk, og noter gassverdien på flsken(e)."),
                          tags$li("Be om hjelp hvis du er usikker.")
                        )
                    )
                ),
                  box(title="11)	 Følg prosedyre ved avsluttet dykk. Bruk av SMB er anbefalt. DUK skiller ikke mellom farge på SMB:",
                      width=12,
                      status = "info",
                      box(title="Utfyllende informasjon:",
                          width=12,
                          collapsible=TRUE,
                          collapsed=TRUE,
                          tags$ul(
                            tags$li("Avtal alltid med meddykker(e) om at du ønsker å avslutte dykket (gi tydelig håndsignal)"),
                            tags$li("Bøye/SMB benyttes som hovedregel ved avslutning av dykket. Anbefaler at minst en har bøye/SMB med seg."),
                            tags$li("Ivareta sikker oppstigning"),
                            tags$li("Hold øye med meddykker under hele oppstigningen"),
                            tags$li("Sikre positiv oppdrift i overflaten ved å stenge utventilen på drakten, 
                                    blåse opp vesten/vingen og drakt. Hold kontakt med meddykker(e)"),
                            tags$li("Dropp bly om nødvendig (blyet er forsikret gjennom NDF ifm nødsituasjon)"),
                            tags$li("Gi OK signal til dykkeleder"),
                            tags$li("Følg DLs rettningslinjer")
                          )
                      )   
                      ),
                  box(title="12) Informasjon til gjestedykker, eller ny i klubben.",
                      width=12,
                      status = "info",
                      box(title="Utfyllende informasjon:",
                          width=12,
                          collapsible=TRUE,
                          collapsed=TRUE,
                          tags$ul(
                            tags$li("Er du gjestedykker/nytt medlem i klubben så gjør deg kjent for DL når du ankommer."),
                            tags$li("Sørg for at DL og meddykkere kjenner ditt erfarings- og sertifiseringsnivå, 
                                    og eventuelle andre relevante faktorer som sykdom eller lignende."),
                            tags$li("Gjestedykkerskjema skal fylles ut om man ikke er registrert som medlem."),
                          )
                      )   
                      ),
                  box(title="13)	 Sørg for at utstyret du dykker med er i forsvarlig teknisk stand.",
                      width=12,
                      status = "info",
                      box(title="Utfyllende informasjon:",
                          width=12,
                          collapsible=TRUE,
                          collapsed=TRUE,
                          tags$ul(
                            tags$li("Du er ansvarlig for at flaskene er sertifisert/trykkprøvd iht Norsk standard."),
                            tags$li("Ved dykking i mørke skal du være utstyrt med reservelykt. "),
                            tags$li("Sørg for at all pusteutstyr (1-. og 2. trinn) er i forsvarlig teknisk stand."),
                            tags$li("Husk at ditt personlige dykkerutstyr skal kunne bli brukt av meddykker under en uønsket hendelse/situasjon.")
                           
                          )
                      )   
                  ),
                box(title="14)	 Ved dykking i mørket skal dykkere være utstyrt med reservelykt som fungerer",
                    width=12,
                    status = "info"),
                box(title="15)	 Dykkere registrerer seg elektronisk før og etter dykk",
                    width=12,
                    status = "info"),
                box(title="16)	 Før fylling av flasker skal flasker kontrolleres for gyldig kontrollmerke",
                    width=12,
                    status = "info"),
                box(title="17)	 Dykking fra klubbhuset skal ferga ved Oscarsborg festning varsles. Se oppslag",
                    width=12,
                    status = "info"),
                box(title="18)	 Følg parkeringsreglene. Se oppslag",
                    width=12,
                    status = "info"),
                box(title="19)	 Dykkere skal være kjent med DUKs vedtekter",
                    width=12,
                    status = "info")
              )
              
      ),
      tabItem(tabName="contact",
              box(title="Kontaktinformasjon",
                  width=12,
                  h2("Kost og losji: Tor - 908 97 535"),
                  h2("Transport og logistikk: Børge - xxxxxxxxx"),
                  h2("Ansvarsområde her: Joachim - 952 41 924"),
                  
                  
                    )
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
  icon_parking <- awesomeIcons(icon = 'parking',iconColor = 'black',library = 'fa',markerColor = "blue")
  icon_boat <- awesomeIcons(icon = 'ship',iconColor = 'black',library = 'fa',markerColor = "green")
  icon_home <- awesomeIcons(icon = 'home',iconColor = 'black',library = 'fa',markerColor = "blue")
  icon_car <- awesomeIcons(icon = 'car',iconColor = 'black',library = 'fa',markerColor = "blue")
  icon_palace <- awesomeIcons(icon = 'wrench',iconColor = 'black',library = 'fa',markerColor = "red")
  icon_hotel <- awesomeIcons(icon = 'hotel',iconColor = 'black',library = 'fa',markerColor = "red")
  icon_landmark <- awesomeIcons(icon = 'university',iconColor = 'black',library = 'fa',markerColor = "red")
  icon_dinner <- awesomeIcons(icon = 'trophy',iconColor = 'black',library = 'fa',markerColor = "red")
  
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
      addAwesomeMarkers(lat = 59.678457, lng = 10.624653, popup="DUK klubbhus og Steinbrygga",icon=icon_home) %>% 
      addAwesomeMarkers(lat = 59.673461, lng = 10.621689, popup="Parkering - Husvikveien",icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.664597, lng = 10.628475, popup="Parkering - Bankløkka",icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.671528, lng = 10.627083, popup="Parkering - Sagajordet",icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.670147, lng = 10.622890, popup="Båt Drøbak - Oscarsborg",icon=icon_boat) %>%  
      #on the event site:
      
      addAwesomeMarkers(lat = 59.676348, lng = 10.607065, popup="Båt Oscarsborg - Drøbak",icon=icon_boat) %>% 
      addAwesomeMarkers(lat = 59.678427, lng = 10.604004, popup="Dykkepalasset - Rigging av utstyr",icon=icon_palace) %>% 
      addAwesomeMarkers(lat = 59.675737, lng = 10.605976, popup="Hotell - Overnatting",icon=icon_hotel) %>% 
      addAwesomeMarkers(lat = 59.673897, lng = 10.606978, popup="Oscarsborg - Omvisning",icon=icon_landmark) %>% 
      addAwesomeMarkers(lat = 59.678345, lng = 10.604299, popup="Oppmøte - dykkebåt",icon=icon_boat) %>% 
      addAwesomeMarkers(lat = 59.673514, lng = 10.607124, popup="Festmiddag",icon=icon_dinner) 
  

    
  })
  
  
  output$divemap1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addAwesomeMarkers(lat = 59.690536, lng = 10.593138, popup="Tronstadodden",icon=icon_dive1) %>% 
      addAwesomeMarkers(lat = 59.702275, lng = 10.592654, popup="Askholmene",icon=icon_dive2) %>%  
      addAwesomeMarkers(lat = 59.678764, lng = 10.609147, popup="Kaholmen",icon=icon_dive3) %>% 
      addAwesomeMarkers(lat = 59.673555, lng = 10.584954, popup="Bergholmen",icon=icon_dive4)
      
  })
  
   
  
  }

shinyApp(ui, server)