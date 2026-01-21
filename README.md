This script uses a univariate ARIMA model to forecast Indonesia’s medium rice prices for January–June 2026. The data are monthly from January 2018 to December 2025, and prices are converted to natural logarithms so that changes can be read as approximate percentage movements.

The script first tests whether the log price series is stationary using Augmented Dickey–Fuller (ADF) tests in levels and in first differences, with and without a trend term. These tests typically show that the series is I(1): non‑stationary in levels, but stationary after one difference, which supports using an ARIMA model with d=1

Next, several ARIMA specifications are estimated, including ARIMA(0,1,1), ARIMA(1,1,0), and ARIMA(0,1,0). The model with the lowest Akaike and Bayesian information criteria (AIC and BIC) is selected; in this case ARIMA(0,1,1) offers the best balance between goodness of fit and model simplicity

The chosen ARIMA(0,1,1) model is then used to produce dynamic forecasts for the log of medium rice prices from January 2026 forward. The script extends the time index by six months, generates out‑of‑sample forecasts, and transforms them back to the original price level to obtain projections for January–June 2026

Finally, the code checks model adequacy through residual diagnostics. It calculates model residuals, examines their autocorrelation with correlograms, and applies the Ljung–Box test to see whether residuals resemble white noise. If there is no strong remaining autocorrelation, the ARIMA(0,1,1) specification is considered suitable for short‑term forecasting of medium rice prices.

The code 


	
//	Medium Rice Price Projection January 2026-Juni 2026

*-------------------------------------------------------------
* 1. Data Preparation
*-------------------------------------------------------------
clear


use "https://raw.githubusercontent.com/rabdulah85/time_series/arima/arima_rice_price.dta", clear


tsset mdate, monthly

* log medium price
gen lnmedium = ln(medium)

*-------------------------------------------------------------
* 2. Stationarity lnmedium
*-------------------------------------------------------------
* ADF without trend, lag 0, lag 4
dfuller lnmedium, lags(0)
dfuller lnmedium, lags(4)
dfuller lnmedium, lags(4) trend ///with trend

*-------------------------------------------------------------
* 3. Stationarity lnmedium first difference D.lnmedium
*-------------------------------------------------------------
gen D_lnmedium = D.lnmedium

dfuller D_lnmedium, lags(0)
dfuller D_lnmedium, lags(4)



* Graphic lnmedium (non-stasioner)
tsline lnmedium, ///
    title("Log medium price (level)") ///
    ytitle("ln(medium)") xtitle("Month")

* Graphic D.lnmedium (stasioner)
tsline D_lnmedium, ///
    title("Delta log medium price (D.lnmedium)") ///
    ytitle("D.lnmedium") xtitle("Month")


*-------------------------------------------------------------
* 4. Candidate ARIMA models for medium
*-------------------------------------------------------------


* Model A: ARIMA(0,1,1)
arima lnmedium, arima(0,1,1)
estimates store MED_A

* Model B: ARIMA(1,1,0)
arima lnmedium, arima(1,1,0)
estimates store MED_B

* Model C: ARIMA(0,1,0)
arima lnmedium, arima(0,1,0)
estimates store MED_C

* Compare AIC/BIC
estimates stats MED_A MED_B MED_C



arima lnmedium, arima(0,1,1) //choosen, check AIC value

tsappend, add(6)


*  Dynamic forecast starting Jan‑2026
predict lnmed_f_2026, dynamic(tm(2026m1)) y

* Back-transform to level
gen medium_f_2026 = exp(lnmed_f_2026)

* Show 2026 forecasts
list mdate medium medium_f_2026 ///
    if inrange(mdate, tm(2026m1), tm(2026m6))

arima lnmedium, arima(0,1,1)
predict e_medium, resid
corrgram e_medium, lags(20)
wntestq e_medium, lags(12)


//end

//do same code for low and premium rice price

* low




