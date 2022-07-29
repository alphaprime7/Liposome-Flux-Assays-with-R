library(shiny)
library(foreign)
library(purrr)
library(data.table)
library(readr)

if(interactive()){
  
  # Define UI for DBF data upload
  ui <- fluidPage(
    
    
    # App title---
    titlePanel("DBF to CSV File Converter"),
    
    # Sidebar layout ---
    sidebarLayout(
      
      # Sidebar panel for inputs (No css or style sheets) ---
      sidebarPanel(
        
        # Input:select file or file prompt. Add .dbf extension ---
        
        fileInput("dbftype", "Upload a file (Choose DBF file)",
                  multiple = TRUE,
                  width = "100%",
                  accept = c(".dbf", ".shp", "prj")),
        
        # Horizontal line after the Choose file line ---
        #tag$hr(),
        
        
        # Display row limit --- 
        radioButtons("disp", "Display",
                     choices = c(Head="head",
                                 All ="all"),
                     selected ="head")
        
      ),
      
      # Main panel for output display
      mainPanel(
        
        tableOutput("contents"),
        
        downloadButton("download1", "Download .csv file") 
        #tabsetPanel(type = "tab",
        #tabPanel("DBF Raw Data", tableOutput("contents"), downloadButton("download1", "Download .csv file")),
        #tabPanel("Data Summary", tableOutput("dbfsummary"), downloadButton("download2", "Download data summary")),
        #tabPanel("DBF Raw Data", tableOutput("ssplot"), downloadButton("download2", "Download Diagnostic plots"))
        
        
        #),
        
        # Output: Data file ---
        #tableOutput("contents")
        #tableOutput("dbfsummary"),
        #tableOutput("ssplot")
        
        
      )
      
    )
  )
  
  #Define server logic for lfa application
  server <- function(input, output){
    
    # output function based on file1 input. file1 from line18
    output$contents <- renderTable({
      
      req(input$dbftype)
      
      df <- read.dbf(input$dbftype$datapath)
      
      #df<- transpose(df)
      
      if(input$disp == "head"){
        return(head(df))
      }
      else {
        return(df)
      }
      
    })
    
    
    output$downloadData <- downloadHandler(
      filename = function() {
        paste0(output$lfacsv, ".csv")
      },
      content = function(file) {
        write_csv(df, filename)
      }
    )
    
  }
  
  # Run App
  
  shinyApp (ui, server)
  
}


###

library(shiny)
library(foreign)
library(purrr)
library(data.table)
library(readr)

if(interactive()){
  
  # Define UI for DBF data upload
  ui <- fluidPage(
    
    
    # App title---
    titlePanel("DBF to CSV File Converter"),
    
    # Sidebar layout ---
    sidebarLayout(
      
      # Sidebar panel for inputs (No css or style sheets) ---
      sidebarPanel(
        
        # Input:select file or file prompt. Add .dbf extension ---
        
        fileInput("dbftype", "Upload a file (Choose DBF file)",
                  multiple = TRUE,
                  width = "100%",
                  accept = c(".dbf", ".shp", "prj")),
        
        # Horizontal line after the Choose file line ---
        #tag$hr(),
        
        
        # Display row limit --- 
        radioButtons("disp", "Display",
                     choices = c(Head="head",
                                 All ="all"),
                     selected ="head")
        
      ),
      
      # Main panel for output display
      mainPanel(
        
        tableOutput("contents"),
        
        downloadButton("download1", "Download .csv file") 
        
        
      )
      
    )
  )
  
  #Define server logic for lfa application
  server <- function(input, output, session){
    
    # output function based on file1 input. file1 from line18
    output$contents <- renderTable({
      
      data <- reactive({
        req(input$dbftype)
        
        ext <- tools::file_ext(input$dbftype$name)
        switch(ext,
               csv = vroom::vroom(input$dbftype$datapath, delim = ","),
               tsv = vroom::vroom(input$dbftype$datapath, delim = "\t"),
               validate("Invalid file; Please upload a .csv or .tsv file")
        )
      })
      
      df <- read.dbf(input$dbftype$datapath)
      
      
      
      if(input$disp == "head"){
        return(head(df))
      }
      else {
        return(df)
      }
      
    })
    
    
    output$downloadData <- downloadHandler(
      filename = function() {
        paste0(input$dbftype, ".csv")
      },
      content = function(file) {
        vroom::vroom_write(dbftype(), file)
        
      }
    )
    
  }
  
  # Run App
  
  shinyApp (ui, server)
  
}
