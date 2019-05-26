install.packages('imager')
library(imager)


# file <- system.file('extdata/parrots.png',package='imager')
#system.file gives the full path for a file that ships with a R package
#if you already have the full path to the file you want to load just run:
im <- load.image("./R-itv/data/rose.jpg")
# im <- load.image(file)

plot(im) #Rose!

show_image <- function(path) {
  im <- load.image(path)
  plot(im)
}

Decision Trees
Trees and rules "greedily" partition data into interesting segments
The most common decision tree and classification rule learners, 
including the C5.0, 1R, and RIPPER algorithms.

To better understand how this works in practice, let''s consider the 
following tree, which predicts whether a job offer should be accepted. A 
job offer to be considered begins at the root node, where it is then passed 
through decision nodes that require choices to be made based on the 
attributes of the job. These choices split the data across branches that 
indicate potential outcomes of a decision, depicted here as yes or no 
outcomes, though in some cases there may be more than two possibilities.
In the case a final decision can be made, the tree is terminated by 
leaf nodes (also known as terminal nodes) that denote the action to be 
taken as the result of the series of decisions. In the case of a predictive 
model, the leaf nodes provide the expected result given the series of 
events in the tree.

show_image('./R-itv/data/dt.jpg')

Decision trees are built using a heuristic called recursive partitioning. 
This approach is also commonly known as divide and conquer because it splits 
the data into subsets, which are then split repeatedly into even smaller 
subsets, and so on and so forth until the process stops when the algorithm 
determines the data within the subsets are sufficiently homogenous, or 
another stopping criterion has been met. To see how splitting a dataset can 
create a decision tree, imagine a bare root node that will grow into a 
mature tree. At first, the root node represents the entire dataset, since no 
splitting has transpired. Next, the decision tree algorithm must choose a
feature to split upon; ideally, it chooses the feature most predictive of 
the target class.
The examples are then partitioned into groups according to the distinct 
values of this feature, and the first set of tree branches are formed.

Working down each branch, the algorithm continues to divide and conquer 
the data, choosing the best candidate feature each time to create another 
decision node, until a stopping criterion is reached. Divide and conquer 
might stop at a node in a case that:
• All (or nearly all) of the examples at the node have the same class
• There are no remaining features to distinguish among the examples
• The tree has grown to a predefined size limit
To illustrate the tree building process, let''s consider a simple 
example. Imagine that you work for a Hollywood studio, where your role 
is to decide whether the studio should move forward with producing the 
screenplays pitched by promising new authors. After returning from a 
vacation, your desk is piled high with proposals. Without the time to read 
each proposal cover-to-cover, you decide to develop a decision tree 
algorithm to predict whether a potential movie would fall into one of
three categories: Critical Success, Mainstream Hit, or Box Office Bust.

To build the decision tree, you turn to the studio archives to examine 
the factors leading to the success and failure of the company''s 30 most 
recent releases. Youquickly notice a relationship between the film''s 
estimated shooting budget, the number of A-list celebrities lined up 
for starring roles, and the level of success.
Excited about this finding, you produce a scatterplot to illustrate 
the pattern:
  
show_image('./R-itv/data/dt_ex1.jpg')

Using the divide and conquer strategy, we can build a simple decision tree
from this data. First, to create the tree''s root node, we split the 
feature indicating the number of celebrities, partitioning the movies into
groups with and without a significant number of A-list stars:
  
show_image('./R-itv/data/dt_ex2.jpg')

Next, among the group of movies with a larger number of celebrities, 
we can make another split between movies with and without a high budget

show_image('./R-itv/data/dt_ex3.jpg')

At this point, we have partitioned the data into three groups. The 
group at the top-left corner of the diagram is composed entirely of 
critically acclaimed films. This group is distinguished by a high number of 
celebrities and a relatively low budget. At the top-right corner, majority 
of movies are box office hits with high budgets and a large number of 
celebrities. The final group, which has little star power but budgets 
ranging from small to large, contains the flops.

show_image('./R-itv/data/dt_ex4.jpg')

