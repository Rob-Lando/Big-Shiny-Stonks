dashboardPage(
    
    dashboardHeader(title='Portfolio Evaluation'),
    
    dashboardSidebar(
        
        sidebarUserPanel("Tabs"),
        
        sidebarMenu(
            
            menuItem("Charts", tabName = "charts", icon = icon("line-chart")),
            menuItem("Portfolio Performance", tabName = "Eval", icon = icon("map")),
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
        
        # selectizeInput(inputId='symbol_3',label='Symbol 3',choices=tickers),
        # selectizeInput(inputId='symbol_4',label='Symbol 4',choices=tickers),
        # selectizeInput(inputId='symbol_5',label='Symbol 5',choices=tickers)
        
    ), # end of dashboardSidebar block
    
    dashboardBody(
        
        tabItems(
            
            tabItem(tabName = 'charts',
                    fluidRow(plotlyOutput("Price_1")),
                    fluidRow(plotlyOutput("Price_2"))),
            tabItem(tabName = 'Tickers', dataTableOutput('table'))
                    #fluidRow(plotlyOutput("Price_3")),
                    #fluidRow(plotlyOutput("Price_4")),
                    #fluidRow(plotlyOutput("Price_5")))
            
        #    tabItem(tabName = 'Eval',
        #            fluidRow(plotOutput))
                    
        ) # end of tabItems block
        
    ) #end of dashboardBody block
    
) # end of dashboardPage block