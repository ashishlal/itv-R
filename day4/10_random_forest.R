library(imager)

show_image <- function(path) {
  im <- load.image(path)
  plot(im)
}

Though there are several packages to create random forests in R, the 
randomForest package is perhaps the implementation that is most faithful 
to the specification by Breiman and Cutler, and is also supported by 
caret for automated tuning.

show_image('./R-itv/data/rf_ex1.jpg')

By default, the randomForest() function creates an ensemble of 500 trees 
that consider sqrt(p) random features at each split, where p is the 
number of features in the training dataset and sqrt() refers to R''s 
square root function. Whether or not these default parameters are 
appropriate depends on the nature of the learning task and training data. 
Generally, more complex learning problems and larger datasets (either 
more features or more examples) work better with a larger number of 
trees, though this needs to be balanced with the computational expense 
of training more trees.
The goal of using a large number of trees is to train enough so that 
each feature has a chance to appear in several models. This is the basis 
of the sqrt(p) default value for the mtry parameter; using this value 
limits the features sufficiently so that substantial random variation 
occurs from tree-to-tree. For example, since the wine data has 11 
features, each tree would be limited to splitting on 3 features 
at any time.

wine <- read.csv("./R-itv/data/whitewines.csv")

The wine data includes 11 features and the quality outcome, as follows:
str(wine)

install.packages('randomForest')
wine$taste <- ifelse(wine$quality < 6, 'bad', 'good')
wine$taste[wine$quality == 6] <- 'normal'
wine$taste <- as.factor(wine$taste)
levels(wine$taste) = c(0,1,2)
wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]
library(randomForest)
set.seed(300)

rf <- randomForest(taste ~ ., data = wine_train)
rf
# Call:
#   randomForest(formula = taste ~ ., data = wine_train, ntree = 500) 
# Type of random forest: classification
# Number of trees: 500
# No. of variables tried at each split: 3
# 
# OOB estimate of  error rate: 0%
# Confusion matrix:
#   bad good normal class.error
# bad    1280    0      0           0
# good      0  863      0           0
# normal    0    0   1607           0

p <- predict(rf, wine_test, type ='class')

table(p, wine_test$taste)
# p     0   1   2
# 0 360   0   0
# 1   0 197   0
# 2   0   0 591
accuracy = (360 + 197 + 591) / nrow(wine_test)
accuracy

Let us try this as a regression problem

wine <- read.csv("./R-itv/data/whitewines.csv")

The wine data includes 11 features and the quality outcome, as follows:
  str(wine)


wine_train <- wine[1:3750, ]
wine_test <- wine[3751:4898, ]
library(randomForest)
set.seed(300)

rf <- randomForest(quality ~ ., data = wine_train)
# rf
# 
# Call:
#   randomForest(formula = quality ~ ., data = wine_train) 
# Type of random forest: regression
# Number of trees: 500
# No. of variables tried at each split: 3
# 
# Mean of squared residuals: 0.3691225
# % Var explained: 55.92

p <- predict(rf, wine_test, type ='response')
MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}
The MAE for our predictions is then:
 
MAE(p, wine_test$quality)
# [1] 0.5181395

Lower error than with rpart

Using caret package

We must first load caret and set our training control options. For the 
most accurate comparison of model performance, we''ll use repeated 10-fold 
cross-validation, or 10-fold CV repeated 10 times. This means that the 
models will take a much longer time to build and will be more computationally 
intensive to evaluate, but since this is our final comparison we should be 
very sure that we''re making the right choice

install.packages('caret', dependencies = TRUE)
library(caret)
ctrl <- trainControl(method = "repeatedcv",number = 10, repeats = 10)

