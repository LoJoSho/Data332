library(shiny)
library(ggplot2)
library(DT)

dataset <- mtcars

col_names <- colnames(dataset)

ui <- fluidPage(
  titlePanel(title = "Explore MRCARS Dataset"),
  h4('Motor Trend Car Road Tests'),
  
  fluidRow(
    column(2,
           selectInput('X', 'Choose X', col_names, col_names[1]),
           selectInput('Y', 'Choose Y', col_names, col_names[3]),
           selectInput('Splitby', 'Split By', col_names, col_names[3])
           ),
    column(4, plotOutput('plot_01')),
    column(6, DT::dataTableOutput("table_01", width = '100%'))
    )
  )


server <- function(input, output, session) {
  output$plot_01 <- renderPlot({
    ggplot(dataset, aes_string(x=input$X, y=input$Y, colour=input$Splitby)) +
      geom_point()
  })
  
  output$table_01 <- DT::renderDataTable(dataset[, c(input$X, input$Y, input$Splitby)], 
  options = list(pageLength = 16))
}



shinyApp(ui, server)