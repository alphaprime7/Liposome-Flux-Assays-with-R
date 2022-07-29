library(shiny)
library(foreign)
library(purrr)
library(data.table)
library(readr)

if(interactive()){
  
  # Define UI for DBF data upload
  ui <- fluidPage(
    
    
    # App title---
    titlePanel("DBF to CSV/TSV File Converter"),
    
    # Sidebar layout ---
    sidebarLayout(
      
      # Sidebar panel for inputs (No css or style sheets) ---
      sidebarPanel(
        
        # Input:select file or file prompt. Add .dbf extension ---
        
        fileInput("dbftype", "Upload a file (Choose DBF file)",
                  multiple = TRUE,
                  width = "100%",
                  accept = c(".dbf")),
        
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
        
        radioButtons("filetype", "File type:",
                     choices = c("csv", "tsv")),
        
        downloadButton("downloadCSV", "Download as CSV or TSV"),
        
        
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
    
    
    output$downloadCSV <- downloadHandler(
      filename = function() {
        paste(input$dbftype, input$filetype, sep = ".")
      },
      
      
      content = function(file) {
        sep <- switch(input$filetype, "csv" = ",", "tsv" = "\t")
        write.csv(df(), file, sep = sep,
                  row.names = FALSE)
      }
    )
    
  }
  
  # Run App
  
  shinyApp (ui, server)
  
}