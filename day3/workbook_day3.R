Exercise 1
While typing this paragraph, I make about three typos. Use the PDF of the 
Poisson distribution, dpois, to find the probability that I make exactly three 
typos in a given paragraph.

Exercise 2
A healthy 25-year-old woman having unprotected sex at the right time has a 
25% chance of getting pregnant each month. Use the CDF for the negative 
binomial distribution, pnbinom, to calculate the probability that she 
will have become pregnant after a year.

Exercise 3
You need 23 people to have a 50% chance that two or more of them share the 
same birthday. Use the inverse CDF of the birthday distribution, qbirthday, 
to calculate how many people you need to have a 90% chance of a shared birthday. 

Exercise 5
Re-run the linear regression analysis on the gonorrhoea dataset, considering 
only 15- to 34-year-olds. Are the significant predictor variables 
different this time? 
For bonus points, explore adding interaction terms into the model.

Exercise 6
Install and load the betareg package. Explore the obama_vs_mccain dataset 
using beta regression, via the betareg function in that package. Use the 
Obama column as the response variable.
To keep things simple, remove the “District of Columbia” outlier, don’t 
bother with interactions, and only include one ethnicity and one religion 
column. (The ethnicity and religion columns aren’t independent because they 
         represent fractions of a total.) In the absence of political 
understanding, you may trust the p-values for the purposes of updating models.
Hint: You need to rescale the Obama column to range from 0 to 1.

Exercise 7
Run the kNN algorithm with the dataset used in class for various values
of k.

Exercise 8:
Run the k-means algorithm for various values of k (6,10,15).
