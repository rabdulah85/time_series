# Indonesia Medium Rice Price Forecasting

## Overview
This project uses a univariate ARIMA model to forecast Indonesia's medium rice prices for **January–June 2026**. The analysis combines historical monthly price data (January 2018 – December 2025) with statistical time series modeling to generate short-term price projections.

---

## Data Preparation
- **Time Period:** January 2018 – December 2025 (monthly observations)
- **Transformation:** Prices converted to natural logarithms
  - Allows changes to be interpreted as approximate percentage movements
  - Helps stabilize variance in the time series

---

## Methodology

### 1. Stationarity Testing
The script tests whether the log price series is stationary using **Augmented Dickey–Fuller (ADF) tests**:
- Tests performed in levels and in first differences
- Evaluated with and without a trend term
- **Findings:** Series is I(1) — non-stationary in levels, but stationary after first differencing
- **Implication:** Supports ARIMA modeling with d=1

### 2. Model Selection
Multiple ARIMA specifications are estimated and compared:
- ARIMA(0,1,1)
- ARIMA(1,1,0)
- ARIMA(0,1,0)

**Selected Model:** ARIMA(0,1,1)
- Lowest AIC and BIC scores
- Best balance between goodness of fit and model simplicity

### 3. Forecasting
The ARIMA(0,1,1) model generates dynamic out-of-sample forecasts:
- Extends time index by six months
- Produces forecasts for log prices
- Back-transforms to original price level for January–June 2026 projections

### 4. Model Diagnostics
Residual analysis confirms model adequacy:
- **Autocorrelation Analysis:** Uses correlograms to inspect residual patterns
- **Ljung–Box Test:** Evaluates whether residuals resemble white noise
- **Conclusion:** No strong remaining autocorrelation indicates ARIMA(0,1,1) is suitable for short-term forecasting

---

## Key Results
✓ ARIMA(0,1,1) model successfully captures rice price dynamics  
✓ Residuals show no significant autocorrelation  
✓ Model is ready for production forecasting of January–June 2026 prices


