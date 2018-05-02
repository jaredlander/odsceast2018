library(shiny)
library(ggplot2)
library(ggthemes)
library(magrittr)
library(leaflet)

pizza <- jsonlite::fromJSON('FavoriteSpots.json') %>% tidyr::unnest()

shinyServer(function(input, output, 
                     session){
    output$DisplayState <- renderText(input$StateSelector)
    
    output$CarHist <- renderPlot({
        ggplot(mtcars, aes_string(x=input$CarColumn)) + 
            geom_histogram() + 
            theme_excel()
    })
    
    output$PizzaTable <- DT::renderDataTable({
        DT::datatable(
            pizza, rownames=FALSE
        )
    })
    
    output$PizzaMap <- renderLeaflet({
        leaflet() %>% 
            addTiles() %>% 
            addMarkers(
                lng= ~ longitude, lat= ~ latitude,
                popup= ~ Name,
                data=pizza %>% 
                    dplyr::slice(
                        as.integer(
                            # input$PizzaTable_rows_selected
                            # input$PizzaTable_rows_all
                            c(input$PizzaTable_rows_all,
                                      input$PizzaTable_rows_selected)
                        )
                    )
            )
    })
})
