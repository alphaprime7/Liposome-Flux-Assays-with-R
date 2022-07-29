###shiny apps are directories with R scripts called app.R
#has 2 components interface object and server function almost similar to pythons streamlit

# Setting working directories using the command line. Remember that
#if you dont like dont like the command line then use the UI by 
# going to Session and setting your directory\

## Use the getwd() function to see the present working directory
getwd()

## set the working directory by using ~ sign as a shortcut for the current WD
#a nice trick to have for sharp and efficient people like US
#do not minimize these little boilerplate ideas that help build you into an R expert
#the proper and mentally conducive way
setwd('~/newWD')

##create a directory or folder in R using dir.create
dir.create('~/shinyapps-tutorials')

#ideally this is the best approach
#realize that cat is a unix and windows thing to print stuff out
folder <- 'test'
if(file.exists(folder)){
  cat('the folder already exits')
} else{
  dir.create(folder)
}

## creating a file in R using file.create. This is efficient and keeps you within R while working on large projects
#some efficient skills to have
pussy <- 'app.R'
if(file.exists(pussy)){
  cat('this file already exist')
}else{
  file.create(pussy)
}

## open a file in R for editing using file.choose (select file in CWD) or file.edit (directly open)
#file <- "example.csv"
#sub_dir <- "subdirectory"
#dir.create(sub_dir)
#writeLines("myfile",file.path(sub_dir, file))
# Works
#shell.exec(file.path(sub_dir, file, fsep = "\\"))
#shell.exec(file.path(sub_dir, file))
file.choose('app.R')
file.edit('app.R')

save.image("~/fluxassays/fluxassay app.RData")

#Working on a shiny app
#1. Add inputs and outputs to the sidebar. We need a way to select variables in our app so 
#we need avatars or boxes to represent our data()

#fileInput(inputId = "filedata",
#label = "Upload data. Choose DBF file",
#accept = c(".dbf")),


library(shiny)
library(sf)
library(purrr)

ui <- fluidPage(
  br(),
  fluidRow(column(6, offset = 3,
                  fileInput("shp", label = "Input Shapfile (.shp,.dbf,.sbn,.sbx,.shx,.prj)",
                            width = "100%",
                            accept = c(".shp",".dbf",".sbn",".sbx",".shx",".prj"), multiple=TRUE))),
  
  br(),
  fluidRow(column(8, offset = 2,
                  p("input$shp$datapath" , style = "font-weight: bold"),                              
                  verbatimTextOutput("shp_location", placeholder = T))),
  
  br(),
  fluidRow(column(8, offset = 2,
                  p("input$shp$name" , style = "font-weight: bold"),                              
                  verbatimTextOutput("shp_name", placeholder = T)))   
)

server <- function(input, output, session) {
  
  # Read-in shapefile function
  Read_Shapefile <- function(shp_path) {
    infiles <- shp_path$datapath # get the location of files
    dir <- unique(dirname(infiles)) # get the directory
    outfiles <- file.path(dir, shp_path$name) # create new path name
    name <- strsplit(shp_path$name[1], "\\.")[[1]][1] # strip name 
    purrr::walk2(infiles, outfiles, ~file.rename(.x, .y)) # rename files
    x <- read_sf(file.path(dir, paste0(name, ".shp"))) # read-in shapefile
    return(x)
  }
  
  # Read-shapefile once user submits files
  observeEvent(input$shp, {
    user_shp <- Read_Shapefile(input$shp)
    plot(user_shp) # plot to R console
    
    
    # Print original file path location and file name to UI
    output$shp_location <- renderPrint({
      full_path <- strsplit(input$shp$datapath," ")
      purrr::walk(full_path, ~cat(.x, "\n")) 
    })
    
    output$shp_name <- renderPrint({
      name_split <- strsplit(input$shp$name," ")
      purrr::walk(name_split, ~cat(.x, "\n")) 
    })
  })  
}

shinyApp(ui, server)


#

library(shiny)
library(sf)
library(purrr)

