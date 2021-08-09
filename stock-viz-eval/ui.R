dashboardPage(
    
    dashboardHeader(title='Portfolio Evaluation'),
    
    dashboardSidebar(
        
        sidebarUserPanel("Tabs:"),
        
        sidebarMenu(
            
            menuItem("Daily Candlestick Charts", tabName = "Charts", icon = icon("line-chart")),
            menuItem("Define Portfolio", tabName = "portfolio", icon = icon("map")),
            menuItem("Performance Summary", tabName = "raps", icon = icon("map")),
            menuItem("Monthly Return Visuals", tabName = "mrv", icon = icon("line-chart")),
            menuItem("Table of Ticker Symbols", tabName = "Tickers", icon = icon("database"))
            
        ), #end of sidebarMenu block
        
        textInput(inputId='symbol_1',label='Symbol 1',
                       value = "^GSPC"),
        
        textInput(inputId='start_1',label='Start Date 1: YYYY-MM-DD',
                  value = "2020-01-01"),
        
        textInput(inputId='symbol_2',label='Symbol 2',
                       value = "^DJI"),
        
        textInput(inputId='start_2',label='Start Date 2: YYYY-MM-DD',
                  value = "2020-01-01")
        
    ), # end of dashboardSidebar block
    
    dashboardBody(
        
        #fluidRow(textInput(inputId = "Ticker 1", value = 'asndvkjasndlkv'),
        
        tabItems(
            
            tabItem(tabName = 'Charts',
                    fluidRow(plotlyOutput("Price_1")),
                    fluidRow(plotlyOutput("Price_2"))),
            
            tabItem(tabName = 'Tickers', dataTableOutput('table')),
            
            tabItem(tabName = 'portfolio',
                    fluidRow(column(2,textInput(inputId = 't1', label = 'Ticker 1', value = "MSFT")),
                             column(2,textInput(inputId = 't2', label = 'Ticker 2', value = "AAPL")),
                             column(2,textInput(inputId = 't3', label = 'Ticker 3', value = "MGM")),
                             column(2,textInput(inputId = 't4', label = 'Ticker 4', value = "BA")),
                             column(2,textInput(inputId = 't5', label = 'Ticker 5', value = "GM"))),
                    fluidRow(column(2,textInput(inputId = 'w1', label = 'Decimal Weight 1', value = 0.1)),
                             column(2,textInput(inputId = 'w2', label = 'Decimal Weight 2', value = 0.1)),
                             column(2,textInput(inputId = 'w3', label = 'Decimal Weight 3', value = 0.1)),
                             column(2,textInput(inputId = 'w4', label = 'Decimal Weight 4', value = 0.1)),
                             column(2,textInput(inputId = 'w5', label = 'Decimal Weight 5', value = 0.1))),
                    fluidRow(column(2,textInput(inputId = 't6', label = 'Ticker 6', value = "GE")),
                             column(2,textInput(inputId = 't7', label = 'Ticker 7', value = "CLF")),
                             column(2,textInput(inputId = 't8', label = 'Ticker 8', value = "LHX")),
                             column(2,textInput(inputId = 't9', label = 'Ticker 9', value = "CSCO")),
                             column(2,textInput(inputId = 't10', label = 'Ticker 10', value = "PENN"))),
                    fluidRow(column(2,textInput(inputId = 'w6', label = 'Decimal Weight 6', value = 0.1)),
                             column(2,textInput(inputId = 'w7', label = 'Decimal Weight 7', value = 0.1)),
                             column(2,textInput(inputId = 'w8', label = 'Decimal Weight 8', value = 0.1)),
                             column(2,textInput(inputId = 'w9', label = 'Decimal Weight 9', value = 0.1)),
                             column(2,textInput(inputId = 'w10', label = 'Decimal Weight 10', value = 0.1))),
                    fluidRow(column(2,textInput(inputId = 'Start_Date', label = 'Start_Date YYYY-MM-DD', value = "2000-01-01")),
                             column(2,textInput(inputId = 'End_Date', label = 'End_Date YYYY-MM-DD', value = "2021-08-08")))),
            
            tabItem(tabName = 'mrv',
                    fluidRow(dygraphOutput("cumulative_portfolio_returns")),
                    fluidRow(dygraphOutput("monthly_portfolio_returns")),
                    fluidRow(plotOutput("asset_boxplots")))
            
            
        ) # end of tabItems block
        
    ) #end of dashboardBody block
    
) # end of dashboardPage block