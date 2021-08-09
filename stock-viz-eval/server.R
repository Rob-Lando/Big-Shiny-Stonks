function(input,output){
    
    series_1 <- reactive({
        
        s = data.frame(tq_get(input$symbol_1,
                              get = "stock.prices",
                              from = input$start_1))
        
    }) # end of reactive function block
    
    
    series_2 <- reactive({
        
        s = data.frame(tq_get(input$symbol_2, 
                              get = "stock.prices",
                              from = input$start_2))
        
    }) # end of reactive function block
    
    
    
    selected_assets <- reactive({
        
        T_ = c(input$t1,input$t2,input$t3,input$t4,input$t5,
              input$t6,input$t7,input$t8,input$t9,input$t10)
        W_ = c(input$w1,input$w2,input$w3,input$w4,input$w5,
               input$w6,input$w7,input$w8,input$w9,input$w10)
        
    }) # end of reactive function block
    
    individual_monthly_returns <- reactive ({
        
        T_ %>%
            tq_get(get  = "stock.prices",
                   from = input$Start_Date,
                   to   = input$End_Date) %>%
            group_by(symbol) %>%
            tq_transmute(select     = close, 
                         mutate_fun = periodReturn, 
                         period     = "monthly", 
                         col_rename = "Ra") -> stock_returns_monthly
        
        return(stock_returns_monthly)
    })
    
    
    
    
    output$Price_1 <- renderPlotly({
        
        aggregate_exchanges %>% 
            filter(symbol == input$symbol_1) %>% 
            select(company) -> title
       
        s1 = series_1()
        plot_ly(s1,x = ~date, type="candlestick",
                open = ~open, close = ~close,
                high = ~high, low = ~low) %>%
            layout(title = paste("(1D)   ",input$symbol_1,' ',pull(title)))-> fig_1
        
        fig_1 
        
        })# end of output 1

    output$Price_2 <- renderPlotly({
        
        aggregate_exchanges %>% 
            filter(symbol == input$symbol_2) %>% 
            select(company) -> title
        
        s2 = series_2()
        plot_ly(s2,x = ~date, type="candlestick",
                open = ~open, close = ~close,
                high = ~high, low = ~low) %>%
            layout(title = paste("(1D)   ",input$symbol_2,' ',pull(title)))-> fig_2
        
        fig_2
        
        }) # end of output 2
    
    output$table <- renderDataTable(aggregate_exchanges)
    
} # end of function block