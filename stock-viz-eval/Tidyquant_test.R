# Testing TidyQuant Package in R

library(tidyquant)
library(ggplot2)


options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)
# Downloading Apple price using quantmod

getSymbols("AAPL", from = '2017-01-01',
           to = "2018-03-01",warnings = FALSE,
           auto.assign = TRUE)
head(AAPL)

class(AAPL)

chart_Series(AAPL)

chart_Series(AAPL['2017-12/2018-03'])



tickers = c("AAPL", "NFLX", "AMZN", "K", "O")

getSymbols(tickers)


chart_Series(NFLX['2017-12/2018-03'])
###############################################################################
####### Using tidyquant #######################################################
###############################################################################


aapl <- tq_get('AAPL',
               from = "2017-01-01",
               to = "2021-03-01",
               get = "stock.prices")

head(aapl)
class(aapl)


data.frame(aapl)
#aapl


theme_tq_green(base_size = 11, base_family = "")

g <- ggplot(aapl,aes(x = date, y = close))
g + geom_candlestick(aes(x = date,open = open, high = high, low = low, close = close))+
  labs(title = "AAPL Candlestick Chart", 
       y = "Closing Price", x = "")+
  geom_ma(ma_fun = SMA, linetype = 2,n = 50, size = 1.1) 




nyse_stonks = data.frame(tq_exchange("NYSE"))

class(nyse_stonks)

################################################################################

nyse_stonks %>% 
  filter(symbol %like% ".\\^.") -> ish


View(ish)


ish$symbol = str_replace(ish$symbol, "\\^", "-P")

ish$symbol

fixed_symbols <- tq_get(ish$symbol, get = "stock.prices")
#fixed_symbols




CLF = data.frame(tq_get('CLF', get = "stock.prices"))

plot_ly(x = CLF$date, type="candlestick",
        open = CLF$open, close = CLF$close,
        high = CLF$high, low = CLF$low,
        increasing = i, decreasing = d)%>%
        layout(title = "(1D)")-> fig

fig

s = c()


a = data.frame(tq_get("A", get = "stock.prices"))

###############################################################################
################## Individual Stock Analysis & Evaluation #####################
###############################################################################
Ra <- c("AAPL", "GOOG", "NFLX") %>%
  tq_get(get  = "stock.prices",
         from = "2010-01-01",
         to   = "2015-12-31") %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Ra")
Ra

Rb <- "XLK" %>%
  tq_get(get  = "stock.prices",
         from = "2010-01-01",
         to   = "2015-12-31") %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Rb")
Rb

RaRb <- left_join(Ra, Rb, by = c("date" = "date"))
RaRb

RaRb_capm <- RaRb %>%
  tq_performance(Ra = Ra, 
                 Rb = Rb, 
                 performance_fun = cor)
RaRb_capm



###############################################################################
######################### Portfolio Analysis & Evaluation #####################
###############################################################################


stock_returns_monthly <- c("AAPL", "GOOG", "NFLX") %>%
  tq_get(get  = "stock.prices",
         from = "2010-01-01",
         to   = "2015-12-31") %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Ra")
stock_returns_monthly

baseline_returns_monthly <- "XLK" %>%
  tq_get(get  = "stock.prices",
         from = "2010-01-01",
         to   = "2015-12-31") %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Rb")
baseline_returns_monthly


wts <- c(0.3, 0.2, 0.5)
portfolio_returns_monthly <- stock_returns_monthly %>%
  tq_portfolio(assets_col  = symbol, 
               returns_col = Ra, 
               weights     = wts, 
               col_rename  = "Ra")
portfolio_returns_monthly

RaRb_single_portfolio <- left_join(portfolio_returns_monthly, 
                                   baseline_returns_monthly,
                                   by = "date")
RaRb_single_portfolio

RaRb_single_portfolio %>%
  tq_performance(Ra = Ra, Rb = Rb, performance_fun = table.CAPM)


tq_performance_fun_options()


