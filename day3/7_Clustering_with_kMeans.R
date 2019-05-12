Example – finding teen market segments using k-means clustering
Interacting with friends on a social networking service (SNS), such as 
Facebook, Tumblr, and Instagram has become a rite of passage for teenagers 
around the world.

Step 1 – collecting data
For this analysis, we will use a dataset representing a random sample of 
30,000 U.S. high school students who had profiles on a well-known SNS in 2006. 
To protect the users'' anonymity, the SNS will remain unnamed. However, at the 
time the data was collected, the SNS was a popular web destination for 
US teenagers.

Step 2 – exploring and preparing the data
We can use the default settings of read.csv() to load the data into a data frame:
  teens <- read.csv("./data/snsdata.csv")
Let''s also take a quick look at the specifics of the data. The first several 
lines of the str() output are as follows:
str(teens)
# 'data.frame':	30000 obs. of  40 variables:
#   $ gradyear    : int  2006 2006 2006 2006 2006 2006 2006 2006 2006 2006 ...
# $ gender      : Factor w/ 2 levels "F","M": 2 1 2 1 NA 1 1 2 1 1 ...
# $ age         : num  19 18.8 18.3 18.9 19 ...
# $ friends     : int  7 0 69 0 10 142 72 17 52 39 ...
# $ basketball  : int  0 0 0 0 0 0 0 0 0 0 ...
# $ football    : int  0 1 1 0 0 0 0 0 0 0 ...
# $ soccer      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ softball    : int  0 0 0 0 0 0 0 1 0 0 ...
# $ volleyball  : int  0 0 0 0 0 0 0 0 0 0 ...
# $ swimming    : int  0 0 0 0 0 0 0 0 0 0 ...
# $ cheerleading: int  0 0 0 0 0 0 0 0 0 0 ...
# $ baseball    : int  0 0 0 0 0 0 0 0 0 0 ...
# $ tennis      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ sports      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ cute        : int  0 1 0 1 0 0 0 0 0 1 ...
# $ sex         : int  0 0 0 0 1 1 0 2 0 0 ...
# $ sexy        : int  0 0 0 0 0 0 0 1 0 0 ...
# $ hot         : int  0 0 0 0 0 0 0 0 0 1 ...
# $ kissed      : int  0 0 0 0 5 0 0 0 0 0 ...
# $ dance       : int  1 0 0 0 1 0 0 0 0 0 ...
# $ band        : int  0 0 2 0 1 0 1 0 0 0 ...
# $ marching    : int  0 0 0 0 0 1 1 0 0 0 ...
# $ music       : int  0 2 1 0 3 2 0 1 0 1 ...
# $ rock        : int  0 2 0 1 0 0 0 1 0 1 ...
# $ god         : int  0 1 0 0 1 0 0 0 0 6 ...
# $ church      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ jesus       : int  0 0 0 0 0 0 0 0 0 2 ...
# $ bible       : int  0 0 0 0 0 0 0 0 0 0 ...
# $ hair        : int  0 6 0 0 1 0 0 0 0 1 ...
# $ dress       : int  0 4 0 0 0 1 0 0 0 0 ...
# $ blonde      : int  0 0 0 0 0 0 0 0 0 0 ...
# $ mall        : int  0 1 0 0 0 0 2 0 0 0 ...
# $ shopping    : int  0 0 0 0 2 1 0 0 0 1 ...
# $ clothes     : int  0 0 0 0 0 0 0 0 0 0 ...
# $ hollister   : int  0 0 0 0 0 0 2 0 0 0 ...
# $ abercrombie : int  0 0 0 0 0 0 0 0 0 0 ...
# $ die         : int  0 0 0 0 0 0 0 0 0 0 ...
# $ death       : int  0 0 1 0 0 0 0 0 0 0 ...
# $ drunk       : int  0 0 0 0 1 1 0 0 0 0 ...
# $ drugs       : int  0 0 0 0 1 0 0 0 0 0 ...

table(teens$gender)
F      M
22054 5222

Although this command tells us how many F and M values are present, the table()
function excluded the NA values rather than treating it as a separate category. 
To include the NA values (if there are any), we simply need to add an additional 
parameter:

   table(teens$gender, useNA = "ifany")

F      M     <NA> 
22054  5222  2724 

Here, we see that 2,724 records (9 percent) have missing gender data. 
Interestingly, there are over four times as many females as males in the SNS 
data, suggesting that males are not as inclined to use SNS websites as females.

Data preparation – dummy coding missing values
An easy solution for handling the missing values is to exclude any record with 
a missing value. However, if you think through the implications of this practice, 
you might think twice before doing so—just because it is easy does not mean it is 
a good idea! The problem with this approach is that even if the missingness is 
not extensive, you can easily exclude large portions of the data.

