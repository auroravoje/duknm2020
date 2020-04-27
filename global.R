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

#create customized icons

icon_usr <- awesomeIcons(
  icon = 'male',
  iconColor = 'black',
  library = 'fa',
  markerColor = "red"
) 