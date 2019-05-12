Understanding nearest neighbor classification
In a single sentence, nearest neighbor classifiers are defined by their 
characteristic of classifying unlabeled examples by assigning them the class 
of similar labeled examples. Despite the simplicity of this idea, nearest 
neighbor methods are extremely powerful.

In general, nearest neighbor classifiers are well-suited for classification 
tasks, where relationships among the features and the target classes are 
numerous, complicated, or extremely difficult to understand, yet the items of 
similar class type tend to be fairly homogeneous

The k-NN algorithm gets its name from the fact that it uses information about
an examples k-nearest neighbors to classify unlabeled examples. The letter 
k is a variable term implying that any number of nearest neighbors could be 
used. After choosing k, the algorithm requires a training dataset made up of 
examples that have been classified into several categories, as labeled by a nominal 
variable. Then, for each unlabeled record in the test dataset, k-NN identifies k 
records in the training data that are the "nearest" in similarity. The unlabeled 
test instance is assigned the class of the majority of the k nearest neighbors.

Let us revisit the blind tasting experience described in
the introduction. Suppose that prior to eating the mystery meal we had created a
dataset in which we recorded our impressions of a number of ingredients we tasted
previously. To keep things simple, we rated only two features of each ingredient.
The first is a measure from 1 to 10 of how crunchy the ingredient is and the 
second is a 1 to 10 score of how sweet the ingredient tastes. We then labeled 
each ingredient as one of the three types of food: fruits, vegetables, or proteins. 
The first few rows of such a dataset might be structured as follows:
Ingredient Sweetness Crunchiness Food type
apple      10         9           fruit
bacon      1          4           protein
banana     10         1           fruit
carrot     7          10          vegetable
celery     3          10          vegetable
cheese     1          1           protein

The k-NN algorithm treats the features as coordinates in a multidimensional
feature space. As our dataset includes only two features, the feature space is
two-dimensional. We can plot two-dimensional data on a scatter plot, with the
x dimension indicating the ingredient''s sweetness and the y dimension, the
crunchiness.

Sweetness = c(10,1,10,7,3,1)
Crunchiness = c(9,4,1,10,10,1)
Ingredient = c('apple', 'bacon', 'banana', 'carrot', 'celery', 'cheese')
FoodType = c('fruit', 'protein','fruit','vegetable','vegetable','protein')
df = data.frame(I=Ingredient,S=Sweetness,C=Crunchiness,F=FoodType)
# with(df, text(S~C,labels=I))
plot(Sweetness, Crunchiness, 
     main= "Sweetness vs. Crunchiness",
     xlab= "Sweetness (relative, from 1 to 10)",
     ylab= "Crunchiness relative (from1 to 10)",
     col= "blue", pch = 19, cex = 1, lty = "solid", lwd = 2)

text(Sweetness, Crunchiness, labels=Ingredient, cex=0.8)

See that proteins, fruits and vegetables are grouped together.

Suppose that after constructing this dataset, we decide to use it to settle the age-old
question: is tomato a fruit or vegetable? We can use the nearest neighbor approach to
determine which class is a better fit

Measuring similarity with distance
Locating the tomato''s nearest neighbors requires a distance function, or a 
formula that measures the similarity between the two instances.
There are many different ways to calculate distance. Traditionally, the k-NN
algorithm uses Euclidean distance, which is the distance one would measure if
it were possible to use a ruler to connect two points.

Euclidean distance is measured "as the crow flies," implying the
shortest direct route. Another common distance measure is Manhattan
distance, which is based on the paths a pedestrian would take by
walking city blocks. If you are interested in learning more about other
distance measures, you can read the documentation for R''s distance
function (a useful tool in its own right), using the ?dist command.

Euclidean distance is specified by the following formula, where p and q are the
examples to be compared, each having n features. The term p 1 refers to the value
of the first feature of example p, while q 1 refers to the value of the first 
feature of example q:
Euclidean dist = sqrt((p1-q1)^2 + .... + (pn-qn)^2)

The distance formula involves comparing the values of each feature. For example,
to calculate the distance between the tomato (sweetness = 6, crunchiness = 4), and
the green bean (sweetness = 3, crunchiness = 7), we can use the formula as follows:
In a similar vein, we can calculate the distance between the tomato and several of its
closest neighbors as follows:

  Say tomato sweetness is 6 and Crunchiness is 4.

Ingredient Sweetness Crunchiness Food type Distance to the tomato
grape      8          5            fruit     sqrt((6 - 8)^2 + (4 - 5)^2) = 2.2
green bean 3          7            vegetable sqrt((6 - 3)^2 + (4 - 7)^2) = 4.2
nuts       3          6            protein   sqrt((6 - 3)^2 + (4 - 6)^2) = 3.6
orange     7          3            fruit     sqrt((6 - 7)^2 + (4 - 3)^2) = 1.4