An alternative solution for categorical variables like gender is to treat a missing
value as a separate category. For instance, rather than limiting to female and male,
we can add an additional category for the unknown gender.

dummy coding involves creating a separate binary (1 or 0) valued
dummy variable for each level of a nominal feature except one, which is held 
out to serve as the reference group. The reason one category can be excluded is 
because its status can be inferred from the other categories. For instance, if 
someone is not female and not unknown gender, they must be male. Therefore, in 
this case, we need to only create dummy variables for female and unknown gender:
  teens$female <- ifelse(teens$gender == "F" &
                             !is.na(teens$gender), 1, 0)
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)
As you might expect, the is.na() function tests whether gender is equal to NA.
Therefore, the first statement assigns teens$female the value 1 if gender 
is equal to F and the gender is not equal to NA ; otherwise, it assigns the 
value 0 . In the second statement, if is.na() returns TRUE , meaning the gender 
is missing, the teens$no_gender variable is assigned 1 ; otherwise, it is assigned 
the value 0 .
To confirm that we did the work correctly, let''s compare our constructed dummy
variables to the original gender variable:
table(teens$gender, useNA = "ifany")
# F      M    <NA>
# 22054 5222 2724

table(teens$female, useNA = "ifany")
# 0     1
# 7946 22054

table(teens$no_gender, useNA = "ifany")
# 0      1
# 27276 2724

Data preparation – imputing the missing values
Next, let''s eliminate the 5,523 missing age values. As age is numeric, it 
doesn''t make sense to create an additional category for the unknown values—where 
would you rank "unknown" relative to the other ages? Instead, we''ll use a 
different  strategy known as imputation, which involves filling in the missing 
data with a guess as to the true value.

mean(teens$age, na.rm = TRUE)
# [1] 17.25243
This reveals that the average student in our data is about 17 years old. This 
only gets us part of the way there; we actually need the average age for each 
graduation year. You might be tempted to calculate the mean four times, but one 
of the benefits of R is that there''s usually a way to avoid repeating oneself. 
In this case, the aggregate() function is the tool for the job. It computes 
statistics for subgroups of data. Here, it calculates the mean age by graduation 
year after removing the NA values:
  
aggregate(data = teens, age ~ gradyear, mean, na.rm = TRUE)
# gradyear age
# 1 2006 18.65586
# 2 2007 17.70617
# 3 2008 16.76770
# 4 2009 15.81957

The mean age differs by roughly one year per change in graduation year. This 
is not at all surprising, but a helpful finding for confirming our data is 
reasonable. The aggregate() output is a data frame. This is helpful for some 
purposes, but would require extra work to merge back onto our original data. 

As an alternative, we can use the ave() function, which returns a vector 
with the group means repeated so that the result is equal in length to 
the original vector:
  ave_age <- ave(teens$age, teens$gradyear, FUN =
                     function(x) mean(x, na.rm = TRUE))

To impute these means onto the missing values, we need one more ifelse() 
call to use the ave_age value only if the original age value was NA :
  teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

Step 3 – training a model on the data
To cluster the teenagers into marketing segments, we will use an implementation of
k-means in the stats package, which is in R installation by
default.

interests <- teens[5:40]

The process of z-score standardization rescales features so that they have a mean of
zero and a standard deviation of one.

interests_z <- as.data.frame(lapply(interests, scale))

set.seed(2345)
teen_clusters <- kmeans(interests_z, 5)

The result of the k-means clustering process is a list named teen_clusters that
stores the properties of each of the five clusters.

Step 4 – evaluating model performance
One of the most basic ways to evaluate the utility of a set of clusters is 
to examine the number of examples falling in each of the groups. If the 
groups  are too large or too small, they are not likely to be very useful. 
To obtain the  size of the kmeans() clusters, use the teen_clusters$size 
component as follows:
teen_clusters$size
871  600  5981  1034  21514

Here, we see the five clusters we requested. The smallest cluster has 600 
teenagers (2 percent) while the largest cluster has 21,514 (72 percent). 
Although the large gap between the number of people in the largest and smallest 
clusters is slightly concerning, without examining these groups more carefully, 
we will not know whether or not this indicates a problem. It may be the 
case that the clusters'' size
disparity indicates something real, such as a big group of teens that 
share similar interests, or it may be a random fluke caused by the initial 
k-means cluster centers. We''ll know more as we start to look at each 
cluster''s homogeneity.

teen_clusters$centers