ui <- fluidPage(
  br(),
  fluidRow(column(6, offset = 3,
                  fileInput("shp", label = "Input Shapfile (.shp,.dbf,.sbn,.sbx,.shx,.prj)",
                            width = "100%",
                            accept = c(".shp",".dbf",".sbn",".sbx",".shx",".prj"), multiple=TRUE))),
  
  br(),
  fluidRow(column(8, offset = 2,
                  p("input$shp$datapath" , style = "font-weight: bold"),                              
                  verbatimTextOutput("shp_location", placeholder = T))),
  
  br(),
  fluidRow(column(8, offset = 2,
                  p("input$shp$name" , style = "font-weight: bold"),                              
                  verbatimTextOutput("shp_name", placeholder = T)))   
)

server <- function(input, output, session) {
  
  # Read-in shapefile function
  Read_Shapefile <- function(shp_path) {
    infiles <- shp_path$datapath # get the location of files
    dir <- unique(dirname(infiles)) # get the directory
    outfiles <- file.path(dir, shp_path$name) # create new path name
    name <- strsplit(shp_path$name[1], "\\.")[[1]][1] # strip name 
    purrr::walk2(infiles, outfiles, ~file.rename(.x, .y)) # rename files
    x <- read_sf(file.path(dir, paste0(name, ".shp"))) # read-in shapefile
    return(x)
  }
  
  # Read-shapefile once user submits files
  observeEvent(input$shp, {
    user_shp <- Read_Shapefile(input$shp)
    plot(user_shp) # plot to R console
    
    
    # Print original file path location and file name to UI
    output$shp_location <- renderPrint({
      full_path <- strsplit(input$shp$datapath," ")
      purrr::walk(full_path, ~cat(.x, "\n")) 
    })
    
    output$shp_name <- renderPrint({
      name_split <- strsplit(input$shp$name," ")
      purrr::walk(name_split, ~cat(.x, "\n")) 
    })
  })  
}

shinyApp(ui, server)


# My code saved to test the new code
library(shiny)
library(foreign)
library(purrr)

# Define UI for DBF data upload
ui <- fluidPage(
  
  
  # App title---
  titlePanel("DBF to CSV File Converter"),
  
  # Sidebar layout ---
  sidebarLayout(
    
    # Sidebar panel for inputs (No css or style sheets) ---
    sidebarPanel(
      
      # Input:select file or file prompt. Add .dbf extension (lfadbf=lipofluxassay dbf)---
      
      fileInput("dbftype", "Upload a file (Choose DBF file)",
                multiple = TRUE,
                width = "100%",
                accept = c(".dbf", ".shp", "prj")),
      
      # Horizontal line after the Choose file line ---
      #tag$hr(),
      
      # Input: Checkbox if file has a header ----
      checkboxInput("header", "Header", TRUE),
      
      # Input select separator ---
      radioButtons("sep", "Separator",
                   choices = c(Comma=",",
                               semicolon=";",
                               Tab = "\t"),
                   selected = ","),
      
      # Input select quotes --- 
      radioButtons("quote", "Quote",
                   choices = c(None="",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected ='"'),
      
      # Horizontal line ----
      #tags$hr(),
      
      # Display row limit --- 
      radioButtons("disp", "Display",
                   choices = c(Head="head",
                               All ="all"),
                   selected ="head")
      
    ),
    
    # Main panel for output display
    mainPanel(
      
      # Output: Data file ---
      tableOutput("contents")
    )
    
  )
)

#Define server logic for lfa application
server <- function(input, output){
  
  # output function based on file1 input. file1 from line18
  output$contents <- renderTable({
    
    req(input$dbftype)
    
    df <- read.dbf(input$dbftype$datapath)
    
    if(input$disp == "head"){
      return(head(df))
    }
    else {
      return(df)
    }
    
  })
  
}

# Run App

shinyApp (ui, server)

sub_react = reactiveValues(data = sub)

#df_react <- reactiveValues(data=df)

#df<- transpose(df)

knowing when to use reactive for automation and file export
readr::write.csv(df_react$datapath, filename)


