dashboardPage(
    
    dashboardHeader(title='Portfolio Evaluation'),
    
    dashboardSidebar(
        
        sidebarUserPanel("Tabs"),
        
        sidebarMenu(
            
            menuItem("Charts", tabName = "charts", icon = icon("line-chart")),
            menuItem("Performance Overview", tabName = "Eval", icon = icon("map"))
            
        ), #end of sidebarMenu block
        
        selectizeInput(inputId='symbol_1',label='Symbol 1',choices=tickers),
        selectizeInput(inputId='symbol_2',label='Symbol 2',choices=tickers),
        selectizeInput(inputId='symbol_3',label='Symbol 3',choices=tickers),
        selectizeInput(inputId='symbol_4',label='Symbol 4',choices=tickers),
        selectizeInput(inputId='symbol_5',label='Symbol 5',choices=tickers)
        
    ), # end of dashboardSidebar block
    
    dashboardBody(
        
        tabItems(
            
            tabItem(tabName = 'charts',
                    fluidRow(plotlyOutput("Price_1")),
                    fluidRow(plotlyOutput("Price_2")),
                    fluidRow(plotlyOutput("Price_3")),
                    fluidRow(plotlyOutput("Price_4")),
                    fluidRow(plotlyOutput("Price_5"))),
            
        #    tabItem(tabName = 'Eval',
        #            fluidRow(plotOutput))
                    
        ) # end of tabItems block
        
    ) #end of dashboardBody block
    
) # end of dashboardPage block