library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyquant)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(data.table)
library(dygraphs)

#nyse_stocks = data.frame(tq_exchange("NYSE"))
#amex_stocks = data.frame(tq_exchange("AMEX"))
#nasdaq_stocks = data.frame(tq_exchange("NASDAQ"))




aggregate_exchanges = bind_rows(data.frame(tq_exchange("NYSE")),
                                data.frame(tq_exchange("AMEX")),
                                data.frame(tq_exchange("NASDAQ")))

aggregate_exchanges %>% 
  arrange(aggregate_exchanges, by = symbol) -> aggregate_exchanges


#View(nasdaq_stocks)
#View(amex_stocks)
#View(nyse_stocks)

#nyse_stocks$symbol = str_replace(nyse_stocks$symbol, "\\^", "-P")