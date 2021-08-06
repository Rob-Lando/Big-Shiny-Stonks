function(input,output){
    
    series_1 <- reactive({
        
        s = data.frame(tq_get(input$symbol_1, get = "stock.prices"))
        
    }) # end of reactive function block
    
    
    series_2 <- reactive({
        
        s = data.frame(tq_get(input$symbol_2, get = "stock.prices"))
        
    }) # end of reactive function block
    
    
    series_3 <- reactive({
        
        s = data.frame(tq_get(input$symbol_3, get = "stock.prices"))
        
    }) # end of reactive function block
    
    series_4 <- reactive({
        
        s = data.frame(tq_get(input$symbol_4, get = "stock.prices"))
        
    }) # end of reactive function block
    
    series_5 <- reactive({
        
        s = data.frame(tq_get(input$symbol_5, get = "stock.prices"))
        
    }) # end of reactive function block
    
    output$Price_1 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_1) %>% 
            select(company) -> title
       
        s1 = series_1()
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
        
        s2 = series_2()
        plot_ly(x = s2$date, type="candlestick",
                open = s2$open, close = s2$close,
                high = s2$high, low = s2$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_2,':',pull(title)))-> fig_2
        
        fig_2
        
        }) # end of output 2
    
    output$Price_3 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_3) %>% 
            select(company) -> title
        
        s3 = series_3()
        plot_ly(x = s3$date, type="candlestick",
                open = s3$open, close = s3$close,
                high = s3$high, low = s3$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_3,':',pull(title)))-> fig_3
        
        fig_3
        
    }) # end of output 3
    
    output$Price_4 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_4) %>% 
            select(company) -> title
        
        s4 = series_4()
        plot_ly(x = s4$date, type="candlestick",
                open = s4$open, close = s4$close,
                high = s4$high, low = s4$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_4,':',pull(title)))-> fig_4
        
        fig_4
        
    }) # end of output 4
    
    output$Price_5 <- renderPlotly({
        
        nyse_stocks %>% 
            filter(symbol == input$symbol_5) %>% 
            select(company) -> title
        
        s5 = series_5()
        plot_ly(x = s5$date, type="candlestick",
                open = s5$open, close = s5$close,
                high = s5$high, low = s5$low,
                increasing = i, decreasing = d) %>%
            layout(title = paste("(1D)   ",input$symbol_5,':',pull(title)))-> fig_5
        
        fig_5
        
    }) # end of output 5
    
    
    
} # end of function block