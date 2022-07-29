library(shiny)

ui <- fluidPage(
  
  # App title---
  titlePanel("DBF to CSV/TSV File Converter"),
  
  fileInput("upload", NULL, accept = c(".dbf")),
  numericInput("n", "Rows", value = 5, min = 1, step = 1),
  tableOutput("head"),
  
  downloadButton("download", "Download .csv")
)

server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    
    ext <- tools::file_ext(input$upload$name)
    
    switch(ext,
           dbf = foreign::read.dbf(input$upload$datapath),
           validate("Invalid file; Please upload a .dbf file")
    )
    
  })

    output$head <- renderTable({
      head(data(), input$n)
      
    })
    
    output$download <- downloadHandler(
      filename = function() {
        paste0(input$upload, ".csv")
      },
      content = function(file) {
        write.csv(data(), file)
      }
    )

    } 

shinyApp(ui, server)