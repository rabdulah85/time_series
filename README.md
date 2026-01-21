This script uses a univariate ARIMA model to forecast Indonesia’s medium rice prices for January–June 2026. The data are monthly from January 2018 to December 2025, and prices are converted to natural logarithms so that changes can be read as approximate percentage movements.

The script first tests whether the log price series is stationary using Augmented Dickey–Fuller (ADF) tests in levels and in first differences, with and without a trend term. These tests typically show that the series is I(1): non‑stationary in levels, but stationary after one difference, which supports using an ARIMA model with d=1

Next, several ARIMA specifications are estimated, including ARIMA(0,1,1), ARIMA(1,1,0), and ARIMA(0,1,0). The model with the lowest Akaike and Bayesian information criteria (AIC and BIC) is selected; in this case ARIMA(0,1,1) offers the best balance between goodness of fit and model simplicity

The chosen ARIMA(0,1,1) model is then used to produce dynamic forecasts for the log of medium rice prices from January 2026 forward. The script extends the time index by six months, generates out‑of‑sample forecasts, and transforms them back to the original price level to obtain projections for January–June 2026

Finally, the code checks model adequacy through residual diagnostics. It calculates model residuals, examines their autocorrelation with correlograms, and applies the Ljung–Box test to see whether residuals resemble white noise. If there is no strong remaining autocorrelation, the ARIMA(0,1,1) specification is considered suitable for short‑term forecasting of medium rice prices.