There are numerous implementations of decision trees, but one of the 
most well-known implementations is the C5.0 algorithm. This algorithm was 
developed by computer scientist J. Ross Quinlan as an improved version 
of his prior algorithm, C4.5, which itself is an improvement over his 
Iterative Dichotomiser 3 (ID3) algorithm. Although Quinlan markets C5.0 
to commercial clients (see http://www.rulequest.com/ for details), the 
source code for a single-threaded version of the
algorithm was made publically available, and it has therefore been 
incorporated into programs such as R.

Choosing the best split
The first challenge that a decision tree will face is to identify which 
feature to split upon. In the previous example, we looked for a way to 
split the data such that the resulting partitions contained examples 
primarily of a single class. The degree to which a subset of examples 
contains only a single class is known as purity, and any subset composed 
of only a single class is called pure.
There are various measurements of purity that can be used to identify 
the best decision tree splitting candidate. C5.0 uses entropy, a concept 
borrowed from information theory that quantifies the randomness, or 
disorder, within a set of class values. Sets with high entropy are very 
diverse and provide little information about other items that may also 
belong in the set, as there is no apparent commonality.
The decision tree hopes to find splits that reduce entropy, ultimately 
increasing homogeneity within the groups.
Typically, entropy is measured in bits. If there are only two possible 
classes, entropy values can range from 0 to 1. For n classes, entropy 
ranges from 0 to log 2 (n). In eachcase, the minimum value indicates 
that the sample is completely homogenous, while the maximum value 
indicates that the data are as diverse as possible, and no group has 
even a small plurality.
In the mathematical notion, entropy is specified as follows:
  show_image('./R-itv/data/dt_ex5.jpg')

In this formula, for a given segment of data (S), the term c refers to 
the number of class levels and p i refers to the proportion of values 
falling into class level i. For example, suppose we have a partition of 
data with two classes: red (60 percent) and white (40 percent). We can 
calculate the entropy as follows:
-0.60 * log2(0.60) - 0.40 * log2(0.40)
# [1] 0.970950

To use entropy to determine the optimal feature to split upon, the 
algorithm calculates the change in homogeneity that would result from a 
split on each possible feature, which is a measure known as information 
gain. The information gain for a feature F is calculated as the 
difference  between the entropy in the segment before the split (S 1 ) 
and the partitions resulting from the split (S 2 ):
  show_image('./R-itv/data/dt_ex6.jpg')

In simple terms, the total entropy resulting from a split is the sum of 
the entropy of each of the n partitions weighted by the proportion of 
examples falling in the partition (w i ).

show_image('./R-itv/data/dt_ex7.jpg')

The higher the information gain, the better a feature is at creating 
homogeneous groups after a split on this feature. If the information gain 
is zero, there is no reduction in entropy for splitting on this feature. 
On the other hand, the maximum information gain is equal to the entropy 
prior to the split. This would imply that the entropy after the split is 
zero, which means that the split results in completely homogeneous groups.

What makes trees and rules greedy?
  Decision trees and rule learners are known as greedy learners because 
they use data on a first-come, first-served basis. Both the divide and 
conquer heuristic used by decision trees and the separate and conquer 
heuristic used by rule learners attempt to make partitions one at a time, 
finding the most homogeneous partition first, followed by the next best, 
and so on, until all examples have been classified.

Example – estimating the quality of wines with regression trees and 
model trees
Winemaking is a challenging and competitive business that offers 
the potential for great profit. However, there are numerous factors that 
contribute to the profitability of a winery. As an agricultural product, 
variables as diverse as the weather and the growing environment impact 
the quality of a varietal. The bottling and manufacturing can also 
affect the flavor for better or worse. Even the way the product is 
marketed, from the bottle design to the price point, can affect the
customer''s perception of taste.

Step 2 – exploring and preparing the data
As usual, we will use the read.csv() function to load the data into R. 
Since all of the features are numeric, we can safely ignore the 
stringsAsFactors parameter:
wine <- read.csv("./R-itv/data/whitewines.csv")

The wine data includes 11 features and the quality outcome, as follows:
str(wine)
# 'data.frame':	4898 obs. of  12 variables:
#   $ fixed.acidity       : num  7 6.3 8.1 7.2 7.2 8.1 6.2 7 6.3 8.1 ...
# $ volatile.acidity    : num  0.27 0.3 0.28 0.23 0.23 0.28 0.32 0.27 0.3 0.22 ...
# $ citric.acid         : num  0.36 0.34 0.4 0.32 0.32 0.4 0.16 0.36 0.34 0.43 ...
# $ residual.sugar      : num  20.7 1.6 6.9 8.5 8.5 6.9 7 20.7 1.6 1.5 ...
# $ chlorides           : num  0.045 0.049 0.05 0.058 0.058 0.05 0.045 0.045 0.049 0.044 ...
# $ free.sulfur.dioxide : num  45 14 30 47 47 30 30 45 14 28 ...
# $ total.sulfur.dioxide: num  170 132 97 186 186 97 136 170 132 129 ...
# $ density             : num  1.001 0.994 0.995 0.996 0.996 ...
# $ pH                  : num  3 3.3 3.26 3.19 3.19 3.26 3.18 3 3.3 3.22 ...
# $ sulphates           : num  0.45 0.49 0.44 0.4 0.4 0.44 0.47 0.45 0.49 0.45 ...
# $ alcohol             : num  8.8 9.5 10.1 9.9 9.9 10.1 9.6 8.8 9.5 11 ...
# $ quality             : int  6 6 6 6 6 6 6 6 6 6 ...

Compared with other types of machine learning models, one of the 
advantages of trees is that they can handle many types of data without 
preprocessing. This means we do not need to normalize or standardize 
the features. However, a bit of effort to examine the distribution of 
the outcome variable is needed to inform our evaluation of the model''s 
performance. For instance, suppose that there was a very little variation 
in quality from wine-to-wine, or that wines fell into a bimodal distribution: 
either very good or very bad. To check for such extremes, we can examine 
the distribution of quality using a histogram:

hist(wine$quality)

The wine quality values appear to follow a fairly normal, bell-shaped 
distribution, centered around a value of six. This makes sense 
intuitively because most wines are of average quality; few are 
particularly bad or good. Although the results are not shown here, it 
is also useful to examine the summary(wine) output for outliers or 
other potential data problems. Even though trees are fairly robust 
with messy data, it is always prudent to check for severe problems. 
For now, we''ll assume that the data is reliable.
Our last step then is to divide into training and testing datasets. 
Since the wine data set was already sorted into random order, we can 
partition into two sets of contiguous rows as follows:
  
wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]

