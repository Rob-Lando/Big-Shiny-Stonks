library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyquant)
library(shinydashboard)


nyse_stocks = data.frame(tq_exchange("NYSE"))
nyse_stocks$symbol = str_replace(nyse_stocks$symbol, "\\^", "-P")
tickers = nyse_stocks$symbol

