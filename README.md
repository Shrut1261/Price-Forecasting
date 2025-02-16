# Cryptocurrency Price Forecasting and Portfolio Impact Evaluation

## Introduction
This study examines the impact of different forecasting models, specifically **ARIMA (Auto Regressive Integrated Moving Average)** and **ETS (Exponential Smoothing State Space)**, on the performance of an investment portfolio comprising five major cryptocurrencies. By analyzing how these models predict cryptocurrency price movements, we gain insights into their influence on portfolio construction and investment returns.

The dataset used in this analysis consists of the **daily closing prices** of the following cryptocurrencies:
- **Bitcoin (BTC)**
- **Cardano (ADA)**
- **Ethereum (ETH)**
- **Polygon (MATIC)**
- **Solana (SOL)**

The data spans from **June 4, 2020, to August 28, 2021,**, and has been preprocessed to include only **date and closing prices** for each asset. Given the highly volatile nature of cryptocurrencies, effective forecasting models are essential for mitigating risk and maximizing returns.

---

## Forecasting Models Utilized
### 1️⃣ ARIMA (Auto Regressive Integrated Moving Average)
ARIMA is a time series forecasting method that utilizes past price data to predict future trends. It is particularly effective for datasets with a clear trend but no seasonality. ARIMA captures dependencies in past price movements to generate future price predictions.

### 2️⃣ ETS (Exponential Smoothing State Space Model)
ETS is another powerful forecasting method that incorporates trend and seasonality components. Unlike ARIMA, ETS gives **higher weight to recent data**, making it more adaptive to price fluctuations, which is essential for volatile assets like cryptocurrencies.

Both models were used to predict the **next 30 days of closing prices** for each cryptocurrency. To evaluate model performance, two key metrics were calculated:
- **Mean Absolute Error (MAE)** – Measures the average absolute differences between actual and predicted prices.
- **Root Mean Squared Error (RMSE)** – Provides insight into how much error exists in the predictions.

---

## Exploratory Data Analysis (EDA)
Exploratory Data Analysis (EDA) was conducted to understand price movements, volatility, and market behavior for each cryptocurrency. Below is a summary of descriptive statistics for each asset:

| Cryptocurrency | Mean Price | Standard Deviation | Minimum Price | Maximum Price |
|--------------|------------|------------------|--------------|--------------|
| **Bitcoin**   | 29,763.35  | 17,340.05       | 9,008.30     | 63,540.90    |
| **Cardano**   | 0.7204     | 0.6904          | 0.0753       | 2.9459       |
| **Ethereum**  | 1,353.07   | 1,034.57        | 221.06       | 4,167.78     |
| **Polygon**   | 0.4070     | 0.5623          | 0.012        | 2.4500       |
| **Solana**    | 15.54      | 18.28           | 0.567        | 93.82        |

**Key Insights:**
1. **Price Trends:** Bitcoin had the highest mean price, reflecting its dominance in the market. Ethereum followed, while Cardano, Polygon, and Solana maintained lower average prices.
2. **Volatility:** Bitcoin and Ethereum exhibited **high standard deviations**, indicating significant price fluctuations. Solana also showed substantial volatility, whereas Cardano and Polygon demonstrated more stability.
3. **Market Extremes:** Bitcoin ranged from **$9,008.30 to $63,540.90**, illustrating dramatic market swings. Ethereum and Solana followed similar patterns, while Cardano and Polygon displayed relatively moderate price variations.

---

## Time Series Analysis and Forecasting
### 1️⃣ Historical Price Trends
Analysis of historical price movements between **July 2020 and July 2021** revealed the following:
- **Bitcoin experienced significant price swings**, reaching its peak in early 2021.
- **Ethereum showed steady growth**, reflecting its increasing adoption in the blockchain ecosystem.
- **Cardano and Polygon surged in late 2021**, gaining investor interest due to technological advancements.
- **Solana displayed extreme volatility**, with rapid price increases followed by sharp declines.

### 2️⃣ Time Series Differencing & Trend Analysis
- Differencing techniques were applied to remove long-term trends and focus on **short-term volatility**.
- **Forecast confidence intervals** were generated to estimate the reliability of predictions.
- Wider confidence intervals in Bitcoin and Ethereum forecasts indicate **higher uncertainty**.
- Tighter confidence intervals in Cardano and Polygon suggest **more stable short-term behavior**.

### 3️⃣ Forecasting with ARIMA and ETS
- **ARIMA models** provided smoother forecasts, suitable for assets with established trends.
- **ETS models** were more responsive to recent price fluctuations, better capturing short-term trends.
- **Forecast results** indicated that ETS models performed better in highly volatile markets, such as Bitcoin and Ethereum.

---

## Portfolio Performance Evaluation
An equally weighted portfolio was constructed using predictions from **both ARIMA and ETS models** to assess their impact on investment returns.

- **ARIMA-based Portfolio:** Showed **consistent but conservative returns**, making it suitable for investors seeking stability.
- **ETS-based Portfolio:** Delivered **higher returns**, as it responded better to short-term price changes, making it ideal for high-risk investors.

**Key Takeaways:**
1. **ARIMA performed well for stable cryptocurrencies** like Cardano and Polygon.
2. **ETS captured short-term trends** more effectively in volatile assets like Bitcoin and Ethereum.
3. **A dynamic strategy combining both models** may be the best approach to balance risk and reward.

---

## Conclusion
This study compared **ARIMA and ETS forecasting models** to evaluate their impact on cryptocurrency portfolio performance. The findings indicate that:
- **ARIMA provides conservative predictions**, making it suitable for assets with predictable trends.
- **ETS is better for volatile markets**, capturing rapid price fluctuations more effectively.
- **Portfolios based on ETS forecasts outperformed ARIMA-based portfolios**, highlighting its advantage in high-risk investments.

### Future Research Directions:
- Explore **hybrid forecasting models** combining ARIMA, ETS, and **machine learning techniques**.
- Incorporate **sentiment analysis** to assess the impact of social media and market news on cryptocurrency prices.
- Optimize **portfolio allocation strategies** using advanced risk management models.

Understanding forecasting models is critical for cryptocurrency investors seeking to make informed decisions in an unpredictable market. Future research can further refine these models to enhance forecasting accuracy and portfolio optimization.

**References:**  
[1] Forecasting Principles and Practice - https://otexts.com/fpp2/