Step 3 – training a model on the data
We will begin by training a regression tree model. Although almost 
any implementation of decision trees can be used to perform regression 
tree modeling, the rpart (recursive partitioning) package offers the 
most faithful implementation of regression trees as they were described 
by the CART team. As the classic R implementation of CART, the rpart 
package is also well-documented and supported with functions for 
visualizing and evaluating the rpart models.

install.packages('rpart')

Using the R formula interface, we can specify quality as the outcome 
variable and use the dot notation to allow all the other columns in 
the wine_train data frame to be used as predictors. The resulting 
regression tree model object is named m.rpart to distinguish it from 
the model tree that we will train later:
library(rpart)
m.rpart <- rpart(quality ~ ., data = wine_train)

install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(m.rpart, digits = 3)

m.rpart
# n= 3750 
# 
# node), split, n, deviance, yval
# * denotes terminal node
# 1) root 3750 3140.06000 5.886933  
# 2) alcohol< 10.85 2473 1510.66200 5.609381  
# 4) volatile.acidity>=0.2425 1406  740.15080 5.402560  
# 8) volatile.acidity>=0.4225 182   92.99451 4.994505 *
#   9) volatile.acidity< 0.4225 1224  612.34560 5.463235 *
#   5) volatile.acidity< 0.2425 1067  631.12090 5.881912 *
#   3) alcohol>=10.85 1277 1069.95800 6.424432  
# 6) free.sulfur.dioxide< 11.5 93   99.18280 5.473118 *
#   7) free.sulfur.dioxide>=11.5 1184  879.99920 6.499155  
# 14) alcohol< 11.85 611  447.38130 6.296236 *
#   15) alcohol>=11.85 573  380.63180 6.715532 *

For each node in the tree, the number of examples reaching the 
decision point is listed. For instance, all 3,750 examples begin at 
the root node, of which 2,372 have alcohol < 10.85 and 1,378 have 
alcohol >= 10.85 . Because alcohol was used first in the tree, it is 
the single most important predictor of wine quality.
Nodes indicated by * are terminal or leaf nodes, which means that they 
result in a prediction (listed here as yval ). For example, node 5 has 
a yval of 5.881912 When the tree is used for predictions, any wine 
samples with alcohol < 10.85 and volatile.acidity < 0.2425 would therefore 
be predicted to have a quality value of 5.88.
A more detailed summary of the tree''s fit, including the mean squared 
error for each of the nodes and an overall measure of feature importance, 
can be obtained using the summary(m.rpart) command.

Step 4 – evaluating model performance
To use the regression tree model to make predictions on the test data, 
we use the predict() function. By default, this returns the estimated 
numeric value for the outcome variable, which we''ll save in a vector 
named p.rpart :
p.rpart <- predict(m.rpart, wine_test)

cor(p.rpart, wine_test$quality)
# [1] 0.4931608
A correlation of 0.49 is certainly acceptable. However, the correlation 
only measures how strongly the predictions are related to the true value; 
it is not a measure of how far off the predictions were from the true 
values.

Measuring performance with the mean
absolute error
Another way to think about the model''s performance is to consider how 
far, on average, its prediction was from the true value. This measurement
is called the mean absolute error (MAE). The equation for MAE is as follows, 
where n indicates the number of predictions and e i indicates the error for 
prediction i:

MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}
The MAE for our predictions is then:
MAE(p.rpart, wine_test$quality)
# [1] 0.5732104

