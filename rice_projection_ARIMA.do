clear 


	
//	Medium Rice Price Projection January 2026-Juni 2026

*-------------------------------------------------------------
* 1. Data Preparation
*-------------------------------------------------------------
clear
use "/Users/rabdulah/Library/CloudStorage/OneDrive-Personal(2)/00_GSID/15_Output_non Disertasi/04_ADB_Conference/paddy+pruce_jan2026_.dta", 


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



