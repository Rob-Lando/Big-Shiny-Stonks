function(input,output){
    
    
    series_1 <- reactive({
        
        s = data.frame(tq_get(input$symbol_1,
                              get = "stock.prices",
                              from = input$start_1))
        
        return(s)
        
    }) # end of reactive function block #######################################
    
    series_2 <- reactive({
        
        s = data.frame(tq_get(input$symbol_2, 
                              get = "stock.prices",
                              from = input$start_2))
        
        return(s)
        
    }) # end of reactive function block #######################################
    
    selected_assets <- reactive({
        
        T_ = c(input$t1,input$t2,input$t3,input$t4,input$t5,
              input$t6,input$t7,input$t8,input$t9,input$t10)
        W_ = c(input$w1,input$w2,input$w3,input$w4,input$w5,
               input$w6,input$w7,input$w8,input$w9,input$w10)
        
        ticks_weights = data.frame(bind_cols(T_,W_))
        names(ticks_weights) <- c("ticker","weight")
        
        return(ticks_weights)
        
    }) # end of reactive function block #######################################
    
    IAMR <- reactive ({ #individual asset monthly returns
        
        
        sa = selected_assets()
        
        sa$ticker %>%
            tq_get(get  = "stock.prices",
                   from = input$Start_Date,
                   to   = input$End_Date) %>%
            group_by(symbol) %>%
            tq_transmute(select     = close, 
                         mutate_fun = periodReturn, 
                         period     = "monthly", 
                         col_rename = "Ra") -> stock_returns_monthly
        
        return(stock_returns_monthly)
        
    }) # end of reactive function block #######################################
    

    BMR <- reactive ({ #baseline monthly returns
        
        "^GSPC" %>% # Using S&P500 as baseline rate of return.
            tq_get(get  = "stock.prices",
                   from = input$Start_Date,
                   to   = input$End_Date) %>%
            group_by(symbol) %>%
            tq_transmute(select     = close, 
                         mutate_fun = periodReturn, 
                         period     = "monthly", 
                         col_rename = "Rb") -> baseline_returns_monthly
        
        return(baseline_returns_monthly)
        
    }) # end of reactive function block #######################################
    
    PRM <- reactive({ #portfolio monthly returns
        
        sa = selected_assets()
        wts <- sa$weight
        srm = IAMR()

        srm %>%
            tq_portfolio(assets_col  = symbol, 
                         returns_col = Ra, 
                         weights     = wts, 
                         col_rename  = "Ra") -> portfolio_returns_monthly
        
        return(portfolio_returns_monthly)
        
    }) # end of reactive function block #######################################
    
    CMPR <- reactive({ # cumulative monthly portfolio returns time series
        
        prm = PRM()
        
        TS = xts(prm$Ra,order.by=as.Date(prm$date))
        
        return(TS)
        
    }) # end of reactive function block #######################################
    
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
        
        }) # end of output 1

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
    
    output$table <- renderDataTable(aggregate_exchanges) #end of table output
    
    output$cumulative_portfolio_returns <- renderDygraph({
        
        TS = CMPR()
        
        dygraph(cumsum(TS), main = "Portfolio Monthly Return") %>%
            dyOptions(fillGraph = TRUE, fillAlpha = 0.25,strokeWidth = 3)%>%
            dyRangeSelector()
        
    }) # end of cumulative portfolio returns output
    
} # end of function input output block