To classify the tomato as a vegetable, protein, or fruit, we will begin by 
assigning the tomato, the food type of its single nearest neighbor. This is called 
1-NN classification because k = 1. The orange is the nearest neighbor to the 
tomato, with a distance of 1.4. As orange is a fruit, the 1-NN algorithm would 
classify tomato as a fruit. If we use the k-NN algorithm with k = 3 instead, it 
performs a vote among the three nearest neighbors: orange, grape, and nuts. Since 
the majority class among these neighbors is fruit (two of the three votes), the 
tomato again is classified as a fruit.

Choosing an appropriate k
The decision of how many neighbors to use for k-NN determines how well
the model will generalize to future data. The balance between overfitting and
underfitting the training data is a problem known as bias-variance tradeoff.
Choosing a large k reduces the impact or variance caused by noisy data, but can
bias the learner so that it runs the risk of ignoring small, but important 
patterns.

In practice, choosing k depends on the difficulty of the concept to be learned, and
the number of records in the training data. One common practice is to begin with k
equal to the square root of the number of training examples. In the food classifier we
developed previously, we might set k = 4 because there were 15 example ingredients
in the training data and the square root of 15 is 3.87.
However, such rules may not always result in the single best k. An alternative
approach is to test several k values on a variety of test datasets and choose the
one that delivers the best classification performance. That said, unless the data is
very noisy, a large training dataset can make the choice of k less important. This is
because even subtle concepts will have a sufficiently large pool of examples to vote
as nearest neighbors.

Example – diagnosing breast cancer with the k-NN algorithm
Routine breast cancer screening allows the disease to be diagnosed and treated prior
to it causing noticeable symptoms. The process of early detection involves examining
the breast tissue for abnormal lumps or masses. If a lump is found, a fine-needle
aspiration biopsy is performed, which uses a hollow needle to extract a small sample
of cells from the mass. A clinician then examines the cells under a microscope to
determine whether the mass is likely to be malignant or benign.

If machine learning could automate the identification of cancerous cells, it would
provide considerable benefit to the health system. Automated processes are likely
to improve the efficiency of the detection process, allowing physicians to spend less
time diagnosing and more time treating the disease. An automated screening system
might also provide greater detection accuracy by removing the inherently subjective
human component from the process.

We will investigate the utility of machine learning for detecting cancer by applying
the k-NN algorithm to measurements of biopsied cells from women with abnormal
breast masses.

Step 1 – collecting data
We will utilize the Wisconsin Breast Cancer Diagnostic dataset from the UCI
Machine Learning Repository at http://archive.ics.uci.edu/ml . This data
was donated by researchers of the University of Wisconsin and includes the
measurements from digitized images of fine-needle aspirate of a breast mass. The
values represent the characteristics of the cell nuclei present in the digital image.

The breast cancer data includes 569 examples of cancer biopsies, each with
32 features. One feature is an identification number, another is the cancer 
diagnosis, and 30 are numeric-valued laboratory measurements. The diagnosis is 
coded as "M" to indicate malignant or "B" to indicate benign.
The other 30 numeric measurements comprise the mean, standard error, and worst
(that is, largest) value for 10 different characteristics of the digitized cell 
nuclei.
These include:
• Radius
• Texture
• Perimeter
• Area
• Smoothness
• Compactness
• Concavity
• Concave points
• Symmetry
• Fractal dimension

Based on these names, all the features seem to relate to the shape and size of the cell
nuclei. Unless you are an oncologist, you are unlikely to know how each relates to
benign or malignant masses. These patterns will be revealed as we continue in the
machine learning process.

Step 2 – exploring and preparing the data
Let''s explore the data and see whether we can shine some light on the relationships.
In doing so, we will prepare the data for use with the k-NN learning method.

