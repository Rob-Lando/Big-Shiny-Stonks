function(input,output){
    
    series <- reactive({
        
        s_1 = data.frame(tq_get(input$symbol_1, get = "stock.prices"))
        s_2 = data.frame(tq_get(input$symbol_2, get = "stock.prices"))
        
        return(list(s_1,s_2))
        
    }) # end of reactive function block
    
    
    output$Price_1 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_1) %>% 
            select(company) -> title
       
        s1 = series()[[1]]
        plot_ly(x = s1$date, type="candlestick",
                open = s1$open, close = s1$close,
                high = s1$high, low = s1$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_1,':',pull(title)))-> fig_1
        fig_1 
        
        })# end of output 1

        
    output$Price_2 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_2) %>% 
            select(company) -> title
        
        s2 = series()[[2]]
        plot_ly(x = s2$date, type="candlestick",
                open = s2$open, close = s2$close,
                high = s2$high, low = s2$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_2,':',pull(title)))-> fig_2
        
        fig_2
        
        }) # end of output 2
    
} # end of function block