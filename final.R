# Load required libraries
library(tidyverse)
library(lubridate)
library(xts)
library(forecast)
library(tseries)
library(PerformanceAnalytics)
library(corrplot)
library(quadprog)
library(zoo)
library(patchwork)
library(RColorBrewer)  # For custom color palettes

# Step 1: Set the folder path and read data
folder_path <- "C:/Users/pshru/OneDrive/Desktop/Code/Datasets/Crypto Coins"
crypto_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

# Step 2: Function to read and process cryptocurrency data
process_crypto_file <- function(file_path) {
  data <- read_csv(file_path, show_col_types = FALSE) %>%
    mutate(Date = as.Date(Date)) %>%
    arrange(Date)
  
  crypto_name <- tools::file_path_sans_ext(basename(file_path))
  
  data %>%
    select(Date, Close) %>%
    rename(!!crypto_name := Close)
}

# Step 3: Read and process all cryptocurrency files
crypto_data <- crypto_files %>%
  map(process_crypto_file) %>%
  reduce(full_join, by = "Date")

# Step 4: Fill missing values using linear interpolation
crypto_data <- crypto_data %>%
  mutate(across(-Date, ~ zoo::na.approx(., na.rm = FALSE))) %>%
  drop_na()

# Step 5: Convert to xts object for time series analysis
crypto_xts <- xts(crypto_data[,-1], order.by = crypto_data$Date)

# EDA Section ----------------------------------------------

# Descriptive Statistics
descriptive_stats <- crypto_xts %>%
  as.data.frame() %>%
  summarise(across(everything(), \(x) list(mean = mean(x, na.rm = TRUE), 
                                           sd = sd(x, na.rm = TRUE), 
                                           min = min(x, na.rm = TRUE), 
                                           max = max(x, na.rm = TRUE))))
print("Descriptive Statistics:")
print(descriptive_stats)

# Plot Historical Price Trends
crypto_data_long <- crypto_data %>% pivot_longer(-Date, names_to = "Cryptocurrency", values_to = "Price")

ggplot(crypto_data_long, aes(x = Date, y = Price, color = Cryptocurrency)) +
  geom_line() +
  ggtitle("Historical Price Trends") +
  xlab("Date") +
  ylab("Price") +
  theme_minimal()

# Plot Price Distributions
crypto_data_long %>%
  ggplot(aes(x = Price, fill = Cryptocurrency)) +
  geom_histogram(bins = 30, alpha = 0.6) +
  facet_wrap(~Cryptocurrency, scales = "free") +
  ggtitle("Price Distribution") +
  xlab("Price") +
  theme_minimal()

# Stationarity Visualization
par(mfrow = c(2, 1))  # Plot original and differenced series
for (crypto in colnames(crypto_xts)) {
  plot(crypto_xts[, crypto], main = paste("Original Series:", crypto), ylab = "Price", col = "blue")
  plot(diff(crypto_xts[, crypto]), main = paste("Differenced Series:", crypto), ylab = "Differenced Price", col = "red")
}

# End of EDA Section ---------------------------------------

# Step 6: Perform ADF test for stationarity and differencing
adf_results <- map_dbl(names(crypto_xts), ~ {
  series <- crypto_xts[, .x, drop = TRUE]
  adf.test(series, alternative = "stationary")$p.value
})

# Identify non-stationary series and apply differencing
non_stationary <- names(adf_results[adf_results >= 0.05])
diff_crypto_xts <- crypto_xts
for (col in non_stationary) {
  diff_crypto_xts[, col] <- diff(crypto_xts[, col], differences = 1)
}
diff_crypto_xts <- na.omit(diff_crypto_xts)

# Step 7: Forecasting for differenced series
forecast_results <- map(names(diff_crypto_xts), ~ {
  series <- diff_crypto_xts[, .x, drop = TRUE]
  fit <- auto.arima(series)  
  forecasted <- forecast(fit, h = 30) 
  list(crypto = .x, forecast = forecasted)
})
names(forecast_results) <- names(diff_crypto_xts)  # Assign names explicitly

# Step 8: Combine and plot all forecasts
forecast_plots <- map(forecast_results, ~ {
  autoplot(.x$forecast) +
    ggtitle(paste("Forecast for", .x$crypto)) +
    xlab("Days") +
    ylab("Price (Differenced)")
})

combined_plots <- wrap_plots(forecast_plots) +
  plot_annotation(title = "Cryptocurrency Forecasts (Differenced Series)",
                  caption = "Forecasted using ARIMA models")
print(combined_plots)

# Step 9: Portfolio Construction and Analysis
crypto_returns <- diff(log(crypto_xts)) %>% na.omit()
weights <- rep(1 / ncol(crypto_returns), ncol(crypto_returns))
portfolio_returns <- Return.portfolio(crypto_returns, weights = weights)

# Portfolio performance summary
portfolio_summary <- table.AnnualizedReturns(portfolio_returns)
print(portfolio_summary)

# Portfolio risk metrics
portfolio_risk <- StdDev(portfolio_returns)
print(paste("Portfolio Risk (StdDev):", round(portfolio_risk, 4)))

# Correlation plot for cryptocurrencies
corr_matrix <- cor(crypto_returns)
corrplot(corr_matrix, method = "circle", title = "Cryptocurrency Correlation")

# Portfolio cumulative returns plot
cumulative_returns <- cumprod(1 + portfolio_returns)
autoplot(as.zoo(cumulative_returns), xlab = "Date", ylab = "Cumulative Returns",
         main = "Portfolio Cumulative Returns") +
  theme_minimal()