We''ll begin by importing the CSV data file, as we have done in previous chapters,
saving the Wisconsin breast cancer data to the wbcd data frame:
wbcd <- read.csv("./data/wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)

# 'data.frame':	569 obs. of  32 variables:
#   $ id                     : int  842302 842517 84300903 84348301 84358402 843786 844359 84458202 844981 84501001 ...
# $ diagnosis              : chr  "M" "M" "M" "M" ...
# $ radius_mean            : num  18 20.6 19.7 11.4 20.3 ...
# $ texture_mean           : num  10.4 17.8 21.2 20.4 14.3 ...
# $ perimeter_mean         : num  122.8 132.9 130 77.6 135.1 ...
# $ area_mean              : num  1001 1326 1203 386 1297 ...
# $ smoothness_mean        : num  0.1184 0.0847 0.1096 0.1425 0.1003 ...
# $ compactness_mean       : num  0.2776 0.0786 0.1599 0.2839 0.1328 ...
# $ concavity_mean         : num  0.3001 0.0869 0.1974 0.2414 0.198 ...
# $ concave.points_mean    : num  0.1471 0.0702 0.1279 0.1052 0.1043 ...
# $ symmetry_mean          : num  0.242 0.181 0.207 0.26 0.181 ...
# $ fractal_dimension_mean : num  0.0787 0.0567 0.06 0.0974 0.0588 ...
# $ radius_se              : num  1.095 0.543 0.746 0.496 0.757 ...
# $ texture_se             : num  0.905 0.734 0.787 1.156 0.781 ...
# $ perimeter_se           : num  8.59 3.4 4.58 3.44 5.44 ...
# $ area_se                : num  153.4 74.1 94 27.2 94.4 ...
# $ smoothness_se          : num  0.0064 0.00522 0.00615 0.00911 0.01149 ...
# $ compactness_se         : num  0.049 0.0131 0.0401 0.0746 0.0246 ...
# $ concavity_se           : num  0.0537 0.0186 0.0383 0.0566 0.0569 ...
# $ concave.points_se      : num  0.0159 0.0134 0.0206 0.0187 0.0188 ...
# $ symmetry_se            : num  0.03 0.0139 0.0225 0.0596 0.0176 ...
# $ fractal_dimension_se   : num  0.00619 0.00353 0.00457 0.00921 0.00511 ...
# $ radius_worst           : num  25.4 25 23.6 14.9 22.5 ...
# $ texture_worst          : num  17.3 23.4 25.5 26.5 16.7 ...
# $ perimeter_worst        : num  184.6 158.8 152.5 98.9 152.2 ...
# $ area_worst             : num  2019 1956 1709 568 1575 ...
# $ smoothness_worst       : num  0.162 0.124 0.144 0.21 0.137 ...
# $ compactness_worst      : num  0.666 0.187 0.424 0.866 0.205 ...
# $ concavity_worst        : num  0.712 0.242 0.45 0.687 0.4 ...
# $ concave.points_worst   : num  0.265 0.186 0.243 0.258 0.163 ...
# $ symmetry_worst         : num  0.46 0.275 0.361 0.664 0.236 ...
# $ fractal_dimension_worst: num  0.1189 0.089 0.0876 0.173 0.0768 ...

The first variable is an integer variable named id . As this is simply a unique
identifier (ID) for each patient in the data, it does not provide useful 
information, and we will need to exclude it from the mode

Let''s drop the id feature altogether. As it is located in the first column, we can
exclude it by making a copy of the wbcd data frame without column 1 :
wbcd <- wbcd[-1]

The next variable, diagnosis , is of particular interest as it is the outcome we
hope to predict. This feature indicates whether the example is from a benign
or malignant mass. The table() output indicates that 357 masses are benign
while 212 are malignant:
  
table(wbcd$diagnosis)
# B    M
# 357 212

Many R machine learning classifiers require that the target feature is coded as a
factor, so we will need to recode the diagnosis variable. We will also take this
opportunity to give the "B" and "M" values more informative labels using the
labels parameter:
  wbcd$diagnosis<- factor(wbcd$diagnosis, levels = c("B", "M"),
                            labels = c("Benign", "Malignant"))

Now, when we look at the prop.table() output, we notice that the values have
been labeled Benign and Malignant with 62.7 percent and 37.3 percent of the
masses, respectively:
  round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)
# Benign Malignant
# 62.7   37.3

The remaining 30 features are all numeric, and as expected, they consist of three
different measurements of ten characteristics. For illustrative purposes, we will
only take a closer look at three of these features:
  summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])
# radius_mean       area_mean      smoothness_mean  
# Min.   : 6.981   Min.   : 143.5   Min.   :0.05263  
# 1st Qu.:11.700   1st Qu.: 420.3   1st Qu.:0.08637  
# Median :13.370   Median : 551.1   Median :0.09587  
# Mean   :14.127   Mean   : 654.9   Mean   :0.09636  
# 3rd Qu.:15.780   3rd Qu.: 782.7   3rd Qu.:0.10530  
# Max.   :28.110   Max.   :2501.0   Max.   :0.16340  

Since smoothness ranges from 0.05 to 0.16 and area ranges from 143.5 to 2501.0 , 
the impact of area is going to be much larger than the smoothness in the distance 
calculation. This could potentially cause problems for our classifier, so let us 
apply normalization to rescale the features to a standard range of values.

