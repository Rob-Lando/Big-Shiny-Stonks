dashboardPage(
    
    dashboardHeader(title='Portfolio Evaluation'),
    
    dashboardSidebar(
        
        sidebarUserPanel("Tabs"),
        
        sidebarMenu(
            
            menuItem("Charts", tabName = "charts", icon = icon("line-chart")),
            menuItem("Performance Overview", tabName = "Eval", icon = icon("map"))
            
        ), #end of sidebarMenu block
        
        selectizeInput(inputId='symbol_1',label='Symbol 1',choices=unique(tickers)),
        selectizeInput(inputId='symbol_2',label='Symbol 2',choices=unique(tickers))
        
    ), # end of dashboardSidebar block
    
    dashboardBody(
        
        tabItems(
            
            tabItem(tabName = 'charts',fluidRow(plotlyOutput("Price_1")),fluidRow(plotlyOutput("Price_2")))
                    
        ) # end of tabItems block
        
    ) #end of dashboardBody block
    
) # end of dashboardPage block