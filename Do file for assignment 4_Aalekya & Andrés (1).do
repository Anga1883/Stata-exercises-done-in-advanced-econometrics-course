********************************************************************************
*                                  EC7420                                      *
*                            Exercise 10, Topic 7                              *
*                                                                              *
* Note: You need to comment this do-file explaining what is done in each line  *
*       Don't forget to mention if standard error or variances are estimated   *
*       using some particular estimator                                        *
******************************************************************************** 



* Open dataset *****************************************************************
  clear
  *cd [write here your working directory]
  use "PS7_housecredits.dta"
  
  /*  This command is telling stata that we are working with cross sectional timeseries data for the following regressions taking into account the county and the year. */
  tsset county year  
  
* Question 1 
  * This task asks us to intpret the Beta1 coefficient in the regression: Dl_hpi Dl_vloans_b, cluster(county). *
  * The Beta1 coefficient is explaining to what extent the logarithmic change in the volume of loan credits is impacting the logarithmic change in house prices during the 11 year period for the given counties. *
 
* Question 2
  * The statement claims that credit supply depends on the price of the asset. The asset in this case, refers to the house price. Based on this, an econometric problem that they point out is that of reverse causality, as this means the house prices has an effect on the credit supply just as the credit supply has an effect on the house prices. *
  * Another econometric problem that is possibly being point out is that of ommitted variable bias. The statement about the credit responding endogeonously with current and expected economic conditions suggests a correlation between the credit supply and economic conditions as respective variables. Intuitively, economic conditions should also have correlation with house prices and since economic conditions are not included as a variable, this may be suggesting omitted variable bias. * 
  
* Question 3 *******************************************************************

  /*  This formula is running a regression with standard errors adjusted for clusters using the logarithmic change in house prices as the dependent variable and the logarithmic change in the volume of the loan credits as the independet variable.*/
  reg Dl_hpi Dl_vloans_b, cluster(county)
   *Regressing the equation we see that there is a positive Beta1 coefficient for the volume of loan credits variable. However, the coefficient is very small at, 0.0072079 or around 0.72% suggesting that a unit change in the volume of loans credit would change the dependent variable by the named percentage. 
   * Assessing the P-value we can see that, despite the small coefficient, it is statistically significant at a 95% confidence interval.
   
* Question 4 *******************************************************************

  /*  An absorbed regression is run with the same variables as the initial regression model, while including the county fixed effects. */   
  areg Dl_hpi Dl_vloans_b, absorb(county) cluster(county)
  * Including the county fixed effects reduces the coefficient and increases the standard error for the delta log volume of loans variable while increasing the R-squared value for the regression. Assessing econonometric improvements we see very little variation in the coefficients and the standard error while observing a large increase in the R-square value, suggesting a better fitting regression. 
  * Using county fixed effects may control the omitted variable bias that would arise from geographical location, in the form of counties. This variable would not be time variate and since time invariate omitted variables are controled in panel data, county would be controlled.  
  
* Question 5

  * Taking an example such as the currently, unusually high, inflation rates, we will likely see developing patterns among loan taking and house purchasing in society. While macroeconomic shocks may be of high importance for understanding house prices, it is important to recognise the expectation or anticipation of the macroeconomic shocks may also have sigificant impact on socio-economic grounds. An example of this being, if people are expecting significant macroeconomic shocks, people are less likely want loans and go into debt. Maintaining liquidity becomes important. Taking this into account, assuming house prices are also determined by these factors, the macroeconomics shocks such as inflation may be considered as omitted variables.    
  
* Question 6 *******************************************************************
  
  /*  This regression is uses the logarithmic change in the house prices and the logarithmic change in the volume of loans as the dependent and independent variables, respectively. The regression separates all the years into dummy variables where the concerned counties are absorbed. */
  
  areg Dl_hpi Dl_vloans_b i.year, absorb(county) cluster(county)
  * Several factors that result in omitted variable bias are time invariate. This implies that the effect that such a factor would have on one period, would apply on other periods. 
  * (5) highlights macroeconomic shock and the effect it would have on the entire country. By including year fixed effects, we can identify which years the macroeconomics shocks would have been prevelant and we can also assess whether these years were statistically sigificant. The example here begin, 1999 and 2000 showing negative correlation but also displaying high P values, suggest they are not statistically significant.  

  
* Question 7 *******************************************************************
  
  /*  This equation is estimating the impact of %change in credit loans, %change in population, %change in income and %change in total deposits on %change in house prices */
  areg Dl_hpi Dl_vloans_b Dl_pop Dl_inc Dl_totd_b i.year , absorb(county) cluster(county)
  * Adding these variables increases the coefficient for logarithmic change in the volume of loans while also slightly increasing the standard errors. The R-square value of the model also increases. 
  * Assessing the variables, we see that the variable Dl_inc shows a P-value of 0.343 suggesting that is variable is not statistically significant. The DL_pop variable has the highest coefficient but also has the highest standard error.
  * Whether the variables can be considered as omitted variables depends largely on the correlation each respective variable has with the existing dependent and independent variables. Intuitively, Dl_pop is correlated with both the dependent and independent variables. The same understanding applies for the DL_inc and Dl_totd_b variables. Consequently, they can be considered omitted variables. 
  
  
