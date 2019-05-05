Exercise 1
In the extdata folder of the learningr package, there is a file named hafu.csv, 
containing data on mixed-race manga characters. Import the data into a data frame.

Exercise 2
Also in the extdata folder of learningr is an Excel file named multi-drug-resistant 
gonorrhoea infection.xls. Import the data from the first (and only) sheet into a data 
frame. Hint: this is a little easier if you view the file in a spreadsheet program first. 

Exercise 3
From the crab tag SQLite database described in this chapter, import the contents 
of the Daylog table into a data frame.

Exercise 4
Load the hafu dataset from the learningr package. In the Father and Mother columns, 
some values have question marks after the country name, indicating that the 
author was uncertain about the nationality of the parent. Create two new columns 
in the hafu data frame, denoting whether or not there was a question mark in 
the Father or Mother column, respectively.
Remove those question marks from the Father and Mother columns. 

Exercise 5
The hafu dataset has separate columns for the nationality of each parent. 
Convert the data frame from wide form to long form, with a single column for 
the parents’ nationality and a column indicating which parent the nationality 
refers to.

Exercise 6
Write a function that returns the 10 most common values in a vector, along 
with their counts. Try the function on some columns from the hafu dataset. 

Exercise 7
In the obama_vs_mccain dataset, find the (Pearson) correlation between the 
percentage of unemployed people within the state and the percentage of people 
that voted for Obama.
Draw a scatterplot of the two variables, using a graphics system of your choice. 
(For bonus points, use all three systems.) 

Exercise 8
In the alpe_d_huez2 dataset, plot the distributions of fastest times, split by 
whether or not the rider (allegedly) used drugs. Display this using 
a) histograms and b) box plots.

Exercise 9
The gonorrhoea dataset contains gonorrhoea infection rates in the US by year, 
age, ethnicity, and gender. Explore how infection rates change with age. Is there 
a time trend? Do ethnicity and gender affect the infection rates?