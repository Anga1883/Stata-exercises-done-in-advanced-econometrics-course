clear all

use PS3_lotteries.dta

* PS4 - Exercise 3 * 

* The first step is to run the regression for delta consumption. Before we can do so, we need to generate a variable for delta consumption. The interpretation is that consumption is the same as expenditure. There for delta expenditure is due to totalexp_after - totalexp_before. 

gen dconsumption = totalexp_after - totalexp_before

* next we run the regression with the following variables: winner, buyer, age_head and kids.

reg dconsumption winner buyer age_head kids

** Question 1 **

*This question requires intuitive explanation of the stata's outcome for St, Err, t, P>|t|,  [95% Conf. Interval]*

* The standard error for the variables winner, buyer and kids is fairly high. Generally, a large standard error suggests inaccuracy of the coefficient for each respective variable. Since the mentioned variables have fairly high standard errors, this would indicate that the coefficients are possibly inaccurate. 

* The t statistic represents a ratio between the coefficients and std. err. for each respective variable. The T value is essentially a measure of the variation between the sample and the mean, and is also used to test the null hypothesis. In general, a t-value close to 0 (-2<t<+2) is considered a low t-score and this indicates a low predicitive power of a particular coefficient. For our case, all the variables apart from kids have arguably low t-statistic, suggesting that the coefficients are not very reliable. 

* The P value represents a decimal probabilty that the coefficient will have an acceptable confidence interval. Generally, a P value higher than 10% is considered to indicate a low probability that the coefficient is statistically significant. In this case, we can see that the varibles: winner, buyer and age_head have very large P-values, indicating that the coefficients of the varibles are probably not statistically significant. The P-value for the variables "kids" is less than 1%, suggesting that this variable is the only statistically significant variable in the regression. Intuitively, this means that more kids, results in more expenditure. 

* The 95% confidence interval indicates a 95% probability that the estimated coefficient is close to the true value/population mean. 


** Question 2 **
 
* The question asks us to test whether the hypothesis that beta coefficient for the variable winner = 0. 

test winner = 0

* Testing whether the coefficient of the winner variable = 0 gives us a P value of 0.1622. Due to this high P-value we cannot reject the null hypothesis that the coefficeint for this variable is significantly different from 0. 


** Question 3 ** 

* To find the numerical interval for which beta1 lies within 95% probability we need to fisrt identify the critical z-values corresponding to 95% confidence. In this case, critical values are +- 1.96. Next, to calculate the lowest and highest values of the interval, we use the follow calcation: 

display (33.17538 - 1.96 * 23.72057) 
* = -13.316

display (33.17538 + 1.96 * 23.72057)
* = 79.667697

* We are then left with the CIlower of -13.316 and CIhigher of 79.667697. 


** Question 4 ** 

* The question first ask us to test the joint hypothesis that all non-constant coefficients are = 0. In order to do this we first run a test for the required variables: 

test winner buyer age_head kids

* This test gives us an F(4, 1278)= 5.27. This statistic tells us whether the variables are jointly explaining the dependent variable dconsumption. 

reg dconsumption winner buyer age_head kids

* The R-square value which we get from a regression with the same variables is 0.0162. This value indicates the strength of the relationship between the explanatory variables and the model.

* The F-test of the overall significance is the hypothesis of this relationship between the ex. variables and dependent variable.


** Question 5 ** 

* This question asks us to test when the beta coefficients for the age_head variables and kids = 0. 

test age_head
test kids
test age_head kids

* In this question we tested each of the two variables individually and then also collectively. From the individual tests we see that the F - test is:  F(1,1278) = 0.71 and  F(1,1278) = 11.18 for age_head and kids  respectively. 


** Question 6 ** 

* This questions asks us to test whether the beta coefficient for kids = 20. 

test kids = 20

* Here we get the f-test result that F(1,1278) = 0.25. 

 
 