* Question 8

* A condition for a variable to be used as an instrumental variable is that it needs to be relevant i.e. there needs to be a correlation between the instrumental variable and the variable it was derived from. 
* Another condition is that the indtrumental variable needs to be exogonous, meaning it should not correlate with the error term. 
* The instrumental variable only effects the dependent variable only through the independent variable that was in the initial model. 


* Question 9  
  
* To use deregulation as an instrument for delta log loan credits, we need to assume relevancy and exogeneity. The deregulation also needs to affect delta log house prices through delta log loan credits. The assumption for relevancy can be tested as we can observe the instrumental variable and the initial variable (being delta log loan credits), while we cannot test exogentity as the error term cannot be observed. 
  
* Question 10 *******************************************************************
  
  /*  We are generating the 1 period lagged variable for delta log income change. */
  gen  Dl_inc_lag1 = L.Dl_inc
  
  /*  We are generating the 2 period lagged variable for delta log income change. */
  gen  Dl_inc_lag2 = L2.Dl_inc
  
  /*  This equation is regressing the regulation using the income changes over three periods */
  reg  inter_bra Dl_inc Dl_inc_lag1 Dl_inc_lag2 , robust
 
  /*  This is testing whether impact of the change in income over three periods = 0  */
  test Dl_inc + Dl_inc_lag1 + Dl_inc_lag2 = 0

* The question asks us if we can reject that the recent income shocks increase the incentive to deregulate. This means that our null hypothesis is that income shocks increase the incentive to deregulate. 
*All the three included explanatory variables are shown to have negative coefficients however, they all have significantly high p-values, suggesting that they are not statistically sigificant as we cannot reject the null hypothesis. This means that we cannot reject that recent income shocks incease incease to deregulate, suggesting that income shock, present and past may have increased the deregulation.

* Question 11

* Because we accept that income shocks can increase deregulation, we see can establish that deregulation is relevant (as the two variables can observed) to the regression and so fullying the criteria for a valid instrumental variable. 
  
  
* Question 12 *******************************************************************
   
  /*  This equation is estimating the effect of lagged deregulation for explanaing delta log loan credits using fixed effects for county and years. */ 
  areg Dl_vloans_b Linter_bra i.year , absorb(county) cluster(county)
  
  *The results indicate that after 1996, there is a negative coefficient trend for all forthcoming years. We see that all years from 1997 to 2005 are statsitcally significant. 1995 and 1996 shows positive coefficients but also very high p-values suggests that they are not statsitcally sigificant. This indicates that and after 1996, people the deregulation is suggesting that people take less loan credits. The over coefficient for the Linter_bra variable is positive however, this is likely due to that incentive to deregulate does not fully explain the %change in total volume of  loan credits. 
  
* Question 13 
  * The assumption that is being directly tested here is that Linter_bra is relevant to DL_vloans_b. In order for this to be true we need to see a statistically significant coefficient for Linter_bra as the explanatory variable in this model. As we do see statistically significant coefficient, we can establish that lagged deregulation is relevant when assessing delta log volume of loan credits.    
  
  
* Question 14 *******************************************************************
  
  /*  This equation is regressing panel data, using the lagged deregulation as an instrumental variable while including fixed effects for county and year, using clustered, robust standard errors. */ 
  xtivreg Dl_hpi (Dl_vloans_b = Linter_bra)  i.year , fe vce(cluster county)
  
* Question 15

  *This question ask us to assess estimated Beta1 from (14) and compare with previous estimations. For all the Beta1 estimations, we see that they are statsitcally sigificant however, for the Beta1 estimation with lagged deregulation as the instrumental variable (along with including fixed effects for county and year), we see a much larger coefficient. This suggests that including this instrumental variable significantly improves the observed impact of Dl_vloans_b on Dl_hpi.     
  
* Question 16 *******************************************************************
  
  /*  This equation is computing the reduced form regression. This is not comprehensive when explaining the dependent with the independent variable */  
   areg Dl_hpi Linter_bra i.year, absorb(county) cluster(county)
  /*  This is storing the reduced form into RF */  
   scalar  RF = _b[Linter_bra]
    
  /* This equation is computing the first stage regression. */  
   areg Dl_vloans_b Linter_bra i.year, absorb(county) cluster(county)
  /*  This is storing first stage regression into FS  */  
   scalar  FS = _b[Linter_bra]
  
  /*  We divide the reduced form coefficient with the first stage regression coefficient to find the IV estimator, which is the same the estimated Beta1 =.1111143. */ 
   display in yellow "IV should be =" RF/FS
  
  
    
