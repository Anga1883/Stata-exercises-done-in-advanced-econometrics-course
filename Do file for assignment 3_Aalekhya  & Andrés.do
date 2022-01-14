clear

* Problem set 6* 
* Exercise 12* 

use PS6_vote.dta

* Question 1 * 
* The first question asks us to estimate the regression with the explanatory variables being: ngirls, totchi, white, age, female. * 

reg nowtot ngirls totchi white age female

* Question 2 * 

* To find the effect of one more girl on the dependent variables, we examine the explanantory varible ngirls. *
* B1 ngirls = 4.310456 * 
* The higher the coefficient, the more libral the voting is. Therefore, as we can derive that one extra duaghter will increase the liberal voting index nowtot by 4.3%. * 

* Question 3 *  

* This task asks us to check whether the explanantory variable ngirls suffers from reverse causation in this regressions. *
* Reverse causation in this case is when the x explains y while y also explains x * 
* In order to test for reverse causation we run a regression with the dependent variables being ngirls and nowtot being an explanantory variable *

reg ngirls nowtot totchi white age female

* We get the a Beta coefficient of .0024 for the ex. variable nowtot. While this suggests that nowtot has very little impact on ngirls, it is not conclusive. Causality is dependent on so many varibles that this explanation can only form part of an understanding. * 

* Intutitively, if there was a case of reverse causation, it would mean that the % increase in liberal voting would increase the number of daughters in a household. This does not make a lot of sense and therefore the intutitive explanation of the regression suggests that reverse causation is no significant in this model. * 

* Question 4 * 

* The question asks us to assess the possibility of omitted variable bias regarding the ex. variables ngirls. *
*In order to test for this, we first look at the p-value in the inital regression. 

reg nowtot ngirls totchi white age female

* Here the p-value is 0.034 suggesting that the probability that ngirls explains a part of the nowtot, is high. * 
* Next we do multiple regressions, removing one variable at a time, in order to test if the coefficient for ngirls changes drastically. * 

reg nowtot ngirls totchi white age female
reg nowtot ngirls totchi white age 
reg nowtot ngirls totchi white 
reg nowtot ngirls totchi 
reg nowtot ngirls 

* the coefficient for the ngirls variable does not change significantly as we remove variables, until ngilrs is the only explanatory variable remaining in the model. Only then can we see that the coefficient changes to -2.14623, suggesting omitted variable bias, in the case of it being the only ex. variable. * 

* Question 5 * 

* If the data suggests that voters with more childen/ more daughter have more variable voting patterns this could cause issues for OLS for multiple reasons. One fundamental issue is that a much larger sample size would be required in order to get more approprate estimations. *
* Because of the variance amongs voters with more daughters/ more children, it is likely that we would see a greater variance for the residuals as well. This could result in heteroskedasticity, a condition where the residuals become continuously more variable. * 

* Question 6 * 

* In order to estimate with the regression with robust standard erorrs, we use the same model but in the end add the function "robust" * 

reg nowtot ngirls totchi white age female, robust
reg nowtot ngirls totchi white age female

* Running the regression using robust standard errors, we can see that the Beta coefficients for all the variables remained unchanged and there was no significant altaration in their p-values either. The R-square of the model was also unchanged. The standard errors for the robust standard errors regression was also slightly higher for the ngirls variable. This suggests that this model does not suffer from heterskedasticity.*

* Generally we want homoskedasticity in our data. Robust standard errors is used when we suspect violation of homoskedasticity. * 

* Question 7 * 

* Clustered errors among politians could be problematic for OLS as if the groups of politians share very similar characteristics, autocorrelation within the groups may be an issue when estimating the samples. * 

* Question 8 * 

egen politicgroup = group(repub female white reld3 highdemvote)
  
* The variable highdemvote was used instead of districtdem as it is a dummy variable, serving essentially the same purpose. * 

* Question 8 continued *
 
reg nowtot ngirls totchi age, cluster(politicgroup)
reg nowtot ngirls totchi white age female

* We run the regression with cluster-robust standard errors and find that the coefficient for ngirls increases from 4.310456 to 5.842586. The St. errors also increases for the variable. The P-values remain adequetly low. The R-square value however, decreases from 0.2355 to 0.0791, suggesting that the fit of the model can be improved. *  


