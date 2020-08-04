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
library(shinyWidgets)
library(leafpop)


ui <- dashboardPage(skin="black",
  dashboardHeader(title="DRØBAK UNDERVANNSKLUBB",
                  tags$li(a(href = 'https://dukk.no/index.php/77-duk/247-norgesmesterskap-i-undervannsfoto-2020',
                            img(src = 'duk_logo.jpg',
                                title = "DUK", height = "30px"),
                            style = "padding-top:10px; padding-bottom:10px;"),
                          class = "dropdown")
                  ),
  dashboardSidebar(sidebarMenu(id="menu",
                               menuItem("Timeplan og områdekart", tabName = "timetable", icon=icon("calendar-alt")),
                               #menuItem("Velkommen", tabName = "welcome", icon=icon("cake")),
                               #menuItem("Transport og logistikk", tabName = "logistics", icon=icon("car")),
                               menuItem("Utstyr & Logistikk", tabName = "equipment", icon=icon("cubes")),
                               #menuItem("Områdekart", tabName = "map", icon=icon("map-signs")),
                               menuItem("Dykkeplasser", tabName = "divesites", icon=icon("flag")),
                               menuItem("HMS og Sikkerhet", tabName = "safety", icon=icon("thermometer-empty")),
                               menuItem("Kontakt", tabName = "contact", icon=icon("phone"))
                               #menuItem("Sponsorer", tabName = "sponsors", icon=icon("gift"))#,
                               #menuItem("Test geolokasjon", tabName = "testing", icon=icon("chart-bar"))
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
              
              var TIMEOUT = 2000; //SPECIFY
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
      # tabItem(tabName="welcome",
      #         #h2("Velkomstfane her")
      #         widgetUserBox(
      #           width=12,
      #           collapsed=TRUE,
      #           title = "NM i Undervannsfoto",
      #           subtitle = "10. - 13. September 2020",
      #           type = NULL,
      #           src = "duknm_logo.jpg",
      #           background = TRUE,
      #           backgroundUrl = "temporary_jellyfish2.jpg",
      #           closable = FALSE,
      #           "Velkommen!",
      #           footer = "All informasjon du måtte trenge i løpet av NM finner du i sidemenyen. Hilsen Drøbak Undervannsklubb."
      #         )
      # ),
      tabItem(tabName="logistics",
              h2("Ved Ankomst (prosedyre nedenfor)")
             
      ),
      tabItem(tabName = "map",
              # h2("Områdekart"),
              # fluidRow(
              #   box(title = "Trykk på markørene for info",
              #       width=12,
              #       status = "info",
              #       collapsible=F,
              #       collapsed=F,
              #       leafletOutput("mainmap"))
              # )
        
      ),
      tabItem(tabName="timetable",
              fluidRow(
                widgetUserBox(
                  width=12,
                  collapsed=TRUE,
                  title = "NM i Undervannsfoto",
                  subtitle = "10. - 13. September 2020",
                  type = NULL,
                  src = "duknm_logo.jpg",
                  background = TRUE,
                  backgroundUrl = "temporary_jellyfish2.jpg",
                  closable = FALSE,
                  "Velkommen!",
                  footer = "All informasjon du måtte trenge i løpet av NM finner du i denne appen. 
                  Timeplan, kart over arrangementområdet og parkering finner du nedenfor. 
                  Kartet kan zoomes og markørene kan trykkes på for ytterligere informasjon.
                  Sjekk også ut sidemenyen ved å klikke på knappen i øvre venstre hjørne."
                )
              ),
              h2("Timeplan"),
              fluidRow(
                tabBox(width = 12,
                       tabPanel("Dag 1",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 1 - Torsdag",
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
                                    footer = "For detaljert stedslokasjon se kart."
                                  )#end social box
                                  
                                ),#end fluidRow
                                
                                
                                
                       ),
                       tabPanel("Dag 2",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 2 - Fredag",
                                    subtitle = "12.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Frokost",
                                        date = "08:00 - 09:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "09:00 - 09:30",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Briefing før Dykk 1",
                                        date = "09:30 - 09:45",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Båtavgang Dykk 1",
                                        date = "09:45",
                                        "Sted: Oppmøte ved dykkebåten"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 1",
                                        date = "10:00 - 12:00",
                                        "Sted: Lokasjon angis ved briefingen"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Lunsj",
                                        date = "12:00 - 13:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "13:00 - 13:30",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Briefing før Dykk 2",
                                        date = "13:30 - 13:45",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Båtavgang Dykk 2",
                                        date = "13:45",
                                        "Sted: Oppmøte ved dykkebåten"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 2",
                                        date = "14:00 - 16:00",
                                        "Sted: Lokasjon angis ved briefingen"
                                      ),
                                      
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Innlevering av minnebrikker",
                                        date = "16:00 - 16:30",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Felles middag",
                                        date = "20:00 - 21:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Mingling i baren",
                                        date = "21:00 - ",
                                        "Sted: Oscarsborg Hotell"
                                      )
                                    ),#end tagsList
                                    footer = "For detaljert stedslokasjon se kart."
                                  )#end socialBox
                                )#end fluidRow
                         
                       ),
                       
                       tabPanel("Dag 3",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 3 - Lørdag",
                                    subtitle = "12.09.2020",
                                    src = "duk_logo.jpg",
                                    comments = tagList(
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Frokost",
                                        date = "08:00 - 09:00",
                                        "Sted: Oscarsborg Hotell "
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "09:00 - 09:30",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Briefing før Dykk 3",
                                        date = "09:30 - 09:45",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Båtavgang Dykk 3",
                                        date = "09:45",
                                        "Sted: Oppmøte ved dykkebåten"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 3",
                                        date = "10:00 - 12:00",
                                        "Sted: Lokasjon angis ved briefingen"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Lunsj",
                                        date = "12:00 - 13:00",
                                        "Sted: Oscarsborg Hotell"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Rigging av utstyr",
                                        date = "13:00 - 13:30",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Briefing før Dykk 4",
                                        date = "13:30 - 13:45",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Båtavgang Dykk 4",
                                        date = "13:45",
                                        "Sted: Oppmøte ved dykkebåten"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Dykk 4",
                                        date = "13:00 - 16:00",
                                        "Sted: Lokasjon angis ved briefingen"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Innlevering og utlevering av minnebrikker",
                                        date = "16:00 - 17:00",
                                        "Sted: Dykkepalasset"
                                      ),
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Innlevering av bilder",
                                        date = "16:00 - 19:00",
                                        "Sted: Dykkepalasset"
                                      ),
                                      
                                      boxComment(
                                        src = "scuba_flag.png",
                                        title = "Festmiddag",
                                        date = "19:00 - 21:00",
                                        "Sted: Hovedfortet Oscarsborg"
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
                       tabPanel("Dag 4",
                                fluidRow(
                                  socialBox(
                                    width=12,
                                    title = "Timeplan dag 4 - Søndag",
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
                                        date = "12:00",
                                        "Takk for nå og god tur hjem! :)"
                                      )
                                    ),
                                    footer = "For detaljert stedslokasjon se kart"
                                  )#end social box
                                )
                                
                       )
                       
                )
              ),  #end fluidRow,
                h2("Områdekart"),
                fluidRow(
                  box(title = "Trykk på markørene for info",
                      width=12,
                      status = "primary",
                      collapsible=F,
                      collapsed=F,
                      leafletOutput("mainmap"))
                )
              
              
      ),
      tabItem(tabName="divesites",
              box(title = "Oversikt aktuelle dykkeplasser for gjennomføring av NM",
                  width=12,
                  status = "primary",
                  collapsible=F,
                  collapsed=F,
                  h4("For detaljert informasjon om dykkeplassene trykk på markørene på kartet."),
                  leafletOutput("divemap1")
                  )),
     
      tabItem(tabName="equipment",
              h2("Utstyr"),
              fluidPage(
                
                box(title="Før Ankomst",
                    width=12,
                    status="primary",
                    collapsible=T,
                    collapsed = T,
                    column(width=10,
                    p("Før ankomst bes deltagerne å ha fylt sine flaskesett."), 
                    p("For de av deltagerne som har mulighet, anbefales det å medbringe ekstra flaskesett."),
                    br(),
                    p("Drøbak Undervannsklubb vil stille ekstra flaskesett til disposisjon, både enkle og doble."), 
                    p("Det er viktig at deltagere som har behov for dette melder ifra til arrangøren så fort som mulig."),
                    ),
                    column(width=2,
                      img(src = "divetank.jpg", height = 100, width = 80)
                    )
                ),
                box(title="Ved Ankomst DUK",
                    width=12,
                    status="primary",
                    collapsible=T,
                    collapsed = T,
                    column(width=10,
                    p("Ved ankomst er det nødvendig at deltagerne følger arrangørens retningslinjer for logistikk av utstyr og fylling av gass."), 
                    p("Ved ankomst må deltagerne lesse av sitt utstyr ved klubbhuset til Drøbak Undervannsklubb." ),
                    p("Utstyr som avleveres vil merkes med deltagernes navn, adresse og telefonnummer."),
                    p("Fra Steinbrygga ved klubbhuset vil arrangøren frakte utstyret over til Oscarsborg, hvor arrangementet avvikles."),
                    p("Arrangøren anbefaler at kamera og annet ømfintlig utstyr fraktes til Oscarsborg av deltagerne selv.")
                    ),
                    column(width=2,
                           img(src="divecam.jpg",height=100, width=120)
                           )
                ),
                box(title="Ved ankomst Oscarsborg Festning",
                    width=12,
                    status="primary",
                    collapsible=T,
                    collapsed = T,
                    column(width=10,
                    p("Deltagerne bes følge arrangørens øvrige henvisninger knyttet til overnatting og arrangementets timeplan."), 
                    p("Utstyr som arrangøren har fraktet over til Oscarsborg tilgjengeliggjøres for deltagerne på angitt område."), 
                    p("Det vil i den forbindelse bli kunngjort rutiner for oppbevaring av utstyr under arrangementet."),
                    p("Arrangøren anbefaler at deltagerne etter ankomst setter opp og sjekker utstyret sitt.")
                    ),
                    column(width=2,
                           img(src="divegear_set.jpg",height=110, width=110)
                           )
                ),
                box(title="Under Arrangementet",
                    width=12,
                    status="primary",
                    collapsible=T,
                    collapsed = T,
                    column(width=10,
                    p("Arrangøren stiller med kapasitet for fylling av flaskesett under hele arrangementet.") ,
                    p("Deltagerne bes avlevere sine flaskesett på angitt område umiddelbart etter hvert gjennomførte dykk."), 
                    p("Arrangøren vil markere flaskesettet med deltagerens nummer og deretter fylle samtlige avleverte flaskesett."),
                    p("Arrangøren vil også stille til rådighet et utvalg ferdig fylte flaskesett."),
                    p("Det vil være mulig å avlevere flaskesett også på andre tidspunkter, 
                            men arrangøren kan da ikke garantere for at disse vil være fylt i tide for neste dykk.")
                    ),
                    column(width=2,
                           img(src="tag.jpg",height=100,width=90)
                           )
                ),
                box(title="Ved Avreise",
                    width=12,
                    status="primary",
                    collapsible=T,
                    collapsed = T,
                    column(width=10,
                    p("Deltagerne følger arrangørens henvisninger knyttet til utsjekk fra hotellet og båt tilbake til Drøbak."),
                    p("Utstyr som arrangøren skal frakte tilbake til Drøbak Undervannsklubb sitt klubbhus må avleveres på område som angis av arrangøren under arrangementet."),
                    p("Arrangøren anbefaler også ved avreise at deltagerne selv frakter med seg kamera og annet ømfintlig utstyr."),
                    p("Utstyr som avleveres vil merkes med deltagernes navn, adresse og telefonnummer.")
                    ),
                    column(width=2,
                           img(src="suitcase.jpg", height=110,width=80)
                      
                    )
                )
                
                
                
                
              )
              
      ),
      tabItem(tabName = "safety",
              fluidPage(
                h2("HMS og Sikkerhet"),
                tabBox(width=12,
                       tabPanel("Ansvar",
                                fluidPage(
                                  box(width=12,
                                      title = "Ansvarlig arrangør",
                                      #status = "primary",
                                      boxProfile(
                                        src = "duk_logo.jpg",
                                        title = "Drøbak Undervannsklubb",
                                        subtitle = "(DUK)",
                                        boxProfileItemList(
                                          bordered = TRUE,
                                          boxProfileItem(
                                            title = "Ansvarlig:",
                                            description = "908 97 535"
                                          ),
                                          boxProfileItem(
                                            title = "Fortreder:",
                                            description = "952 41 924"
                                          ),
                                          boxProfileItem(
                                            title = "Forsikring:",
                                            description = "Via NDF"
                                          ),
                                          boxProfileItem(
                                            title = "Sted:",
                                            description = "Oscarsborg"
                                          )
                                        )
                                      )
                                  ),
                                  box(width=12,
                                      title = "Ansvarlig juridisk og økonomisk",
                                      #status = "primary",
                                      boxProfile(
                                        src = "ndf_logo3.jpg",
                                        title = "Norges Dykkeforbund",
                                        subtitle = "(NDF)",
                                        boxProfileItemList(
                                          bordered = TRUE,
                                          boxProfileItem(
                                            title = "Kontakt:",
                                            description = "981 98 772"
                                          )
                                        )
                                      )
                                  )
                                )
                       ),#end tabPanel
                       tabPanel("HMS-Mål",
                                fluidPage(
                                  box(width=12,
                                      
                                      h4("MÅL FOR HELSE-, MILJØ-"),
                                      h4("OG SIKKERHETSARBEIDET"),
                                      p("Under arrangementer hvor det deltar utøvere på tvers av klubbgrenser - 
                            med ulike sikkerhetsregler og forskjellig sikkerhetsforståelse - 
                            er det viktig å ha en fellesnorm, slik at alle føler at sikkerheten er ivaretatt. 
                            Normen vil utgjøre en plattform som alle kan forholde seg til og kjenne igjen."),
                                      
                                      p("Det er viktig at alle som er involvert i arrangementet 
                            (arrangementsleder, klubber, utøvere, funksjonærer, osv.) 
                            har ens oppfatning av hvilke krav og prosedyrer som er gjeldende. 
                            Dette vil kunne forebygge unødige diskusjoner."),
                                      
                                      p("På samme måte som en klubben bekjentgjør sine sikkerhetsregler overfor sine medlemmer, 
                            er det helt nødvendig at DUK (Drøbak undervannsklubb), å ha klare regler ifm arrangementet."),
                                      p("På denne bakgrunn har vi laget en oppstilling av de normer og krav som gjøres gjeldende i 
                            forbindelse med arrangementer hvor DUK har arrangøransvaret."),
                                      
                                      p("Et annet viktig element er det ansvar vi som arrangør har overfor offentlige lover og forskrifter:"),
                                      br(),
                                      h4("Forskrift om systematisk helse-, miljø- og sikkerhetsarbeid i virksomheter."),
                                      p("(Skriftlig, dokumenterbart intern-kontrollsystem)."),
                                      
                                      h4("Lov om kontroll med produkter og forbrukertjenester."),
                                      p("(Tilrettelegging for aktivitet, for eksempel dykketreff, -leir og -tokt)"),
                                      
                                      h4("Forskrift om tryggleiken ved sportsdykking."),
                                      p("(Grunnkurs, videregående kurs, emnekurs)")
                                      
                                  )
                                )
                       ),
                       tabPanel("HMS-Krav",
                                fluidPage(
                                  box(width=12,
                                      h2("Krav til deltakere:"),
                                      
                                      h4("Lisens:"),
                                      p("Utøver må ha gyldig lisens."),
                                      
                                      h4("Helse:"),
                                      p("Utøver skal være medisinsk skikket til å kunne delta på arrangementet."),
                                      br()
                                  ),
                                  box(width=12,
                                      h2("Krav til sikring:"),
                                      
                                      h4("Følgende funksjoner har ansvar for koordinering av uønskede hendelser:"),
                                      tags$ul(
                                        tags$li("Dykkeleder"),
                                        tags$li("Båtfører"),
                                        tags$li("Dommere"),
                                        tags$li("HMS-ansvarlig (person fra arrangør)")
                                      ),              
                                      
                                      h4("Utstyr i dykkerbåt:"),
                                      tags$ul(
                                        tags$li("Førstehjelpsutstyr"),
                                        tags$li("O2-apparat (arrangør skal kunne bruke dette ved nødssituasjoner)"),
                                        tags$li("Alarm og handlingsplan"),
                                        tags$li("Telefon/VHF")
                                      ),
                                      
                                      h4("Alarmplan og Handlingsplan"),
                                      p("Se fanen for Alarmplan"),
                                      
                                      h4("Generelle sikkerhetsregler"),
                                      p("Utøvere må forholde seg til gjeldende regelverk og sikkerhetsreglene."),
                                      
                                      p("Anvisninger som blir gitt av ledende personell skal følges."),
                                      
                                      h4("Journalføring"),
                                      p("Det skal føres journal for alle uønskede hendelser.")
                                  )
                                )#end fluidPage
                       ),
                       tabPanel("Sikkerhetsregler",
                                fluidPage(
                                  box(title="1)	 All dykking i regi av DUK skal foregå med utnevnt dykkeleder (DL).",
                                      width = 12,
                                      status = "primary"),
                                  box(title = "2)	 Dykker skal følge DLs retningslinjer og instrukser.",
                                      width=12,
                                      status = "primary"),
                                  box(title= "3)	Solo dykking skal ikke tillates hvor DUK står som arrangør",
                                      width=12,
                                      status = "primary"),
                                  box(title="4)	 Sørg for å være opplagt og i god nok form, både fysisk og mentalt til å dykke.",
                                      width=12,
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary"),
                                  box(title="8)	 Avtal rutiner for samhold.",
                                      width=12,
                                      status = "primary"
                                  ),
                                  box(title="9)	 Planlegg gassforbruk og nok reservegass. Koordineres med meddykker(e).",
                                      width=12,
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary",
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
                                      status = "primary"),
                                  box(title="15)	 Dykkere registrerer seg elektronisk før og etter dykk",
                                      width=12,
                                      status = "primary"),
                                  box(title="16)	 Før fylling av flasker skal flasker kontrolleres for gyldig kontrollmerke",
                                      width=12,
                                      status = "primary"),
                                  box(title="17)	 Ved dykking fra klubbhuset skal ferga ved Oscarsborg festning varsles. Se oppslag",
                                      width=12,
                                      status = "primary"),
                                  box(title="18)	 Følg parkeringsreglene. Se oppslag",
                                      width=12,
                                      status = "primary"),
                                  box(title="19)	 Dykkere skal være kjent med DUKs vedtekter",
                                      width=12,
                                      status = "primary")
                                )#end fluidPage
                       ),
                       tabPanel("Alarmplaner ved ulykker",
                                fluidPage(
                                  h4("Last ned alarmplanen og fyll ut datane før du dra ut, eller mens du sitter og venter I båten."), 
                                  h4("I en opphetet situasjon er det ikke sikkert du husker telefonnummeret ditt eller hvor du er."),
                                                  
                                                  fluidPage(
                                                    box(status="danger",
                                                        title="Alarmplan dykkeulykke",
                                                        downloadButton("download_alarmplan_dykkeulykke", "last ned")
                                                        ),
                                                    box(status="danger",
                                                        title="Alarmplan savnet dykker",
                                                        downloadButton("download_alarmplan_savnetdykker", "last ned")
                                                    ),
                                                    box(status="danger",
                                                        title="Alarmplan savnet- skadet- livløs dykker",
                                                        downloadButton("download_alarmplan_livlosdykker", "last ned")
                                                    ),
                                                    box(status="danger",
                                                        title="Nødplakat",
                                                        downloadButton("download_emergencyposter", "last ned")
                                                    )
                                                    
                                                    
                                                  )#end fluidPage
                      
                                )#end fluidPage
                       )
                )#end tabBox 
              )#end fluidPage    
      ),
      tabItem(tabName="contact",
              box(width=12,
                  boxProfile(
                    src = "duk_logo.jpg",
                    title = "Drøbak Undervannsklubb",
                    subtitle = "(DUK)",
                    boxProfileItemList(
                      bordered = TRUE,
                      boxProfileItem(
                        title = "Styreleder:",
                        description = "908 97 535"
                      ),
                      boxProfileItem(
                        title = "Media/kommunikasjon:",
                        description = "952 41 924"
                      ),
                      boxProfileItem(
                        title = "Sikkerhetsansvarlig:",
                        description = "404 35 973"
                      )
                      
                    )
                  )
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
                #materialSwitch(inputId = "switch_geoloc", label = "Slå på geolokasjon", status = "info")
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
  icon_jury <- awesomeIcons(icon='university',iconColor='black',library='fa', markerColor="red")
  
  icon_dive1 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'green')
  icon_dive2 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'purple')
  icon_dive3 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'blue')
  icon_dive4 <- awesomeIcons(icon = 'camera', iconColor='black', library='fa', markerColor = 'red')
  
  content_boat_to <- paste(sep = "<br/>",
                           "Båt Drøbak - Oscarsborg",
                           "<b><a href='https://www.forsvarsbygg.no/no/festningene/finn-din-festning/oscarsborg-festning/fergetider-billett-og-parkering/'>Rutetabell</a></b>"
  )
  
  content_boat_from <- paste(sep = "<br/>",
                             "Båt Oscarsborg - Drøbak",
                             "<b><a href='https://www.forsvarsbygg.no/no/festningene/finn-din-festning/oscarsborg-festning/fergetider-billett-og-parkering/'>Rutetabell</a></b>"
  )
  
  
  
############### leaflet geolocation map ##################  
 
  #this is the static map:
    output$geolocmap <- renderLeaflet({
    leaflet() %>%
      addTiles()   
      })  
  
  
    observe({
      if(!is.null(input$lat)){
        
        lat <- input$lat
        lng <- input$long
        acc <- input$accuracy
        time <- input$time
        
        proxy <- leafletProxy("geolocmap")
        
        proxy  %>% 
          clearGroup(group="pos") %>% 
          addMarkers(lng=lng, lat=lat, 
                     popup=paste("Du er her:","<br>",
                                                   lng,"Longitude","<br>",
                                                   lat,"Latitude", "<br>",
                                                   "My accuracy is:",  "<br>",
                                                   acc, "meters"),
                     group="pos") %>%
          addCircles(lng=lng, lat=lat, radius=acc, group="pos") 
        
      }
      
    })
  
    
############### leaflet main map ##################  
  output$mainmap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% #59.676430, 10.615220
      setView(lat=59.676430, lng=10.615220, zoom=13) %>% 
      addAwesomeMarkers(lat = 59.678457, lng = 10.624653, popup=leafpop::popupImage("clubhouse_s.jpg"),icon=icon_home) %>% 
      addAwesomeMarkers(lat = 59.673461, lng = 10.621689, popup="Parkering - Husvikveien",icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.664597, lng = 10.628475, popup=leafpop::popupImage("parking_banklokka_s.jpg"),icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.671528, lng = 10.627083, popup=leafpop::popupImage("parking_sagajordet_s.jpg"),icon=icon_car) %>% 
      addAwesomeMarkers(lat = 59.670147, lng = 10.622890, popup=leafpop::popupImage("boat_drobak_oscarsborg_s.jpg"),icon=icon_boat) %>%  
      #on the event site:
      
      addAwesomeMarkers(lat = 59.676348, lng = 10.607065, popup=leafpop::popupImage("boat_oscarsborg_drobak_s.jpg"),icon=icon_boat) %>% 
      addAwesomeMarkers(lat = 59.678427, lng = 10.604004, popup=leafpop::popupImage("divepalace_s.jpg"),icon=icon_palace) %>% 
      addAwesomeMarkers(lat = 59.675737, lng = 10.605976, popup=leafpop::popupImage("hotel_s.jpg"),icon=icon_hotel) %>% 
      addAwesomeMarkers(lat = 59.676137, lng = 10.605655, popup=leafpop::popupImage("guided_tour_s.jpg"),icon=icon_landmark) %>% 
      addAwesomeMarkers(lat = 59.678345, lng = 10.604299, popup="Oppmøte - dykkebåt",icon=icon_boat) %>% 
      addAwesomeMarkers(lat = 59.673514, lng = 10.607124, popup="Festmiddag",icon=icon_dinner) %>% 
      addAwesomeMarkers(lat = 59.677580, lng = 10.606661, popup=leafpop::popupImage("jury_s.jpg"),icon=icon_jury)


    
  })
  
    observe({
      if(!is.null(input$lat)){
        
        lat <- input$lat
        lng <- input$long
        acc <- input$accuracy
        time <- input$time
        
        proxy <- leafletProxy("mainmap")
        
        proxy  %>% 
          clearGroup(group="pos") %>% 
          addMarkers(lng=lng, lat=lat, 
                     # popup=paste("My location is:","<br>",
                     #             lng,"Longitude","<br>",
                     #             lat,"Latitude", "<br>",
                     #             "My accuracy is:",  "<br>",
                     #             acc, "meters"),
                     popup=paste("Du er her"),
                     
                     group="pos") %>%
          addCircles(lng=lng, lat=lat, radius=acc, group="pos") 
        
      }
      
    })
   

    
  output$divemap1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      setView(lat=59.691951, lng=10.595297, zoom=12) %>% 
      addAwesomeMarkers(lat = 59.690536, lng = 10.593138, popup=leafpop::popupImage("tronstad_s.jpg"),icon=icon_dive1) %>% 
      addAwesomeMarkers(lat = 59.702275, lng = 10.592654, popup=leafpop::popupImage("askholmene_s.jpg"),icon=icon_dive2) %>%  
      addAwesomeMarkers(lat = 59.678764, lng = 10.609147, popup=leafpop::popupImage("torpedobatteriet_s.jpg"),icon=icon_dive3) %>% 
      addAwesomeMarkers(lat = 59.673555, lng = 10.584954, popup=leafpop::popupImage("bergholmen_s.jpg"),icon=icon_dive4)
      
  })
  
################# dowload buttons #######################
  output$download_alarmplan_dykkeulykke <- downloadHandler(
    filename = "alarmplan_dykkeulykke.pdf",
    content = function(file) {
      file.copy("www/alarmplan_dykkeulykke.pdf", file)
    })
  
  output$download_alarmplan_savnetdykker <- downloadHandler(
    filename = "alarmplan_savnet_dykker.pdf",
    content = function(file) {
      file.copy("www/alarmplan_savnet_dykker.pdf", file)
    })

  output$download_alarmplan_savnetdykker <- downloadHandler(
    filename = "alarmplan_savnet_dykker.pdf",
    content = function(file) {
      file.copy("www/alarmplan_savnet_dykker.pdf", file)
    })

  output$download_alarmplan_livlosdykker <- downloadHandler(
    filename = "alarmplan_savnet_skadet_livlos_dykker.pdf",
    content = function(file) {
      file.copy("www/alarmplan_savnet_skadet_livlos_dykker.pdf", file)
    })
    

  output$download_emergencyposter <- downloadHandler(
    filename = "nodplakat.pdf",
    content = function(file) {
      file.copy("www/nodplakat.pdf", file)
    })
  
  
  
  }

shinyApp(ui, server)