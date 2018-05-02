library(shiny)
library(ggplot2)
library(ggthemes)

shinyServer(function(input, output, 
                     session){
    output$DisplayState <- renderText(input$StateSelector)
    
    output$CarHist <- renderPlot({
        ggplot(mtcars, aes_string(x=input$CarColumn)) + 
            geom_histogram() + 
            theme_excel()
    })
})