# basketball   football      soccer    softball  volleyball    swimming cheerleading
# 1  0.16001227  0.2364174  0.10385512  0.07232021  0.18897158  0.23970234    0.3931445
# 2 -0.09195886  0.0652625 -0.09932124 -0.01739428 -0.06219308  0.03339844   -0.1101103
# 3  0.52755083  0.4873480  0.29778605  0.37178877  0.37986175  0.29628671    0.3303485
# 4  0.34081039  0.3593965  0.12722250  0.16384661  0.11032200  0.26943332    0.1856664
# 5 -0.16695523 -0.1641499 -0.09033520 -0.11367669 -0.11682181 -0.10595448   -0.1136077
# baseball      tennis      sports        cute          sex        sexy         hot
# 1  0.02993479  0.13532387  0.10257837  0.37884271  0.020042068  0.11740551  0.41389104
# 2 -0.11487510  0.04062204 -0.09899231 -0.03265037 -0.042486141 -0.04329091 -0.03812345
# 3  0.35231971  0.14057808  0.32967130  0.54442929  0.002913623  0.24040196  0.38551819
# 4  0.27527088  0.10980958  0.79711920  0.47866008  2.028471066  0.51266080  0.31708549
# 5 -0.10918483 -0.05097057 -0.13135334 -0.18878627 -0.097928345 -0.09501817 -0.13810894
# kissed       dance        band    marching      music        rock         god
# 1  0.06787768  0.22780899 -0.10257102 -0.10942590  0.1378306  0.05905951  0.03651755
# 2 -0.04554933  0.04573186  4.06726666  5.25757242  0.4981238  0.15963917  0.09283620
# 3 -0.03356121  0.45662534 -0.02120728 -0.10880541  0.2844999  0.21436936  0.35014919
# 4  2.97973077  0.45535061  0.38053621 -0.02014608  1.1367885  1.21013948  0.41679142
# 5 -0.13535855 -0.15932739 -0.12167214 -0.11098063 -0.1532006 -0.12460034 -0.12144246
# church       jesus       bible        hair       dress      blonde        mall
# 1 -0.00709374  0.01458533 -0.03692278  0.43807926  0.14905267  0.06137340  0.60368108
# 2  0.06414651  0.04801941  0.05863810 -0.04484083  0.07201611 -0.01146396 -0.08724304
# 3  0.53739806  0.27843424  0.22990963  0.23612853  0.39407628  0.03471458  0.48318495
# 4  0.16627797  0.12988313  0.08478769  2.55623737  0.53852195  0.36134138  0.62256686
# 5 -0.15889274 -0.08557822 -0.06813159 -0.20498730 -0.14348036 -0.02918252 -0.18625656
# shopping       clothes  hollister abercrombie          die       death        drunk
# 1  0.79806891  0.5651537331  4.1521844  3.96493810  0.043475966  0.09857501  0.035614771
# 2 -0.03865318 -0.0003526292 -0.1678300 -0.14129577  0.009447317  0.05135888 -0.086773220
# 3  0.66327838  0.3759725120 -0.0553846 -0.07417839  0.037989066  0.11972190 -0.009688746
# 4  0.27101815  1.2306917174  0.1610784  0.26324494  1.712181870  0.93631312  1.897388200
# 5 -0.22865236 -0.1865419798 -0.1557662 -0.14861104 -0.094875180 -0.08370729 -0.087520105
# drugs
# 1  0.03443294
# 2 -0.06878491
# 3 -0.05973769
# 4  2.73326605
# 5 -0.11423381

The rows of the output (labeled 1 to 5 ) refer to the five clusters, 
while the numbers across each row indicate the cluster''s average value 
for  the interest listed at the top of the column. As the values are 
z-score  standardized, positive values are above the overall mean level 
for all the  teens and negative values are below the overall mean. For 
example, the third  row has the highest value in the basketball column, 
which means that cluster  3 has the highest average interest in basketball 
among all the clusters.

Given this subset of the interest data, we can already infer some 
characteristics of the clusters. Cluster 3 is substantially above the mean 
interest level on all the sports. This suggests that this may be a group 
of Athletes per The Breakfast Club stereotype.
Cluster 1 includes the most mentions of "cheerleading," the word "hot," 
and is above the average level of football interest. Are these the 
so-called Princesses?
  
1 cheerleading, hot, shopping, hollister, abercrombie (Princesses)
2 marching, band, rock, music (brains)
3 basketball, football, soccer, softball, volleyball, swimming, baseball, 
tennis, sports, cute, dance, church, jesus, bible, dress (athletes)
4 sex, sexy, kissed, music, rock, hair, blonde, mall, clothes,
die, death, drunk, drugs (criminals)
5 ?? (rest)
  
  Given the table, a marketing executive would have a clear depiction of 
five types of teenage visitors to the social networking website. Based on 
these profiles, the executive could sell targeted advertising impressions 
to businesses with products relevant to one or more of the clusters.