Transformation – normalizing numeric data
To normalize these features, we need to create a normalize() function in R. This
function takes a vector x of numeric values, and for each value in x , subtracts the
minimum value in x and divides by the range of values in x . Finally, the resulting
vector is returned. The code for this function is as follows:
  normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x)))
  }

We can now apply the normalize() function to the numeric features in our data
frame. Rather than normalizing each of the 30 numeric variables individually, we
will use one of R''s functions to automate the process.

The lapply() function takes a list and applies a specified function to each list
element. As a data frame is a list of equal-length vectors, we can use lapply() to
apply normalize() to each feature in the data frame. The final step is to convert 
the list returned by lapply() to a data frame, using the as.data.frame() function. 
The full process looks like this:

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

To confirm that the transformation was applied correctly, let us look at one 
variable''s summary statistics:
  summary(wbcd_n$area_mean)

Data preparation – creating training and test datasets
Although all the 569 biopsies are labeled with a benign or malignant status, 
it is not very interesting to predict what we already know. Additionally, 
any performance measures we obtain during the training may be misleading as 
we do not know the extent to which cases have been overfitted or how well the 
learner will generalize to unseen cases. A more interesting question is how 
well our learner performs on a dataset of unlabeled data. If we had access to 
a laboratory, we could apply our learner to the measurements taken from the 
next 100 masses of unknown cancer status, and see how well the machine 
learner''s predictions compare to the diagnoses obtained using conventional 
methods.
In the absence of such data, we can simulate this scenario by dividing our 
data into two portions: a training dataset that will be used to build the k-NN 
model and a test dataset that will be used to estimate the predictive accuracy 
of the model. We will use the first 469 records for the training dataset and 
the remaining 100 to simulate new patients.
We will split the wbcd_n data frame into wbcd_train and wbcd_test :
  
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

When we constructed our normalized training and test datasets, we excluded the
target variable, diagnosis . For training the k-NN model, we will need to store
these class labels in factor vectors, split between the training and test 
datasets:
  
wbcd_train_labels <- wbcd[1:469, 1]

wbcd_test_labels <- wbcd[470:569, 1]

This code takes the diagnosis factor in the first column of the wbcd data 
frame, and creates the vectors wbcd_train_labels and wbcd_test_labels . We will 
use these in the next steps of training and evaluating our classifier.

To classify our test instances, we will use a k-NN implementation from the 
class package, which provides a set of basic R functions for classification. If 
this package is not already installed on your system, you can install it by typing:
  install.packages("class")
library(class)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)
The knn() function returns a factor vector of predicted labels for each of the
examples in the test dataset, which we have assigned to wbcd_test_pred

Step 4 – evaluating model performance
The next step of the process is to evaluate how well the predicted classes in 
the wbcd_test_pred vector match up with the known values in the 
wbcd_test_labels vector.
To do this, we can use the CrossTable() function in the gmodels package.
install.packages('gmodels')
library(gmodels)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)


Cell Contents
|-------------------------|
  |                       N |
  |           N / Row Total |
  |           N / Col Total |
  |         N / Table Total |
  |-------------------------|
  
  
  Total Observations in Table:  100 


                   | wbcd_test_pred 
  wbcd_test_labels |    Benign | Malignant | Row Total | 
  -----------------|-----------|-----------|-----------|
            Benign |        77 |         0 |        77 | 
                   |     1.000 |     0.000 |     0.770 | 
                   |     0.975 |     0.000 |           | 
                   |     0.770 |     0.000 |           | 
  -----------------|-----------|-----------|-----------|
         Malignant |         2 |        21 |        23 | 
                   |     0.087 |     0.913 |     0.230 | 
                   |     0.025 |     1.000 |           | 
                   |     0.020 |     0.210 |           | 
  -----------------|-----------|-----------|-----------|
   Column Total    |        79 |        21 |       100 | 
                   |     0.790 |     0.210 |           | 
  -----------------|-----------|-----------|-----------|
              
A total of 2 out of 100, or 2 percent of masses were incorrectly classified 
by the k-NN approach. While 98 percent accuracy seems impressive for a few 
lines of R code, we might try another iteration of the model to see whether 
we can improve the performance and reduce the number of values that have 
been incorrectly classified, particularly because the errors were dangerous 
false negatives.

Step 5 – improving model performance
We will try several different values for k.

Testing alternative values of k
We may be able do even better by examining performance across various k values.
Using the normalized training and test datasets, the same 100 records were 
classified using several different k values. The number of false negatives and 
false positives are shown for each iteration:
  k value False negatives False positives Percent classified incorrectly
   1       1               3                4 percent
   5       2               0                2 percent
   11      3               0                3 percent
   15      3               0                3 percent
   21      2               0                2 percent
   27      4               0                4 percent