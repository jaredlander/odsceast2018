library(shiny)

shinyServer(function(input, output, 
                     session){
    output$DisplayState <- 
        renderText(input$StateSelector)
})
