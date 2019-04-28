Variables & Data Types
----------------------
# o Various Operators like Arithmetic, Relational, Logical, Assignment
The + operator performs addition, but it has a special trick: as well as adding two numbers together, 
you can use it to add two vectors. A vector is an ordered set of values. 
Vectors are tremendously important in statistics, since you will usually want to analyze a whole dataset 
rather than just one piece of data.
1+ 2
## [1] 3
c(1,2,3) + c(4,5,6)
## [1] 5 7 9

The colon operator, :, creates a sequence from one number to the next, 
and the c function concatenates values, in this case to create vectors (concatenate is a Latin word meaning 
                                                                        “connect together in a chain”).
Variables are case sensetive in R
> 1:5
[1] 1 2 3 4 5
> 1:5 + 2:3
[1] 3 5 5 7 7
Warning message:
  In 1:5 + 2:3 :
  longer object length is not a multiple of shorter object length
> 1:5 + 2:6
[1]  3  5  7  9 11
> 2:3
[1] 2 3

Vectorized has several meanings in R, the most common of which is that 
an operator or a function will act on each element of a vector without the need for you to explicitly write a loop.
sum(1:5)
## [1] 15
median(1:5)
## [1] 3

sum(1, 2, 3, 4, 5)
## [1] 15
median(1, 2, 3, 4, 5)  #this throws an error
## Error: unused arguments (3, 4, 5)
All the arithmetic operators in R, not just plus (+), are vectorized. T
he following examples demonstrate subtraction, multiplication, exponentiation, and two kinds of division, 
as well as remainder after division:
  c(2, 3, 5, 7, 11, 13) - 2            #subtraction
## [1]  0  1  3  5  9 11

-2:2 * -2:2                          #multiplication
## [1] 4 1 0 1 4

identical(2 ^ 3, 2 ** 3)             #we can use ^ or ** for exponentiation
#though ^ is more common
## [1] TRUE

1:10 / 3                             #floating point division
##  [1] 0.3333 0.6667 1.0000 1.3333 1.6667 2.0000 2.3333 2.6667 3.0000 3.3333

1:10 %/% 3                           #integer division
##  [1] 0 0 1 1 1 2 2 2 3 3

1:10 %% 3                            #remainder after division
##  [1] 1 2 0 1 2 0 1 2 0 1

R also contains a wide selection of mathematical functions. You get trigonometry (sin, cos, tan, and their inverses asin, acos, and atan), 
logarithms and exponents (log and exp, and their variants log1p and expm1 that calculate log(1 + x) and exp(x - 1) 
                          more accurately for very small values of x), and almost any other mathematical function you can think of. 
The following examples provide a hint of what is on offer. Again, notice that all the functions naturally operate on vectors 
rather than just single values:
  cos(c(0, pi / 4, pi / 2, pi))        #pi is a built-in constant
## [1]  1.000e+00  7.071e-01  6.123e-17 -1.000e+00

exp(pi * 1i) + 1                     #Euler's formula
## [1] 0+1.225e-16i

factorial(7) + factorial(1) - 71 ^ 2 #5041 is a great number
## [1] 0

choose(5, 0:5)
## [1]  1  5 10 10  5  1

To compare integer values for equality, use ==. Don’t use a single = since that is used for something else. 
Just like the arithmetic operators, == and the other relational operators are vectorized. 
To check for inequality, the “not equals” operator is !=. 
Greater than and less than are as you might expect: > and < (or >= and <= if equality is allowed). Here are a few examples:
  
  c(3, 4 - 1, 1 + 1 + 1) == 3                #operators are vectorized too
## [1] TRUE TRUE TRUE

1:3 != 3:1
## [1]  TRUE FALSE  TRUE

exp(1:5) < 100
## [1]  TRUE  TRUE  TRUE  TRUE FALSE

(1:5) ^ 2 >= 16
## [1] FALSE FALSE FALSE  TRUE  TRUE

Consider these two numbers, which should be the same:
  sqrt(2) ^ 2 == 2         #sqrt is the square-root function
## [1] FALSE
sqrt(2) ^ 2 - 2          #this small value is the rounding error
## [1] 4.441e-16

R also provides the function all.equal for checking equality of numbers. 
This provides a tolerance level (by default, about 1.5e-8), so that rounding errors less than the tolerance are ignored:
  all.equal(sqrt(2) ^ 2, 2)
## [1] TRUE

If the values to be compared are not the same, all.equal returns a report on the differences. 
If you require a TRUE or FALSE value, then you need to wrap the call to all.equal in a call to isTRUE:
  all.equal(sqrt(2) ^ 2, 3)
## [1] "Mean relative difference: 0.5"

isTRUE(all.equal(sqrt(2) ^ 2, 3))
## [1] FALSE

To check that two numbers are the same, don’t use ==. Instead, use the all.equal function.

We can also use == to compare strings. In this case the comparison is case sensitive, so the strings must match exactly. 
It is also theoretically possible to compare strings using greater than or less than (> and <):
  c(
    "Can", "you", "can", "a", "can", "as",
    "a", "canner", "can", "can", "a", "can?"
  ) == "can"
##  [1] FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE
## [12] FALSE

c("A", "B", "C", "D") < "C"
## [1]  TRUE  TRUE FALSE FALSE

c("a", "b", "c", "d") < "C" #your results may vary
## [1]  TRUE  TRUE  TRUE FALSE

Assigning variables
------------------
x <- 1:5
y = 6:10
Now we can reuse these values in our further calculations:
x + 2 * y - 3
## [1] 10 13 16 19 22

We can also do global assignment using <<-. There’ll be more on what this means when we cover environments and scoping in Environments
; for now, just think of it as creating a variable available anywhere:
  x <<- exp(exp(1))
There is one more method of variable assignment, via the assign function. It is much less common than the other methods, 
but very occasionally it is useful to have a function syntax for assigning variables. 
Local (“normal”) assignment takes two arguments — the name of the variable to assign to and the value you want to give it:
  assign("my_local_variable", 9 ^ 3 + 10 ^ 3)
Global assignment (like the <<- operator does) takes an extra argument:
  assign("my_global_variable", 1 ^ 3 + 12 ^ 3, globalenv())

In the following examples, rnorm generates random numbers from a normal distribution, and rlnorm generates them from a 
lognormal distribution:
z <- rnorm(5); z
## [1]  1.8503 -0.5787 -1.4797 -0.1333 -0.2321

(zz <- rlnorm(5))
## [1] 1.0148 4.2476 0.3574 0.2421 0.3163

To help with arithmetic, R supports four special numeric values: Inf, -Inf, NaN, and NA. 
The first two are, of course, positive and negative infinity, but the second pair need a little more explanation. 
NaN is short for “not-a-number,” and means that our calculation either didn’t make mathematical sense or could not 
be performed properly. NA is short for “not available” and represents a missing value — a problem all too common 
in data analysis. In general, if our calculation involves a missing value, then the results will also be missing:
 
   c(Inf + 1, Inf - 1, Inf - Inf)
## [1] Inf Inf NaN

c(1 / Inf, Inf / 1, Inf / Inf)
## [1]   0 Inf NaN

c(sqrt(Inf), sin(Inf))
## Warning: NaNs produced
## [1] Inf NaN

c(log(Inf), log(Inf, base = Inf))
## Warning: NaNs produced
## [1] Inf NaN

c(NA + 1, NA * 5, NA + Inf)
## [1] NA NA NA

x <- c(0, Inf, -Inf, NaN, NA)
is.finite(x)
## [1]  TRUE FALSE FALSE FALSE FALSE

is.infinite(x)
## [1] FALSE  TRUE  TRUE FALSE FALSE

is.nan(x)
## [1] FALSE FALSE FALSE  TRUE FALSE

is.na(x)
## [1] FALSE FALSE FALSE  TRUE  TRUE

There are three vectorized logical operators in R:
  ! is used for not.
& is used for and.
| is used for or.

(x <- 1:10 >= 5)
##  [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

!x
##  [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE

(y <- 1:10 %% 2 == 0)
##  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE

x & y
##  [1] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE

x | y
##  [1] FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

Classes
All variables in R have a class, which tells you what kinds of variables they are. For example, most numbers 
have class numeric (see the next section for the other types), and logical values have class logical.

class(c(TRUE, FALSE))
## [1] "logical"

class(sqrt(1:10))
## [1] "numeric"

class(3 + 1i)      #"i" creates imaginary components of complex numbers
## [1] "complex"

class(1)           #although this is a whole number, it has class numeric
## [1] "numeric"

class(1L)          #add a suffix of "L" to make the number an integer
## [1] "integer"

class(0.5:4.5)     #the colon operator returns a value that is numeric...
## [1] "numeric"

class(1:5)         #unless all its values are whole numbers
## [1] "integer"

(gender <- factor(c("male", "female", "female", "male", "female")))
## [1] male   female female male   female

levels(gender)
## [1] "female" "male"

nlevels(gender)
## [1] 2

Give example of
typeof, mode, length

gender_char <- sample(c("female", "male"), 10000, replace = TRUE)
gender_fac <- as.factor(gender_char)

object.size(gender_char)
## 80136 bytes

object.size(gender_fac)
## 40512 bytes

table(gender_fac)
# gender_fac
## female   male 
## 5048   4952 

The raw class stores vectors of “raw” bytes. Each byte is represented by a two-digit hexadecimal value. 
They are primarily used for storing the contents of imported binary files, and as such are reasonably rare. 
The integers 0 to 255 can be converted to raw using as.raw. Fractional and imaginary parts are discarded, 
and numbers outside this range are treated as 0. For strings, as.raw doesn’t work; you must use charToRaw instead:
as.raw(1:17)
##  [1] 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 10 11

as.raw(c(pi, 1 + 1i, -1, 256))
## Warning: imaginary parts discarded in coercion
## Warning: out-of-range values treated as 0 in coercion to raw
## [1] 03 01 00 00

(sushi <- charToRaw("Fish!"))
## [1] 46 69 73 68 21

class(sushi)
## [1] "raw"

As well as viewing the printout of a variable, it is often helpful to see some sort of summary of the object. 
The summary function does just that, giving appropriate information for different data types. Numeric variables 
are summarized as mean, median, and some quantiles. Here, the runif function generates 30 random numbers that are 
uniformly distributed between 0 and 1:
  num <- runif(30)
summary(num)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0211  0.2960  0.5060  0.5290  0.7810  0.9920

Categorical and logical vectors are summarized by the counts of each value. In this next example, 
letters is a built-in constant that contains the lowercase values from “a” to “z” (LETTERS contains the 
                                                                                   uppercase equivalents, “A” to “Z”). 
Here, letters[1:5] uses indexing to restrict the letters to “a” to “e.” The sample function randomly samples these values, 
with replace, 30 times:
fac <- factor(sample(letters[1:5], 30, replace = TRUE))
summary(fac)
## a b c d e
## 6 7 5 9 3

bool <- sample(c(TRUE, FALSE, NA), 30, replace = TRUE)
summary(bool)
##    Mode   FALSE    TRUE    NA's
## logical      12      11       7

Multidimensional objects, like matrices and data frames, are summarized by column (we’ll look at these in more detail 
                                                                                   in the next two chapters). 
The data frame dfr that we create here is quite large to display, having 30 rows. For large objects like this, 
the head function can be used to display only the first few rows (six by default):
dfr <- data.frame(num, fac, bool)
head(dfr)
##       num fac  bool
## 1 0.47316   b    NA
## 2 0.56782   d FALSE
## 3 0.46205   d FALSE
## 4 0.02114   b  TRUE
## 5 0.27963   a  TRUE
## 6 0.46690   a  TRUE

The summary function for data frames works like calling summary on each
summary(dfr)
##       num         fac      bool
##  Min.   :0.0211   a:6   Mode :logical
##  1st Qu.:0.2958   b:7   FALSE:12
##  Median :0.5061   c:5   TRUE :11
##  Mean   :0.5285   d:9   NA's :7
##  3rd Qu.:0.7808   e:3
##  Max.   :0.9916

Similarly, the str function shows the object’s structure. It isn’t that interesting for vectors (since they are so simple), 
but str is exceedingly useful for data frames and nested lists:
  str(num)
##  num [1:30] 0.4732 0.5678 0.462 0.0211 0.2796 ...
str(dfr)
## 'data.frame':        30 obs. of  3 variables:
##  $ num : num  0.4732 0.5678 0.462 0.0211 0.2796 ...
##  $ fac : Factor w/ 5 levels "a","b","c","d",..: 2 4 4 2 1 1 4 2 1 4 ...
##  $ bool: logi  NA FALSE FALSE TRUE TRUE TRUE ...

As mentioned previously, each class typically has its own print method that controls how it is displayed to the console. 
Sometimes this printing obscures its internal structure, or omits useful information. 
The unclass function can be used to bypass this, letting you see how a variable is constructed. For example, 
calling unclass on a factor reveals that it is just an integer vector, with an attribute called levels:
  unclass(fac)
##  [1] 2 4 4 2 1 1 4 2 1 4 3 3 1 5 4 5 1 5 1 2 2 3 4 2 4 3 4 2 3 4
## attr(,"levels")
## [1] "a" "b" "c" "d" "e"

We’ll look into attributes later on, but for now, it is useful to know that the attributes function gives you a list of 
all the attributes belonging to an object:
  attributes(fac)
## $levels
## [1] "a" "b" "c" "d" "e"
##
## $class
## [1] "factor"

For visualizing two-dimensional variables such as matrices and data frames, the View function (notice the capital “V”) 
displays the variable as a (read-only) spreadsheet. The edit and fix functions work similarly to View, 
but let us manually change data values. While this may sound more useful, it is usually a supremely 
awful idea to edit data in this way, since we lose all traceability of where our data came from. 
It is almost always better to edit data programmatically:
  View(dfr)               #no changes allowed
new_dfr <- edit(dfr)    #changes stored in new_dfr
fix(dfr)                #changes stored in dfr
A useful trick is to view the first few rows of a data frame by combining View with head:
  View(head(dfr, 50))     #view first 50 rows

Workspace
---------
peach <- 1
plum <- "fruity"
pear <- TRUE
ls()

rm(peach, plum, pear)
rm(list = ls())       #Removes everything. Use with caution!


# o Vectors
Vectors
So far, you have used the colon operator, :, for creating sequences from one number to another, 
and the c function for concatenating values and vectors to create longer vectors. To recap:
  8.5:4.5                #sequence of numbers from 8.5 down to 4.5
## [1] 8.5 7.5 6.5 5.5 4.5

c(1, 1:3, c(5, 8), 13) #values concatenated into single vector
## [1]  1  1  2  3  5  8 13

The vector function creates a vector of a specified type and length. Each of the values in the result is zero, 
FALSE, or an empty string, or whatever the equivalent of “nothing” is:
  
  vector("numeric", 5)
## [1] 0 0 0 0 0

vector("complex", 5)
## [1] 0+0i 0+0i 0+0i 0+0i 0+0i

vector("logical", 5)
## [1] FALSE FALSE FALSE FALSE FALSE

vector("character", 5)
## [1] "" "" "" "" ""

vector("list", 5)
## [[1]]
## NULL
##
## [[2]]
## NULL
##
## [[3]]
## NULL
##
## [[4]]
## NULL
##
## [[5]]
## NULL

Sequences
Beyond the colon operator, there are several functions for creating more general sequences. 
The seq function is the most general, and allows you to specify sequences in many different ways. 
In practice, though, you should never need to call it, since there are three other specialist 
sequence functions that are faster and easier to use, covering specific use cases.

seq.int lets us create a sequence from one number to another. With two inputs, it works exactly like the colon operator:
  seq.int(3, 12)     #same as 3:12
##  [1]  3  4  5  6  7  8  9 10 11 12

seq.int is slightly more general than :, since it lets you specify how far apart intermediate values should be:
  seq.int(3, 12, 2)
## [1]  3  5  7  9 11

seq.int(0.1, 0.01, -0.01)
##  [1] 0.10 0.09 0.08 0.07 0.06 0.05 0.04 0.03 0.02 0.01

seq_len creates a sequence from 1 up to its input, so seq_len(5) is just a clunkier way of writing 1:5. 
However, the function is extremely useful for situations when its input could be zero:
  n <- 0
1:n        #not what you might expect!
## [1] 1 0

seq_len(n)
## integer(0)

seq_along creates a sequence from 1 up to the length of its input:
  pp <- c("Peter", "Piper", "picked", "a", "peck", "of", "pickled", "peppers")
for(i in seq_along(pp)) print(pp[i])
## [1] "Peter"
## [1] "Piper"
## [1] "picked"
## [1] "a"
## [1] "peck"
## [1] "of"
## [1] "pickled"
## [1] "peppers"

For each of the preceding examples, you can replace seq.int, seq_len, or seq_along with plain seq and get 
the same answer, though there is no need to do so.

length
-----
  length(1:5)
## [1] 5

length(c(TRUE, FALSE, NA))
## [1] 3

One possible source of confusion is character vectors. With these, the length is the number of strings,
not the number of characters in each string. For that, we should use nchar:
  sn <- c("Sheena", "leads", "Sheila", "needs")
length(sn)
## [1] 4

nchar(sn)
## [1] 6 5 6 5

It is also possible to assign a new length to a vector, but this is an unusual thing to do, 
and probably indicates bad code. If you shorten a vector, the values at the end will be removed, 
and if you extend a vector, missing values will be added to the end:
  poincare <- c(1, 0, 0, 0, 2, 0, 2, 0)  #See http://oeis.org/A051629
length(poincare) <- 3
poincare
## [1] 1 0 0

length(poincare) <- 8
poincare
## [1] 1 0 0 0 2 0 2 0

Names
A great feature of R’s vectors is that each element can be given a name. Labeling the elements 
can often make your code much more readable. You can specify names when you create a vector 
in the form name = value. If the name of an element is a valid variable name, it doesn’t need 
to be enclosed in quotes. You can name some elements of a vector and leave others blank:
  c(apple = 1, banana = 2, "kiwi fruit" = 3, 4)
##      apple     banana kiwi fruit
##          1          2          3          4

You can add element names to a vector after its creation using the names function:
  x <- 1:4
names(x) <- c("apple", "bananas", "kiwi fruit", "")
x
##      apple    bananas kiwi fruit
##          1          2          3          4

This names function can also be used to retrieve the names of a vector:
  names(x)
## [1] "apple"      "bananas"    "kiwi fruit" ""

Indexing Vectors
Oftentimes we may want to access only part of a vector, or perhaps an individual element. 
This is called indexing and is accomplished with square brackets, []. 
(Some people also call it subsetting or subscripting or slicing. All these terms refer to 
  the same thing.) R has a very flexible system that gives us several choices of index:
  Passing a vector of positive numbers returns the slice of the vector containing the elements at those 
locations. The first position is 1 (not 0, as in some other languages).
Passing a vector of negative numbers returns the slice of the vector containing the 
elements everywhere except at those locations.
Passing a logical vector returns the slice of the vector containing the elements where the index is TRUE.
For named vectors, passing a character vector of names returns the slice of the vector containing 
the elements with those names.
Consider this vector:
  x <- (1:5) ^ 2
## [1]  1  4  9 16 25

These three indexing methods return the same values:
  x[c(1, 3, 5)]
x[c(-2, -4)]
x[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
## [1]  1  9 25

After naming each element, this method also returns the same values:
  names(x) <- c("one", "four", "nine", "sixteen", "twenty five")
x[c("one", "nine", "twenty five")]
##         one        nine twenty five
##           1           9          25

Mixing positive and negative values is not allowed, and will throw an error:
  x[c(1, -1)]      #This doesn't make sense!
## Error: only 0's may be mixed with negative subscripts

If you use positive numbers or logical values as the index, then missing indices correspond to missing values in the result:
  x[c(1, NA, 5)]
##         one        <NA> twenty five
##           1          NA          25

x[c(TRUE, FALSE, NA, FALSE, TRUE)]
##         one        <NA> twenty five
##           1          NA          25

Missing values don’t make any sense for negative indices, and cause an error:
  x[c(-2, NA)]     #This doesn't make sense either!

Out of range indices, beyond the length of the vector, don’t cause an error, but instead 
return the missing value NA. In practice, it is usually better to make sure that your indices 
are in range than to use out of range values:
  
  x[6]
## <NA>
##   NA

Noninteger indices are silently rounded toward zero. This is another case where R is arguably too permissive. 
If you find yourself passing fractions as indices, you are probably writing bad code:
  x[1.9]   #1.9 rounded to 1
## one
##   1
x[-1.9]  #-1.9 rounded to -1
##        four        nine     sixteen twenty five
##           4           9          16          25

Not passing any index will return the whole of the vector, but again, if you find yourself not passing 
any index, then you are probably doing something odd:
  x[]
##         one        four        nine     sixteen twenty five
##           1           4           9          16          25

The which function returns the locations where a logical vector is TRUE. This can be useful for switching 
from logical indexing to integer indexing 
which(x > 10)
##     sixteen twenty five
##           4           5

which.min and which.max are more efficient shortcuts for which(min(x)) and which(max(x)), respectively:
  which.min(x)
## one
##   1

which.max(x)
## twenty five
##           5

Vector Recycling and Repetition
So far, all the vectors that we have added together have been the same length. You may be wondering, 
“What happens if I try to do arithmetic on vectors of different lengths?”
If we try to add a single number to a vector, then that number is added to each element of the vector:
  1:5 + 1
## [1] 2 3 4 5 6

1 + 1:5
## [1] 2 3 4 5 6

When adding two vectors together, R will recycle elements in the shorter vector to match the longer one:
  
  The rep function is very useful, letting us create a vector with repeated elements:
  rep(1:5, 3)
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5

rep(1:5, each = 3)
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5

rep(1:5, times = 1:5)
##  [1] 1 2 2 3 3 3 4 4 4 4 5 5 5 5 5

rep(1:5, length.out = 7)
## [1] 1 2 3 4 5 1 2

Like the seq function, rep has a simpler and faster variant, rep.int, for the most common case:
  rep.int(1:5, 3)  #the same as rep(1:5, 3)
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5

Recent versions of R (since v3.0.0) also have rep_len, paralleling seq_len, which lets us specify the 
length of the output vector:
  rep_len(1:5, 13)
##  [1] 1 2 3 4 5 1 2 3 4 5 1 2 3

# o Arrays and Matrices
The vector variables that we have looked at so far are one-dimensional objects, since they 
have length but no other dimensions. Arrays hold multidimensional rectangular data. 
“Rectangular” means that each row is the same length, and likewise for each column and 
other dimensions. Matrices are a special case of two-dimensional arrays.

To create an array, you call the array function, passing in a vector of values and a vector of 
dimensions. Optionally, you can also provide names for each dimension:
  (three_d_array <- array(
    1:24,
    dim = c(4, 3, 2),
    dimnames = list(
      c("one", "two", "three", "four"),
      c("ein", "zwei", "drei"),
      c("un", "deux")
    )
  ))
## , , un
##
##       ein zwei drei
## one     1    5    9
## two     2    6   10
## three   3    7   11
## four    4    8   12
##
## , , deux
##
##       ein zwei drei
## one    13   17   21
## two    14   18   22
## three  15   19   23
## four   16   20   24
class(three_d_array)
## [1] "array"

The syntax for creating matrices is similar, but rather than passing a dim argument, you specify 
the number of rows or the number of columns:
  (a_matrix <- matrix(
    1:12,
    nrow = 4,            #ncol = 3 works the same
    dimnames = list(
      c("one", "two", "three", "four"),
      c("ein", "zwei", "drei")
    )
  ))
##       ein zwei drei
## one     1    5    9
## two     2    6   10
## three   3    7   11
## four    4    8   12

class(a_matrix)
## [1] "matrix"

This matrix could also be created using the array function. The following two-dimensional array is 
identical to the matrix that we just created (it even has class matrix):
  (two_d_array <- array(
    1:12,
    dim = c(4, 3),
    dimnames = list(
      c("one", "two", "three", "four"),
      c("ein", "zwei", "drei")
    )
  ))
##       ein zwei drei
## one     1    5    9
## two     2    6   10
## three   3    7   11
## four    4    8   12

identical(two_d_array, a_matrix)
## [1] TRUE

class(two_d_array)
## [1] "matrix"

When you create a matrix, the values that you passed in fill the matrix column-wise. It is also possible 
to fill the matrix row-wise by specifying the argument byrow = TRUE:
  matrix(
    1:12,
    nrow = 4,
    byrow = TRUE,
    dimnames = list(
      c("one", "two", "three", "four"),
      c("ein", "zwei", "drei")
    )
  )
##       ein zwei drei
## one     1    2    3
## two     4    5    6
## three   7    8    9
## four   10   11   12

dim(three_d_array)
## [1] 4 3 2

dim(a_matrix)
## [1] 4 3

For matrices, the functions nrow and ncol return the number of rows and columns, respectively:
  nrow(a_matrix)
## [1] 4

ncol(a_matrix)
## [1] 3

nrow and ncol also work on arrays, returning the first and second dimensions, respectively, but 
it is usually better to use dim for higher-dimensional objects:
  nrow(three_d_array)
## [1] 4

ncol(three_d_array)
## [1] 3

The length function that we have previously used with vectors also works on matrices and arrays. 
In this case it returns the product of each of the dimensions:

  length(three_d_array)
## [1] 24

length(a_matrix)
## [1] 12

We can also reshape a matrix or array by assigning a new dimension with dim. This should be used with 
caution since it strips dimension names:

    dim(a_matrix) <- c(6, 2)
a_matrix
##      [,1] [,2]
## [1,]    1    7
## [2,]    2    8
## [3,]    3    9
## [4,]    4   10
## [5,]    5   11
## [6,]    6   12

nrow, ncol, and dim return NULL when applied to vectors. The functions NROW and NCOL are counterparts 
to nrow and ncol that pretend vectors are matrices with a single column (that is, column vectors 
                                                                         in the mathematical sense):
  
identical(nrow(a_matrix), NROW(a_matrix))
## [1] TRUE

identical(ncol(a_matrix), NCOL(a_matrix))
## [1] TRUE

recaman <- c(0, 1, 3, 6, 2, 7, 13, 20)
nrow(recaman)
## NULL

NROW(recaman)
## [1] 8

ncol(recaman)
## NULL

NCOL(recaman)
## [1] 1

dim(recaman)

rownames(a_matrix)
## [1] "one"   "two"   "three" "four"

colnames(a_matrix)
## [1] "ein"  "zwei" "drei"

dimnames(a_matrix)
## [[1]]
## [1] "one"   "two"   "three" "four"
##
## [[2]]
## [1] "ein"  "zwei" "drei"

rownames(three_d_array)
## [1] "one"   "two"   "three" "four"

colnames(three_d_array)
## [1] "ein"  "zwei" "drei"

dimnames(three_d_array)
## [[1]]
## [1] "one"   "two"   "three" "four"
##
## [[2]]
## [1] "ein"  "zwei" "drei"
##
## [[3]]
## [1] "un"   "deux"

a_matrix[1, c("zwei", "drei")] #elements in 1st row, 2nd and 3rd columns
## zwei drei
##    5    9

To include all of a dimension, leave the corresponding index blank:
  a_matrix[1, ]                  #all of the first row
##  ein zwei drei
##    1    5    9

a_matrix[, c("zwei", "drei")]  #all of the second and third columns
##       zwei drei
## one      5    9
## two      6   10
## three    7   11
## four     8   12

Combining Matrices
The c function converts matrices to vectors before concatenating them:
  (another_matrix <- matrix(
    seq.int(2, 24, 2),
    nrow = 4,
    dimnames = list(
      c("five", "six", "seven", "eight"),
      c("vier", "funf", "sechs")
    )
  ))
##       vier funf sechs
## five     2   10    18
## six      4   12    20
## seven    6   14    22
## eight    8   16    24

c(a_matrix, another_matrix)
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12  2  4  6  8 10 12 14 16 18 20 22
## [24] 24

More natural combining of matrices can be achieved by using cbind and rbind, which bind matrices 
together by columns and rows:
  cbind(a_matrix, another_matrix)
##       ein zwei drei vier funf sechs
## one     1    5    9    2   10    18
## two     2    6   10    4   12    20
## three   3    7   11    6   14    22
## four    4    8   12    8   16    24

rbind(a_matrix, another_matrix)
##       ein zwei drei
## one     1    5    9
## two     2    6   10
## three   3    7   11
## four    4    8   12
## five    2   10   18
## six     4   12   20
## seven   6   14   22
## eight   8   16   24

Array Arithmetic
The standard arithmetic operators (+, -, \*, /) work element-wise on matrices and arrays, 
just they like they do on vectors:
  a_matrix + another_matrix
##       ein zwei drei
## one     3   15   27
## two     6   18   30
## three   9   21   33
## four   12   24   36

a_matrix * another_matrix
##       ein zwei drei
## one     2   50  162
## two     8   72  200
## three  18   98  242
## four   32  128  288

The t function transposes matrices (but not higher-dimensional arrays, where the concept isn’t well defined):
  t(a_matrix)
##      one two three four
## ein    1   2     3    4
## zwei   5   6     7    8
## drei   9  10    11   12

For inner and outer matrix multiplication, we have the special operators %*% and %o%. 
In each case, the dimension names are taken from the first input, if they exist:
  a_matrix %*% t(a_matrix)  #inner multiplication
##       one two three four
## one   107 122   137  152
## two   122 140   158  176
## three 137 158   179  200
## four  152 176   200  224

1:3 %o% 4:6               #outer multiplication
##      [,1] [,2] [,3]
## [1,]    4    5    6
## [2,]    8   10   12
## [3,]   12   15   18

outer(1:3, 4:6)           #same
##      [,1] [,2] [,3]
## [1,]    4    5    6
## [2,]    8   10   12
## [3,]   12   15   18

The power operator, ^, also works element-wise on matrices, so to invert a matrix you cannot simply 
raise it to the power of minus one. Instead, this can be done using the solve function:
(m <- matrix(c(1, 0, 1, 5, -3, 1, 2, 4, 7), nrow = 3))
##      [,1] [,2] [,3]
## [1,]    1    5    2
## [2,]    0   -3    4
## [3,]    1    1    7

m ^ -1
##      [,1]    [,2]   [,3]
## [1,]    1  0.2000 0.5000
## [2,]  Inf -0.3333 0.2500
## [3,]    1  1.0000 0.1429

(inverse_of_m <- solve(m))
##      [,1] [,2] [,3]
## [1,]  -25  -33   26
## [2,]    4    5   -4
## [3,]    3    4   -3

inverse_of_m= det(m)*(1/adj(m)

m %*% inverse_of_m
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1

# o List and Data frames
A list is, loosely speaking, a vector where each element can be of a different type. 
Lists are created with the list function, and specifying the contents works much like the c function 
that we’ve seen already. You simply list the contents, with each argument separated by a comma. 
List elements can be any variable type — vectors, matrices, even functions:
  (a_list <- list(
    c(1, 1, 2, 5, 14, 42),    #See http://oeis.org/A000108
    month.abb,
    matrix(c(3, -8, 1, -3), nrow = 2),
    asin
  ))
## [[1]]
## [1]  1  1  2  5 14 42
##
## [[2]]
##  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
## [12] "Dec"
##
## [[3]]
##      [,1] [,2]
## [1,]    3    1
## [2,]   -8   -3
##
## [[4]]
## function (x)  .Primitive("asin")

As with vectors, you can name elements during construction, or afterward using the names function:
  names(a_list) <- c("catalan", "months", "involutary", "arcsin")
a_list
## $catalan
## [1]  1  1  2  5 14 42
##
## $months
##  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
## [12] "Dec"
##
## $involutary
##      [,1] [,2]
## [1,]    3    1
## [2,]   -8   -3
##
## $arcsin
## function (x)  .Primitive("asin")
(the_same_list <- list(
  catalan    = c(1, 1, 2, 5, 14, 42),
  months     = month.abb,
  involutary = matrix(c(3, -8, 1, -3), nrow = 2),
  arcsin     = asin
))
## $catalan
## [1]  1  1  2  5 14 42
##
## $months
##  [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov"
## [12] "Dec"
##
## $involutary
##      [,1] [,2]
## [1,]    3    1
## [2,]   -8   -3
##
## $arcsin
## function (x)  .Primitive("asin")

Atomic and Recursive Variables
Due to this ability to contain other lists within themselves, lists are considered to be 
recursive variables. Vectors, matrices, and arrays, by contrast, are atomic. 
(Variables can either be recursive or atomic, never both; Appendix A contains a table 
  explaining which variable types are atomic, and which are recursive.) The functions is.recursive 
and is.atomic let us test variables to see what type they are:
  
  is.atomic(list())
## [1] FALSE

is.recursive(list())
## [1] TRUE

is.atomic(numeric())
## [1] TRUE

is.recursive(numeric())
## [1] FALSE

List Dimensions and Arithmetic
Like vectors, lists have a length. A list’s length is the number of top-level elements that it contains:

  length(a_list)
## [1] 4

length(main_list) #doesn't include the lengths of nested lists
## [1] 2

dim(a_list)
## NULL

nrow, NROW, and the corresponding column functions work on lists in the same way as on vectors:
  nrow(a_list)
## NULL

ncol(a_list)
## NULL

NROW(a_list)
## [1] 4

NCOL(a_list)
## [1] 1

Unlike with vectors, arithmetic doesn’t work on lists. Since each element can be of a different type, 
it doesn’t make sense to be able to add or multiply two lists together. It is possible to do arithmetic 
on list elements, however, assuming that they are of an appropriate type. In that case, the usual 
rules for the element contents apply. For example:
  l1 <- list(1:5)
l2 <- list(6:10)
> l1
##[[1]]
##[1] 1 2 3 4 5

> l2
##[[1]]
##[1]  6  7  8  9 10
l1[[1]] + l2[[1]]
## [1]  7  9 11 13 15

Indexing Lists
Consider this test list:
  l <- list(
    first  = 1,
    second = 2,
    third  = list(
      alpha = 3.1,
      beta  = 3.2
    )
  )
As with vectors, we can access elements of the list using square brackets, [], 
and positive or negative numeric indices, element names, or a logical index. 
The following four lines of code all give the same result:
  l[1:2]
## $first
## [1] 1
##
## $second
## [1] 2

l[-3]
## $first
## [1] 1
##
## $second
## [1] 2

l[c("first", "second")]
## $first
## [1] 1
##
## $second
## [1] 2

l[c(TRUE, TRUE, FALSE)]
## $first
## [1] 1
##
## $second
## [1] 2

The result of these indexing operations is another list. Sometimes we want to access the contents of the 
list elements instead. There are two operators to help us do this. Double square brackets ([[]]) can be 
given a single positive integer denoting the index to return, or a single string naming that element:
  l[[1]]
## [1] 1

l[["first"]]
## [1] 1

The is.list function returns TRUE if the input is a list, and FALSE otherwise. For comparison, 
take a look at the two indexing operators:
  is.list(l[1])
## [1] TRUE

is.list(l[[1]])
## [1] FALSE

busy_beaver <- c(1, 6, 21, 107)  #See http://oeis.org/A060843
as.list(busy_beaver)
## [[1]]
## [1] 1
##
## [[2]]
## [1] 6
##
## [[3]]
## [1] 21
##
## [[4]]
## [1] 107

If each element of the list contains a scalar value, then it is also possible to convert that 
list to a vector using the functions that we have already seen (as.numeric, as.character, and so on):
  as.numeric(list(1, 6, 21, 107))
## [1]   1   6  21 107

Combining Lists
The c function that we have used for concatenating vectors also works for concatenating lists:
  c(list(a = 1, b = 2), list(3))
## $a
## [1] 1
##
## $b
## [1] 2
##
## [[3]]
## [1] 3

It is also possible to use the cbind and rbind functions on lists, but the resulting objects are very 
strange indeed. They are matrices with possibly nonscalar elements, or lists with dimensions, 
depending upon which way you want to look at them:
  (matrix_list_hybrid <- cbind(
    list(a = 1, b = 2),
    list(c = 3, list(d = 4))
  ))
##   [,1] [,2]
## a 1    3
## b 2    List,1
str(matrix_list_hybrid)
## List of 4
##  $ : num 1
##  $ : num 2
##  $ : num 3
##  $ :List of 1
##   ..$ d: num 4
##  - attr(*, "dim")= int [1:2] 2 2
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:2] "a" "b"
##   ..$ : NULL

USING NULL
---------
(uk_bank_holidays_2013 <- list(
  Jan = "New Year's Day",
  Feb = NULL,
  Mar = "Good Friday",
  Apr = "Easter Monday",
  May = c("Early May Bank Holiday", "Spring Bank Holiday"),
  Jun = NULL,
  Jul = NULL,
  Aug = "Summer Bank Holiday",
  Sep = NULL,
  Oct = NULL,
  Nov = NULL,
  Dec = c("Christmas Day", "Boxing Day")
))
## $Jan
## [1] "New Year's Day"
##
## $Feb
## NULL
##
## $Mar
## [1] "Good Friday"
##
## $Apr
## [1] "Easter Monday"
##
## $May
## [1] "Early May Bank Holiday" "Spring Bank Holiday"
##
## $Jun
## NULL
##
## $Jul
## NULL
##
## $Aug
## [1] "Summer Bank Holiday"
##
## $Sep
## NULL
##
## $Oct
## NULL
##
## $Nov
## NULL
##
## $Dec
## [1] "Christmas Day" "Boxing Day"

Data Frames
Data frames are used to store spreadsheet-like data. They can either be thought of as matrices where 
each column can store a different type of data, or nonnested lists where each element is of the same length.
Creating Data Frames
We create data frames with the data.frame function:
  (a_data_frame <- data.frame(
    x = letters[1:5],
    y = rnorm(5),
    z = runif(5) > 0.5
  ))

##   x        y    z
## 1 a  0.17581 TRUE
## 2 b  0.06894 TRUE
## 3 c  0.74217 TRUE
## 4 d  0.72816 TRUE
## 5 e -0.28940 TRUE

class(a_data_frame)
## [1] "data.frame"

Notice that each column can have a different type than the other columns, but that all the elements 
within a column are the same type. Also notice that the class of the object is data.frame, 
with a dot rather than a space.
In this example, the rows have been automatically numbered from one to five. 
If any of the input vectors had names, then the row names would have been taken from the 
first such vector. For example, if y had names, then those would be given to the data frame:
  y <- rnorm(5)
names(y) <- month.name[1:5]
data.frame(
  x = letters[1:5],
  y = y,
  z = runif(5) > 0.5
)
##          x       y     z
## January  a -0.9373 FALSE
## February b  0.7314  TRUE
## March    c -0.3030  TRUE
## April    d -1.3307 FALSE
## May      e -0.6857 FALSE
This behavior can be overridden by passing the argument row.names = NULL to the data.frame function:
  (a_data_frame = data.frame(
    x = letters[1:5],
    y = y,
    z = runif(5) > 0.5,
    row.names = NULL
  ))
##   x       y     z
## 1 a -0.9373 FALSE
## 2 b  0.7314 FALSE
## 3 c -0.3030  TRUE
## 4 d -1.3307  TRUE
## 5 e -0.6857 FALSE
It is also possible to provide your own row names by passing a vector to row.names. This vector 
will be converted to character, if it isn’t already that type:
  data.frame(
    x = letters[1:5],
    y = y,
    z = runif(5) > 0.5,
    row.names = c("Jackie", "Tito", "Jermaine", "Marlon", "Michael")
  )
##          x       y     z
## Jackie   a -0.9373  TRUE
## Tito     b  0.7314 FALSE
## Jermaine c -0.3030  TRUE
## Marlon   d -1.3307 FALSE
## Michael  e -0.6857 FALSE

rownames(a_data_frame)
## [1] "1" "2" "3" "4" "5"

colnames(a_data_frame)
## [1] "x" "y" "z"

dimnames(a_data_frame)
## [[1]]
## [1] "1" "2" "3" "4" "5"
##
## [[2]]
## [1] "x" "y" "z"

nrow(a_data_frame)
## [1] 5

ncol(a_data_frame)
## [1] 3

dim(a_data_frame)
## [1] 5 3

Indexing Data Frames
There are lots of different ways of indexing a data frame. To start with, pairs of the 
four different vector indices (positive integers, negative integers, logical values, 
                               and characters) can be used in exactly the same way as with matrices. 
These commands both select the second and third elements of the first two columns:
  a_data_frame[2:3, -3]
##   x       y
## 2 b 0.06894
## 3 c 0.74217

a_data_frame[c(FALSE, TRUE, TRUE, FALSE, FALSE), c("x", "y")]
##   x       y
## 2 b 0.06894
## 3 c 0.74217

Since more than one column was selected, the resultant subset is also a data frame. 
If only one column had been selected, the result would have been simplified to be a vector:
  class(a_data_frame[2:3, -3])
## [1] "data.frame"

class(a_data_frame[2:3, 1])
## [1] "factor"

If we only want to select one column, then list-style indexing (double square brackets with a positive 
                                                                integer or name, or the dollar sign 
                                                                operator with a name) can also be used. 
These commands all select the second and third elements of the first column:
  a_data_frame$x[2:3]
## [1] b c
## Levels: a b c d e

a_data_frame[[1]][2:3]
## [1] b c
## Levels: a b c d e

a_data_frame[["x"]][2:3]
## [1] b c
## Levels: a b c d e

a_data_frame[a_data_frame$y > 0 | a_data_frame$z, "x"]
## [1] a b c d e
## Levels: a b c d e

subset(a_data_frame, y > 0 | z, x)
##   x
## 1 a
## 2 b
## 3 c
## 4 d
## 5 e

Basic Data Frame Manipulation
Like matrices, data frames can be transposed using the t function, but in the process all the 
columns (which become rows) are converted to the same type, and the whole thing becomes a matrix:
  t(a_data_frame)
##   [,1]       [,2]       [,3]       [,4]       [,5]
## x "a"        "b"        "c"        "d"        "e"
## y " 0.17581" " 0.06894" " 0.74217" " 0.72816" "-0.28940"
## z "TRUE"     "TRUE"     "TRUE"     "TRUE"     "TRUE"

Data frames can also be joined together using cbind and rbind, assuming that they have the 
appropriate sizes. rbind is smart enough to reorder the columns to match. cbind doesn’t check 
column names for duplicates, though, so be careful with it:
  another_data_frame <- data.frame(  #same cols as a_data_frame, different order
    z = rlnorm(5),                   #lognormally distributed numbers
    y = sample(5),                   #the numbers 1 to 5, in some order
    x = letters[3:7]
  )
rbind(a_data_frame, another_data_frame)
##    x        y      z
## 1  a  0.17581 1.0000
## 2  b  0.06894 1.0000
## 3  c  0.74217 1.0000
## 4  d  0.72816 1.0000
## 5  e -0.28940 1.0000
## 6  c  1.00000 0.8714
## 7  d  3.00000 0.2432
## 8  e  5.00000 2.3498
## 9  f  4.00000 2.0263
## 10 g  2.00000 1.7145

cbind(a_data_frame, another_data_frame)
##   x        y    z      z y x
## 1 a  0.17581 TRUE 0.8714 1 c
## 2 b  0.06894 TRUE 0.2432 3 d
## 3 c  0.74217 TRUE 2.3498 5 e
## 4 d  0.72816 TRUE 2.0263 4 f
## 5 e -0.28940 TRUE 1.7145 2 g

Where two data frames share columns, they can be merged together using the merge function. 
merge provides a variety of options for doing database-style joins. To join two data frames, 
you need to specify which columns contain the key values to match up. 
By default, the merge function uses all the common columns from the two data frames, 
but more commonly you will just want to use a single shared ID column. 
In the following examples, we specify that the x column contains our IDs using the by argument:
  merge(a_data_frame, another_data_frame, by = "x")
##   x     y.x  z.x    z.y y.y
## 1 c  0.7422 TRUE 0.8714   1
## 2 d  0.7282 TRUE 0.2432   3
## 3 e -0.2894 TRUE 2.3498   5

merge(a_data_frame, another_data_frame, by = "x", all = TRUE)
##   x      y.x  z.x    z.y y.y
## 1 a  0.17581 TRUE     NA  NA
## 2 b  0.06894 TRUE     NA  NA
## 3 c  0.74217 TRUE 0.8714   1
## 4 d  0.72816 TRUE 0.2432   3
## 5 e -0.28940 TRUE 2.3498   5
## 6 f       NA   NA 2.0263   4
## 7 g       NA   NA 1.7145   2

# o Environments and Functions
Environments
All the variables that we create need to be stored somewhere, and that somewhere is an environment.
Environments themselves are just another type of variable — we can assign them, manipulate them, 
and pass them into functions as arguments, just like we would any other variable. 
They are closely related to lists in that they are used for storing different types of variables together. 
In fact, most of the syntax for lists also works for environments, and we can coerce a list to be 
an environment (and vice versa).
Usually, you won’t need to explicitly deal with environments. For example, when you assign a 
variable at the command prompt, it will automatically go into an environment called the global 
environment (also known as the user workspace). When you call a function, an environment is 
automatically created to store the function-related variables. Understanding the basics of 
environments can be useful, however, in understanding the scope of variables, and for examining 
the call stack when debugging your code.
Slightly annoyingly, environments aren’t created with the environment function (that function returns 
                                                                                the environment that contains a 
                                                                                particular function). 
Instead, what we want is new.env:
  an_environment <- new.env()
Assigning variables into environments works in exactly the same way as with lists. 
You can either use double square brackets or the dollar sign operator. As with lists, 
the variables can be of different types and sizes:
  
  an_environment[["pythag"]] <- c(12, 15, 20, 21) #See http://oeis.org/A156683
an_environment$root <- polyroot(c(6, -5, 1))

The assign function that we saw in Assigning Variables takes an optional environment argument that 
can be used to specify where the variable is stored:
  assign(
    "moonday",
    weekdays(as.Date("1969/07/20")),
    an_environment
  )
Retrieving the variables works in the same way — you can either use list-indexing syntax, 
or assign’s opposite, the get function:
  an_environment[["pythag"]]
## [1] 12 15 20 21

an_environment$root
## [1] 2+0i 3-0i

get("moonday", an_environment)
## [1] "Sunday"

The ls and ls.str functions also take an environment argument, allowing you to list their contents:
  ls(envir = an_environment)
## [1] "moonday" "pythag"  "root"

ls.str(envir = an_environment)
## moonday :  chr "Sunday"
## pythag :  num [1:4] 12 15 20 21
## root :  cplx [1:2] 2+0i 3-0i

We can test to see if a variable exists in an environment using the exists function:
  exists("pythag", an_environment)
## [1] TRUE

Conversion from environment to list and back again uses the obvious functions, as.list and as.environment. In the latter case, there is also a function list2env that allows for a little more flexibility in the creation of the environment:
  #Convert to list
  (a_list <- as.list(an_environment))
## $pythag
## [1] 12 15 20 21
##
## $moonday
## [1] "Sunday"
##
## $root
## [1] 2+0i 3-0i
#...and back again.  Both lines of code do the same thing.

as.environment(a_list)
## <environment: 0x000000004a6fe290>

list2env(a_list)
## <environment: 0x000000004ad10288>

All environments are nested, meaning that they must have a parent environment 
(the exception is a special environment called the empty environment that sits 
  at the top of the chain). 
By default, the exists and get functions will also look for variables in the 
parent environments. Pass inherits = FALSE to them to change this behavior so that 
they will only look in the environment that you’ve specified:
  nested_environment <- new.env(parent = an_environment)

exists("pythag", nested_environment)
## [1] TRUE

exists("pythag", nested_environment, inherits = FALSE)
## [1] FALSE

Shortcut functions are available to access both the global environment (where variables that you assign from the command prompt are stored) and the base environment (this contains functions and other variables from R’s base package, which provides basic functionality):
  non_stormers <<- c(3, 7, 8, 13, 17, 18, 21) #See http://oeis.org/A002312

get("non_stormers", envir = globalenv())
## [1]  3  7  8 13 17 18 21

head(ls(envir = baseenv()), 20)
##  [1] "-"                 "-.Date"            "-.POSIXt"
##  [4] "!"                 "!.hexmode"         "!.octmode"
##  [7] "!="                "$"                 "$.data.frame"
## [10] "$.DLLInfo"         "$.package_version" "$<-"
## [13] "$<-.data.frame"    "%%"                "%*%"
## [16] "%/%"               "%in%"              "%o%"
## [19] "%x%"               "&"

Functions
To create our own functions, we just assign them as we would any other variable. 
As an example, let’s create a function to calculate the length of the hypotenuse 
of a right-angled triangle (for simplicity, we’ll use the obvious algorithm; 
                            for real-world code, this doesn’t work well with very 
                            big and very small numbers, so you shouldn’t calculate 
                            hypotenuses this way):
  hypotenuse <- function(x, y)
  {
    sqrt(x ^ 2 + y ^ 2)
  }

hypotenuse(y = 24, x = 7)
## [1] 25

normalize <- function(x, m = mean(x), s = sd(x))
{
  (x - m) / s
}

normalized <- normalize(c(1, 3, 6, 10, 15))
mean(normalized)        #almost 0!
## [1] -5.573e-18

sd(normalized)
## 1

There is a little problem with our normalize function, though, which we can see if some of the elements of x are missing:
  normalize(c(1, 3, 6, 10, NA))
## [1] NA NA NA NA NA
If any elements of a vector are missing, then by default, mean and sd will both return NA. Consequently, our normalize function returns NA values everywhere. It might be preferable to have the option of only returning NA values where the input was NA. Both mean and sd have an argument, na.rm, that lets us remove missing values before any calculations occur. To avoid all the NA values, we could include such an argument in normalize:
  normalize <- function(x, m = mean(x, na.rm = na.rm),
                        s = sd(x, na.rm = na.rm), na.rm = FALSE)
  {
    (x - m) / s
  }
normalize(c(1, 3, 6, 10, NA))
## [1] NA NA NA NA NA
normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)
## [1] -1.0215 -0.5108  0.2554  1.2769      NA

This works, but the syntax is a little clunky. To save us having to explicitly type 
the names of arguments that aren’t actually used by the function (na.rm is only being 
                                                                  passed to mean and sd), 
R has a special argument, ..., that contains all the arguments that aren’t matched by 
position or name:
  normalize <- function(x, m = mean(x, ...), s = sd(x, ...), ...)
  {
    (x - m) / s
  }
normalize(c(1, 3, 6, 10, NA))
## [1] NA NA NA NA NA
normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)
## [1] -1.0215 -0.5108  0.2554  1.2769      NA

This function provides an alternative syntax for calling other functions, 
letting us pass the arguments as a list, rather than one at a time:
  do.call(hypotenuse, list(x = 3, y = 4)) #same as hypotenuse(3, 4)
## [1] 5

Perhaps the most common use case for do.call is with rbind. You can use these two 
functions together to concatenate several data frames or matrices together at once:
  dfr1 <- data.frame(x = 1:5, y = rt(5, 1))
dfr2 <- data.frame(x = 6:10, y = rf(5, 1, 1))
dfr3 <- data.frame(x = 11:15, y = rbeta(5, 1, 1))
do.call(rbind, list(dfr1, dfr2, dfr3)) #same as rbind(dfr1, dfr2, dfr3)
##     x        y
## 1   1  1.10440
## 2   2  0.87931
## 3   3 -1.18288
## 4   4 -1.04847
## 5   5  0.90335
## 6   6  0.27186
## 7   7  2.49953
## 8   8  0.89534
## 9   9  4.21537
## 10 10  0.07751
## 11 11  0.31153
## 12 12  0.29114
## 13 13  0.01079
## 14 14  0.97188
## 15 15  0.53498

we can also pass functions anonymously:
  x_plus_y <- function(x, y) x + y
do.call(x_plus_y, list(1:5, 5:1))
## [1] 6 6 6 6 6
#is the same as

do.call(function(x, y) x + y, list(1:5, 5:1))
## [1] 6 6 6 6 6
Functions that return functions are rarer, but no less valid for it. 
The ecdf function returns the empirical cumulative distribution function of a vector:
  (emp_cum_dist_fn <- ecdf(rnorm(50)))

plot(emp_cum_dist_fn)


# o Strings and Factors

As you’ve already seen, character vectors can be created with the c function. 
We can use single or double quotes around our strings, as long as they match, 
though double quotes are considered more standard:
  c(
    "You should use double quotes most of the time",
    'Single quotes are better for including " inside the string'
  )
## [1] "You should use double quotes most of the time"
## [2] "Single quotes are better for including \" inside the string"

The paste function combines strings together. Each vector passed to it has its elements 
recycled to reach the length of the longest input, and then the strings are concatenated, 
with a space separating them. We can change the separator by passing an argument 
called sep, or use the related function paste0 to have no separator. 
After all the strings are combined, the result can be collapsed into one string 
containing everything using the collapse argument:
  paste(c("red", "yellow"), "lorry")
## [1] "red lorry"    "yellow lorry"

paste(c("red", "yellow"), "lorry", sep = "-")
## [1] "red-lorry"    "yellow-lorry"

paste(c("red", "yellow"), "lorry", collapse = ", ")
## [1] "red lorry, yellow lorry"

paste0(c("red", "yellow"), "lorry")
## [1] "redlorry"    "yellowlorry"
The function toString is a variation of paste that is useful for printing vectors. It separates each element with a comma and a space, and can limit how much we print. In the following example, width = 40 limits the output to 40 characters:
  x <- (1:15) ^ 2
toString(x)
## [1] "1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225"
toString(x, width = 40)
## [1] "1, 4, 9, 16, 25, 36, 49, 64, 81, 100...."

cat is a low-level function that works similarly to paste, but with less formatting. 
You should rarely need to call it directly yourself, but it is worth being aware of, 
since it is the basis for most of the print functions. cat can also accept a 
file argument to write its output to a file:
  cat(c("red", "yellow"), "lorry")
## red yellow lorry

Usually, when strings are printed to the console they are shown wrapped in double quotes. 
By wrapping a variable in a call to the noquote function, we can suppress those quotes. 
This can make the text more readable in some instances:
  x <- c(
    "I", "saw", "a", "saw", "that", "could", "out",
    "saw", "any", "other", "saw", "I", "ever", "saw"
  )

y <- noquote(x)
x
##  [1] "I"     "saw"   "a"     "saw"   "that"  "could" "out"   "saw"
##  [9] "any"   "other" "saw"   "I"     "ever"  "saw"
y
##  [1] I     saw   a     saw   that  could out   saw   any   other saw
## [12] I     ever  saw

There are several functions for formatting numbers. formatC uses C-style formatting specifications that allow you to specify fixed or scientific formatting, the number of decimal places, and the width of the output. Whatever the options, the input should be one of the numeric types (including arrays), and the output is a character vector or array:
  pow <- 1:3
(powers_of_e <- exp(pow))
## [1]  2.718  7.389 20.086
formatC(powers_of_e)
## [1] "2.718" "7.389" "20.09"
formatC(powers_of_e, digits = 3)               #3 sig figs
## [1] "2.72" "7.39" "20.1"
formatC(powers_of_e, digits = 3, width = 10)   #preceding spaces
## [1] "      2.72" "      7.39" "      20.1"
formatC(powers_of_e, digits = 3, format = "e") #scientific formatting
## [1] "2.718e+00" "7.389e+00" "2.009e+01"
formatC(powers_of_e, digits = 3, flag = "+")   #precede +ve values with +
## [1] "+2.72" "+7.39" "+20.1"

The first argument to sprintf specifies a formatting string, with placeholders for other values. For example, %s denotes another string, %f and %e denote a floating-point number in fixed or scientific format, respectively, and %d represents an integer. Additional arguments specify the values to replace the placeholders. As with the paste function, shorter inputs are recycled to match the longest input:
  sprintf("%s %d = %f", "Euler's constant to the power", pow, powers_of_e)
## [1] "Euler's constant to the power 1 = 2.718282"
## [2] "Euler's constant to the power 2 = 7.389056"
## [3] "Euler's constant to the power 3 = 20.085537"

sprintf("To three decimal places, e ^ %d = %.3f", pow, powers_of_e)
## [1] "To three decimal places, e ^ 1 = 2.718"
## [2] "To three decimal places, e ^ 2 = 7.389"
## [3] "To three decimal places, e ^ 3 = 20.086"

sprintf("In scientific notation, e ^ %d = %e", pow, powers_of_e)
## [1] "In scientific notation, e ^ 1 = 2.718282e+00"
## [2] "In scientific notation, e ^ 2 = 7.389056e+00"
## [3] "In scientific notation, e ^ 3 = 2.008554e+01"

Alternative syntaxes for formatting numbers are provided with the format and prettyNum functions. 
format just provides a slightly different syntax for formatting strings, and has similar usage 
to formatC. prettyNum, on the other hand, is best for pretty formatting of very big or very small numbers:
  format(powers_of_e)
## [1] " 2.718" " 7.389" "20.086"

format(powers_of_e, digits = 3)                    #at least 3 sig figs
## [1] " 2.72" " 7.39" "20.09"

format(powers_of_e, digits = 3, trim = TRUE)       #remove leading zeros
## [1] "2.72"  "7.39"  "20.09"

format(powers_of_e, digits = 3, scientific = TRUE)
## [1] "2.72e+00" "7.39e+00" "2.01e+01"

prettyNum(
  c(1e10, 1e-20),
  big.mark   = ",",
  small.mark = " ",
  preserve.width = "individual",
  scientific = FALSE
)
## [1] "10,000,000,000"            "0.00000 00000 00000 00001"

There are some special characters that can be included in strings. For example, we can insert a tab character using \t. In the following example, we use cat rather than print, since print performs an extra conversion to turn \t from a tab character into a backslash and a “t.” The argument fill = TRUE makes cat move the cursor to a new line after it is finished:
  cat("foo\tbar", fill = TRUE)
## foo  bar
Moving the cursor to a new line is done by printing a newline character, \n

cat("foo\nbar", fill = TRUE)
## foo
## bar
Null characters, \0, are used to terminate strings in R’s internal code. It is an error to explicitly try to include them in a string (older versions of R will discard the contents of the string after the null character):
  cat("foo\0bar", fill = TRUE)  #this throws an error
Backslash characters need to be doubled up so that they aren’t mistaken for a special character. In this next example, the two input backslashes make just one backslash in the resultant string:
  cat("foo\\bar", fill = TRUE)
## foo\bar
If we are using double quotes around our string, then double quote characters need to be preceded by a backslash to escape them. Similarly, if we use single quotes around our strings, then single quote characters need to be escaped:
  cat("foo\"bar", fill = TRUE)
## foo"bar
cat('foo\'bar', fill = TRUE)
## foo'bar
In the converse case, including single quotes in double-quoted strings or double quotes inside single-quoted strings, we don’t need an escape backslash:
  cat("foo'bar", fill = TRUE)
## foo'bar
cat('foo"bar', fill = TRUE)
## foo"bar
We can make our computer beep by printing an alarm character, \a, though the function alarm will do this in a more readable way. This can be useful to add to the end of a long analysis to notify you that it’s finished (as long as you aren’t in an open-plan office):
  cat("\a")
alarm()

toupper("I'm Shouting")
## [1] "I'M SHOUTING"
tolower("I'm Whispering")
## [1] "i'm whispering"

Extracting substrings
There are two related functions for extracting substrings: substring and substr. In most cases, 
it doesn’t matter which you use, but they behave in slightly different ways when you pass 
vectors of different lengths as arguments. For substring, 
the output is as long as the longest input; for substr, the output is as long as the first input:

  woodchuck <- c(
    "How much wood would a woodchuck chuck",
    "If a woodchuck could chuck wood?",
    "He would chuck, he would, as much as he could",
    "And chuck as much wood as a woodchuck would",
    "If a woodchuck could chuck wood."
  )
substring(woodchuck, 1:6, 10)

## [1] "How much w" "f a woodc"  " would c"   " chuck "    " woodc"
## [6] "uch w"

substr(woodchuck, 1:6, 10)
## [1] "How much w" "f a woodc"  " would c"   " chuck "    " woodc"

Splitting Strings
The paste function and its friends combine strings together. strsplit does the opposite, breaking them apart at specified cut points. We can break the woodchuck tongue twister up into words by splitting it on the spaces. In the next example, fixed = TRUE means that the split argument is a fixed string rather than a regular expression:
  strsplit(woodchuck, " ", fixed = TRUE)
## [[1]]
## [1] "How"       "much"      "wood"      "would"     "a"         "woodchuck"
## [7] "chuck"
##
## [[2]]
## [1] "If"        "a"         "woodchuck" "could"     "chuck"     "wood?"
##
## [[3]]
##  [1] "He"     "would"  "chuck," "he"     "would," "as"     "much"
##  [8] "as"     "he"     "could"
##
## [[4]]
## [1] "And"       "chuck"     "as"        "much"      "wood"      "as"
## [7] "a"         "woodchuck" "would"
##
## [[5]]
## [1] "If"        "a"         "woodchuck" "could"     "chuck"     "wood."

In our example, the trailing commas on some words are a little annoying. It would be better to split on an optional comma followed by a space. This is easily specified using a regular expression. ? means “make the previous character optional”:
  strsplit(woodchuck, ",? ")
[[1]]
[1] "How"       "much"      "wood"      "would"     "a"         "woodchuck" "chuck"    

[[2]]
[1] "If"        "a"         "woodchuck" "could"     "chuck"     "wood?"    

[[3]]
[1] "He"    "would" "chuck" "he"    "would" "as"    "much"  "as"    "he"    "could"

[[4]]
[1] "And"       "chuck"     "as"        "much"      "wood"      "as"        "a"         "woodchuck" "would"    

[[5]]
[1] "If"        "a"         "woodchuck" "could"     "chuck"     "wood."    

Factors
Factors are a special variable type for storing categorical variables. They sometimes behave like strings, 
and sometimes like integers.
Creating Factors
Whenever you create a data frame with a column of text data, R will assume by default that the 
text is categorical data and perform some conversion. The following example dataset contains 
the heights of 10 random adults:
  (heights <- data.frame(
    height_cm = c(153, 181, 150, 172, 165, 149, 174, 169, 198, 163),
    gender = c(
      "female", "male", "female", "male", "male",
      "female", "female", "male", "male", "female"
    )
  ))
##    height_cm gender
## 1        153 female
## 2        181   male
## 3        150 female
## 4        172   male
## 5        165   male
## 6        149 female
## 7        174 female
## 8        169   male
## 9        198   male
## 10       163 female

By inspecting the class of the gender column we can see that it is not, as you may have expected, 
a character vector, but is in fact a factor:
  class(heights$gender)
## [1] "factor"

Printing the column reveals a little more about the nature of this factor:
  heights$gender
##  [1] female male   female male   male   female female male   male   female
## Levels: female male

Each value in the factor is a string that is constrained to be either “female,” “male,” or missing. 
This constraint becomes obvious if we try to add a different string to the genders:
  heights$gender[1] <- "Female"  #notice the capital "F"
## Warning: invalid factor level, NA generated

heights$gender
##  [1] <NA>   male   female male   male   female female male   male   female
## Levels: female male
The choices “female” and “male” are called the levels of the factor and can be retrieved 
with the levels function:
  levels(heights$gender)
## [1] "female" "male"

Outside of their automatic creation inside data frames, you can create factors using the factor 
function. The first (and only compulsory) argument is a character vector:
  gender_char <- c(
    "female", "male", "female", "male", "male",
    "female", "female", "male", "male", "female"
  )
(gender_fac <- factor(gender_char))

Changing Factor Levels
We can change the order of the levels when the factor is created by specifying a levels argument:
  factor(gender_char, levels = c("male", "female"))
##  [1] female male   female male   male   female female male   male   female
## Levels: male female

If we want to change the order of the factor levels after creation, we again use the factor function, 
this time passing in the existing factor (rather than a character vector):
  factor(gender_fac, levels = c("male", "female"))
##  [1] female male   female male   male   female female male   male   female
## Levels: male female
##  [1] female male   female male   male   female female male   male   female
## Levels: female male

The relevel function is an alternative way of changing the order of factor levels. 
In this case, it just lets you specify which level comes first. 
As you might imagine, the use case for this function is rather niche — it can come in 
handy for regression models where you want to compare different categories to a reference 
category. Most of the time you will be better off calling factor if you want to set the levels:
  relevel(gender_fac, "male")
##  [1] male   female male   female female male   male   female female male
## Levels: male female

Dropping Factor Levels
In the process of cleaning datasets, you may end up removing all the data corresponding to a factor level. Consider this dataset of times to travel into work using different modes of transport:
  getting_to_work <- data.frame(
    mode = c(
      "bike", "car", "bus", "car", "walk",
      "bike", "car", "bike", "car", "car"
    ),
    time_mins = c(25, 13, NA, 22, 65, 28, 15, 24, NA, 14)
  )
Not all the times have been recorded, so our first task is to remove the rows where time_mins is NA:
  (getting_to_work <- subset(getting_to_work, !is.na(time_mins)))
##    mode time_mins
## 1  bike        25
## 2   car        13
## 4   car        22
## 5  walk        65
## 6  bike        28
## 7   car        15
## 8  bike        24
## 10  car        14

Looking at the mode column, there are now just three different values, but we still have the 
same four levels in the factor. We can see this with the unique function (the levels 
                                                                          function will, of course, 
                                                                          also tell us the levels of the factor):
  unique(getting_to_work$mode)
## [1] bike car  walk
## Levels: bike bus car walk

If we want to drop the unused levels of the factor, we can use the droplevels function. 
This accepts either a factor or a data frame. In the latter case, it drops the unused levels 
in all the factors of the input. Since there is only one factor in our example data frame, 
the two lines of code in the next example are equivalent:
  getting_to_work$mode <- droplevels(getting_to_work$mode)
getting_to_work <- droplevels(getting_to_work)
levels(getting_to_work$mode)
## [1] "bike" "car"  "walk"

Ordered Factors
Some factors have levels that are semantically greater than or less than other levels. 
This is common with multiple-choice survey questions. For example, 
the survey question “How happy are you?” could have the possible responses 
“depressed,” “grumpy,” “so-so,” “cheery,” and ‘`ecstatic.’
The resulting variable is categorical, so we can create a factor with the five choices as levels.
Here we generate ten thousand random responses using the sample function:
happy_choices <- c("depressed", "grumpy", "so-so", "cheery", "ecstatic")
happy_values <- sample(
  happy_choices,
  10000,
  replace = TRUE
)
happy_fac <- factor(happy_values, happy_choices)
head(happy_fac)
## [1] grumpy    depressed cheery    ecstatic  grumpy    grumpy
## Levels: depressed grumpy so-so cheery ecstatic

## Levels: depressed < grumpy < so-so < cheery < ecstatic
An ordered factor is a factor, but a normal factor isn’t ordered:
  is.factor(happy_ord)
## [1] TRUE
is.ordered(happy_fac)
## [1] FALSE

In this case, the five choices have a natural ordering to them: “grumpy” is happier than 
“depressed,” “so-so” is happier than “grumpy,” and so on. This means that it is better to 
store the responses in an ordered factor. We can do this using the ordered function 
(or by passing the argument ordered = TRUE to factor):
happy_ord <- ordered(happy_values, happy_choices)
head(happy_ord)
## [1] grumpy    depressed cheery    ecstatic  grumpy    grumpy

Converting Continuous Variables to Categorical
A useful way of summarizing a numeric variable is to count how many values fall into different 
“bins.” The cut function cuts a numeric variable into pieces, returning a factor. 
It is commonly used with the table function to get counts of numbers in different groups. 
(The hist function, which draws histograms, provides an alternative way of doing this, 
  as does count in the plyr package, which we will see later.)
In the next example, we randomly generate the ages of ten thousand workers (from 16 to 66, 
                                                                            using a beta distribution) 
and put them in 10-year-wide groups:
  ages <- 16 + 50 * rbeta(10000, 2, 3)
grouped_ages <- cut(ages, seq.int(16, 66, 10))
head(grouped_ages)
## [1] (26,36] (16,26] (26,36] (26,36] (26,36] (46,56]
## Levels: (16,26] (26,36] (36,46] (46,56] (56,66]

table(grouped_ages)
## grouped_ages
## (16,26] (26,36] (36,46] (46,56] (56,66]
##    1844    3339    3017    1533     267

In this case, the bulk of the workforce falls into the 26-to-36 and 36-to-46 categories 
(as a direct consequence of the shape of our beta distribution).
Notice that ages is a numeric variable and grouped_ages is a factor:
  class(ages)
## [1] "numeric"
class(grouped_ages)
## [1] "factor"
Converting Categorical Variables to Continuous
The converse case of converting a factor into a numeric variable is most useful during data cleaning. 
If you have dirty data where numbers are mistyped, R may interpret them as strings and convert 
them to factors during the import process. In this next example, one of the numbers has a double 
decimal place. Import functions such as read.table, which we will look at in Chapter 12, would 
fail to parse such a string into numeric format, and default to making the column a character vector:
  dirty <- data.frame(
    x = c("1.23", "4..56", "7.89")
  )
To convert the x column to be numeric, the obvious solution is to call as.numeric. 
Unfortunately, it gives the wrong answer:
  as.numeric(dirty$x)
## [1] 1 2 3

Calling as.numeric on a factor reveals the underlying integer codes that the factor uses to 
store its data. In general, a factor f can be reconstructed from levels(f)[as.integer(f)].
To correctly convert the factor to numeric, we can first retrieve the values by converting 
the factor to a character vector. The second value is NA because 4..56 is not a genuine number:
  as.numeric(as.character(dirty$x))
## Warning: NAs introduced by coercion
## [1] 1.23   NA 7.89

This is slightly inefficient, since repeated values have to be converted multiple times. 
As the FAQ on R notes, it is better to convert the factor’s levels to be numeric, then reconstruct 
the factor as above:
  as.numeric(levels(dirty$x))[as.integer(dirty$x)]
## Warning: NAs introduced by coercion
## [1] 1.23   NA 7.89

Since this is not entirely intuitive, if you want to do this task regularly, you can wrap it into 
a function for convenience:
  factor_to_numeric <- function(f)
  {
    as.numeric(levels(f))[as.integer(f)]
  }
Generating Factor Levels
For balanced data, where there are an equal number of data points for each level, the gl function 
can be used to generate a factor. In its simplest form, the function takes an integer for the 
number of levels in the resultant factor, and another integer for how many times each level should 
be repeated. More commonly, you will want to set the names of the levels, which is achieved by 
passing a character vector to the labels argument. More complex level orderings, such as 
alternating values, can be created by also passing a length argument:
  gl(3, 2)
## [1] 1 1 2 2 3 3
## Levels: 1 2 3

gl(3, 2, labels = c("placebo", "drug A", "drug B"))
## [1] placebo placebo drug A  drug A  drug B  drug B
## Levels: placebo drug A drug B

gl(3, 1, 6, labels = c("placebo", "drug A", "drug B")) #alternating
## [1] placebo drug A  drug B  placebo drug A  drug B
## Levels: placebo drug A drug B

Combining Factors
Where we have multiple categorical variables, it is sometimes useful to combine them into a single factor, 
where each level consists of the interactions of the individual variables:
treatment <- gl(3, 2, labels = c("placebo", "drug A", "drug B"))
gender <- gl(2, 1, 6, labels = c("female", "male"))
interaction(treatment, gender)
## [1] placebo.female placebo.male   drug A.female  drug A.male
## [5] drug B.female  drug B.male
## 6 Levels: placebo.female drug A.female drug B.female ... drug B.male

# o Flow Control and Loops
Flow Control
There are many occasions where you don’t just want to execute one statement after another: 
  you need to control the flow of execution. Typically this means that you only want to 
execute some code if a condition is fulfilled.

if and else
  The simplest form of flow control is conditional execution using if. if takes a logical value 
(more precisely, a logical vector of length one) and executes the next statement only 
if that value is TRUE:
  if(TRUE) message("It was true!")
## It was true!
if(FALSE) message("It wasn't true!")
Missing values aren’t allowed to be passed to if; doing so throws an error:
  if(NA) message("Who knows if it was true?")
## Error: missing value where TRUE/FALSE needed

Where you may have a missing value, you should test for it using is.na:
  if(is.na(NA)) message("The value is missing!")
## The value is missing!

Of course, most of the time, you won’t be passing the actual values TRUE or FALSE. 
Instead you’ll be passing a variable or expression — if you knew that the statement was 
going to be executed in advance, you wouldn’t need the if clause. In this next example, 
runif(1) generates one uniformly distributed random number between 0 and 1. 
If that value is more than 0.5, then the message is displayed:
  if(runif(1) > 0.5) message("This message appears with a 50% chance.")

Multiple conditions can be defined by combining if and else repeatedly. Notice that if and else 
  remain two separate words — there is an ifelse function but it means something slightly different,
if(is.nan(x))
{
  message("x is missing")
} else if(is.infinite(x))
{
  message("x is infinite")
} else if(x > 0)
{
  message("x is positive")
} else if(x < 0)
{
  message("x is negative")
} else
{
  message("x is zero")
}
## x is positive
R, unlike many languages, has a nifty trick that lets you reorder the code and do conditional assignment. 
In the next example, Re returns the real component of a complex number (Im returns the imaginary component):
  x <- sqrt(-1 + 0i)
(reality <- if(Re(x) == 0) "real" else "imaginary")
## [1] "real"

Vectorized if
The standard if statement takes a single logical value. If you pass a logical vector with a 
length of more than one (don’t do this!), then R will warn you
if(c(TRUE, FALSE)) message("two choices")
## Warning: the condition has length > 1 and only the first element will be
## used
## two choices

Since much of R is vectorized, you may not be surprised to learn that it also has 
vectorized flow control, in the form of the ifelse function. ifelse takes three arguments. 
The first is a logical vector of conditions. The second contains values that are returned 
when the first vector is TRUE. The third contains values that are returned when the 
first vector is FALSE. In the following example, rbinom generates random numbers from a 
binomial distribution to simulate a coin flip:
  ifelse(rbinom(10, 1, 0.5), "Head", "Tail")
##  [1] "Head" "Head" "Head" "Tail" "Tail" "Head" "Head" "Head" "Tail" "Head"

ifelse can also accept vectors in the second and third arguments. These should be the same size 
as the first vector (if the vectors aren’t the same size, then elements in the second and 
                     third arguments are recycled or ignored to make them the same size as the first):
  (yn <- rep.int(c(TRUE, FALSE), 6))
##  [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE

ifelse(yn, 1:3, -1:-12)
##  [1]   1  -2   3  -4   2  -6   1  -8   3 -10   2 -12

If there are missing values in the condition argument, then the corresponding values 
in the result will be missing:
  yn[c(3, 6, 9, 12)] <- NA
ifelse(yn, 1:3, -1:-12)
##  [1]   1  -2  NA  -4   2  NA   1  -8  NA -10   2  NA

Multiple Selection
Code with many else statements can quickly become cumbersome to read. In such circumstances, 
prettier code can sometimes be achieved with a call to the switch function. 
The most common usage takes for its first argument an expression that returns a string, 
followed by several named arguments that provide results when the name matches the 
first argument. The names must match the first argument exactly, and you can execute 
multiple expressions by enclosing them in curly braces:
  (greek <- switch(
    "gamma",
    alpha = 1,
    beta  = sqrt(4),
    gamma =
      {
        a <- sin(pi / 3)
        4 * a ^ 2
      }
  ))
## [1] 3

switch can also take a first argument that returns an integer. In this case the remaining 
arguments do not need names — the next argument is executed if the first argument resolves 
to 1, the argument after that is executed if the first argument resolves to 2, and so on:
  switch(
    3,
    "first",
    "second",
    "third",
    "fourth"
  )
## [1] "third"
As you may have noticed, no default argument is possible in this case. It’s also rather 
cumbersome if you want to test for large integers, since you’ll need to provide many 
arguments. Under those circumstances it is best to convert the first argument to a string and 
use the first syntax:
  switch(
    as.character(2147483647),
    "2147483647" = "a big number",
    "another number"
  )
## [1] "a big number"

Loops
There are three kinds of loops in R: repeat, while, and for. Although vectorization means that 
you don’t need them as much in R as in other languages, they can still come in handy for 
repeatedly executing code.
repeat Loops
The easiest loop to master in R is repeat. All it does is execute the same code over and 
over until you tell it to stop. In other languages, it often goes by the name do while, 
or something similar. The following example will execute until you press Escape, quit R, or 
the universe ends, whichever happens first.

repeat
{
  message("Happy Valentine's Day!")
}
In general, we want our code to complete before the end of the universe, so it is possible to break 
out of the infinite loop by including a break statement. In the next example, sample returns 
one action in each iteration of the loop:
  repeat
  {
    message("Happy Valentine's Day!")
    action <- sample(
      c(
        "Learn R",
        "Eat an ice cream",
        "Rob a bank",
        "Win heart of your girlfriend"
      ),
      1
    )
    message("action = ", action)
    if(action == "Win heart of your girlfriend") break
  }

Sometimes, rather than breaking out of the loop we just want to skip the rest of the current iteration and start the next iteration:
  repeat
  {
    message("Happy Valentine's Day!")
    action <- sample(
      c(
        "Learn R",
        "Eat an ice cream",
        "Rob a bank",
        "Win heart of your girlfriend"
      ),
      1
    )
    if(action == "Rob a bank")
    {
      message("Quietly skipping to the next iteration")
      next
    }
    message("action = ", action)
    if(action == "Win heart of your girlfriend") break
  }

While loops
while loops are like backward repeat loops. Rather than executing some code and then checking 
to see if the loop should end, they check first and then (maybe) execute. Since the check 
happens at the beginning, it is possible that the contents of the loop will never be 
executed (unlike in a repeat loop). The following example behaves similarly to the repeat 
  example, except that if girlfirend's' heart is won straightaway, then the Valentine Day loop is 
completely avoided:
  action <- sample(
    c(
      "Learn R",
      "Eat an ice cream",
      "Rob a bank",
      "Win heart of your girlfriend"
    ),
    1
  )
while(action != "Win heart of your girlfriend")
{
  message("Happy Valentine's Day!")
  action <- sample(
    c(
      "Learn R",
      "Make an ice statue",
      "Rob a bank",
      "Win heart of your girlfriend"
    ),
    1
  )
  message("action = ", action)
}

for Loops
The third type of loop is to be used when you know exactly how many times you want the 
code to repeat. The for loop accepts an iterator variable and a vector. It repeats the 
loop, giving the iterator each element from the vector in turn. In the simplest case, 
the vector contains integers:
  for(i in 1:5) message("i = ", i)
## i = 1
## i = 2
## i = 3
## i = 4
## i = 5

If you wish to execute multiple expressions, as with other loops they must be surrounded by curly braces:
  for(i in 1:5)
  {
    j <- i ^ 2
    message("j = ", j)
  }
## j = 1
## j = 4
## j = 9
## j = 16
## j = 25

R’s for loops are particularly flexible in that they are not limited to integers, or even 
numbers in the input. We can pass character vectors, logical vectors, or lists:
  for(month in month.name)
  {
    message("The month of ", month)
  }
## The month of January
## The month of February
## The month of March
## The month of April
## The month of May
## The month of June
## The month of July
## The month of August
## The month of September
## The month of October
## The month of November
## The month of December

for(yn in c(TRUE, FALSE, NA))
{
  message("This statement is ", yn)
}
## This statement is TRUE
## This statement is FALSE
## This statement is NA

Replications
rep repeats its input several times. Another related function, replicate, calls an expression 
several times. Mostly, they do exactly the same thing. The difference occurs when random number 
generation is involved. Pretend for a moment that the uniform random number generation function, 
runif, isn’t vectorized. rep will repeat the same random number several times, but replicate gives 
a different number each time (for historical reasons, the order of the arguments is annoyingly back to front):
  rep(runif(1), 5)
## [1] 0.04573 0.04573 0.04573 0.04573 0.04573
replicate(5, runif(1))
## [1] 0.5839 0.3689 0.1601 0.9176 0.5388

replicate comes into its own in more complicated examples: its main use is in Monte Carlo analyses, 
where you repeat an analysis a known number of times, and each iteration is independent of the others.
This next example estimates a person’s time to commute to work via different methods of transport. 
It’s a little bit complicated, but that’s on purpose because that’s when replicate is most useful.
The time_for_commute function uses sample to randomly pick a mode of transport (car, bus, train, or bike), 
then uses rnorm or rlnorm to find a normally or lognormally distributed travel 
time (with parameters that depend upon the mode of transport):
  time_for_commute <- function()
  {
    #Choose a mode of transport for the day
    mode_of_transport <- sample(
      c("car", "bus", "train", "bike"),
      size = 1,
      prob = c(0.1, 0.2, 0.3, 0.4)
    )
    #Find the time to travel, depending upon mode of transport
    time <- switch(
      mode_of_transport,
      car   = rlnorm(1, log(30), 0.5),
      bus   = rlnorm(1, log(40), 0.5),
      train = rnorm(1, 30, 10),
      bike  = rnorm(1, 60, 5)
    )
    names(time) <- mode_of_transport
    time
  }
The presence of a switch statement makes this function very hard to vectorize. That means that to 
find the distribution of commuting times, we need to repeatedly call time_for_commute to generate 
data for each day. replicate gives us instant vectorization:
  replicate(5, time_for_commute())
##  bike   car train   bus  bike
## 66.22 35.98 27.30 39.40 53.81

The simplest and most commonly used family member is lapply, short for “list apply.” 
lapply takes a list and a function as inputs, applies the function to each element of the 
list in turn, and returns another list of results. Example: a prime factorization list:
  prime_factors <- list(
    two   = 2,
    three = 3,
    four  = c(2, 2),
    five  = 5,
    six   = c(2, 3),
    seven = 7,
    eight = c(2, 2, 2),
    nine  = c(3, 3),
    ten   = c(2, 5)
  )
head(prime_factors)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7

unique_primes <- vector("list", length(prime_factors))
for(i in seq_along(prime_factors))
{
  unique_primes[[i]] <- unique(prime_factors[[i]])
}
names(unique_primes) <- names(prime_factors)
unique_primes

lapply(prime_factors, unique)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5

When the return value from the function is the same size each time, and you know what that size is, 
you can use a variant of lapply called vapply. vapply stands for “list apply that returns a vector.” 
As before, you pass it a list and a function, but vapply takes a third argument that is a template 
for the return values. Rather than returning a list, it simplifies the result to be a vector or an array:
  vapply(prime_factors, length, numeric(1))
##   two three  four  five   six seven eight  nine   ten
##     1     1     2     1     2     1     3     2     2

There is another function that lies in between lapply and vapply: namely sapply, 
which stands for “simplifying list apply.” Like the two other functions, sapply takes a list 
and a function as inputs. It does not need a template, but will try to simplify the 
result to an appropriate vector or array if it can:
  sapply(prime_factors, unique)  #returns a list
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5

sapply(prime_factors, length)  #returns a vector
##   two three  four  five   six seven eight  nine   ten
##     1     1     2     1     2     1     3     2     2

sapply(prime_factors, summary) #returns an array
##         two three four five  six seven eight nine  ten
## Min.      2     3    2    5 2.00     7     2    3 2.00
## 1st Qu.   2     3    2    5 2.25     7     2    3 2.75
## Median    2     3    2    5 2.50     7     2    3 3.50
## Mean      2     3    2    5 2.50     7     2    3 3.50
## 3rd Qu.   2     3    2    5 2.75     7     2    3 4.25
## Max.      2     3    2    5 3.00     7     2    3 5.00

For interactive use, this is wonderful because you usually automatically get the result 
in the form that you want. This function does require some care if you aren’t sure about 
what your inputs might be, though, since the result is sometimes a list and sometimes a 
vector. This can trip you up in some subtle ways. Our previous length example returned a 
vector, but look what happens when you pass it an empty list:
  sapply(list(), length)
## list()

If the input list has length zero, then sapply always returns a list, regardless of the function 
that is passed. So if your data could be empty, and you know the return value, it is safer to 
use vapply:
  vapply(list(), length, numeric(1))
## numeric(0)

You may have noticed that in all of our examples, the functions passed to lapply, vapply, 
and sapply have taken just one argument. There is a limitation in these functions in that 
you can only pass one vectorized argument (more on how to circumvent that later), 
but you can pass other scalar arguments to the function. To do this, just pass in named arguments 
to the lapply (or sapply or vapply) call, and they will be passed to the inner function. 
For example, if rep.int takes two arguments, but the times argument is allowed to be a 
single (scalar) number, you’d type:
  complemented <- c(2, 3, 6, 18)        
lapply(complemented, rep.int, times = 4)
## [[1]]
## [1] 2 2 2 2
##
## [[2]]
## [1] 3 3 3 3
##
## [[3]]
## [1] 6 6 6 6
##
## [[4]]
## [1] 18 18 18 18

What if the vector argument isn’t the first one? In that case, we have to create our own 
function to wrap the function that we really wanted to call. You can do this on a separate 
line, but it is common to include the function definition within the call to lapply:
  rep4x <- function(x) rep.int(4, times = x)
lapply(complemented, rep4x)
## [[1]]
## [1] 4 4
##
## [[2]]
## [1] 4 4 4
##
## [[3]]
## [1] 4 4 4 4 4 4
##
## [[4]]
##  [1] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4

This last code chunk can be made a little simpler by passing an anonymous function to lapply. 
This is the trick where we don’t bother with a separate assignment line and just pass the 
function to lapply without giving it a name:
  lapply(complemented, function(x) rep.int(4, times = x))
## [[1]]
## [1] 4 4
##
## [[2]]
## [1] 4 4 4
##
## [[3]]
## [1] 4 4 4 4 4 4
##
## [[4]]
##  [1] 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4

Very, very occasionally, you may want to loop over every variable in an environment,
rather than in a list. There is a dedicated function, eapply, for this, though in 
recent versions of R you can also use lapply:
  env <- new.env()
env$test1 <- c(1, 0, 1, 0, 1, 1, 2, 1, 3) 
env$test2 <- c("Really", "leery", "rarely", "Larry")
eapply(env, length)
## $test1
## [1] 9
##
## $test2
## [1] 4

lapply(env, length) #same
## $test1
## [1] 9
##
## $test2
## [1] 4

Looping Over Arrays
lapply, and its friends vapply and sapply, can be used on matrices and arrays, but their behavior 
often isn’t what we want. The three functions treat the matrices and arrays as though 
they were vectors, applying the target function to each element one at a time 
(moving down columns). More commonly, when we want to apply a function to an array, 
we want to apply it by row or by column. This next example uses the matlab package, 
which gives some functionality ported from the rival language.
To run the next example, you first need to install the matlab package:
  install.packages("matlab")
library(matlab)

When you load the matlab package, it overrides some functions in the base, stats, and utils 
packages to make them behave like their MATLAB counterparts. After these examples that use 
the matlab package, you may wish to restore the usual behavior by unloading the 
package. Call detach("package:matlab") to do this.

The magic function creates a magic square — an n-by-n square matrix of the numbers from 
1 to n^2, where each row and each column has the same total:
  (magic4 <- magic(4))

rowSums(magic4)
## [1] 34 34 34 34
But what if we want to calculate a different statistic for each row? It would be cumbersome 
to try to provide a function for every such possibility. The apply function provides the 
row/column-wise equivalent of lapply, taking a matrix, a dimension number, and a function 
as arguments. The dimension number is 1 for “apply the function across each row,” or 2 for 
“apply the function down each column” (or bigger numbers for higher-dimensional arrays):
  apply(magic4, 1, sum)      #same as rowSums
## [1] 34 34 34 34
apply(magic4, 1, toString)
## [1] "16, 2, 3, 13" "5, 11, 10, 8" "9, 7, 6, 12"  "4, 14, 15, 1"

apply(magic4, 2, toString)
## [1] "16, 5, 9, 4"  "2, 11, 7, 14" "3, 10, 6, 15" "13, 8, 12, 1"

apply can also be used on data frames, though the mixed-data-type nature means that this is 
less common (for example, you can’t sensibly calculate a sum or a product when there are 
             character columns):
  (raj_kapoor_sons <- data.frame(
    name             = c("Randhir", "Rishi", "Rajiv"),
    date_of_birth    = c(
      "1947-Feb-15", "1952-Sept-04", "1962-Aug-25"
    ),
    n_spouses        = c(1, 1, 1),
    n_children       = c(2, 1, 0),
    stringsAsFactors = FALSE
  ))
## name date_of_birth n_spouses n_children
## 1 Randhir   1947-Feb-15         1          2
## 2   Rishi  1952-Sept-04         1          1
## 3   Rajiv   1962-Aug-25         1          0

apply(raj_kapoor_sons, 1, toString)
## [1] "Randhir, 1947-Feb-15, 1, 2" "Rishi, 1952-Sept-04, 1, 1"  "Rajiv, 1962-Aug-25, 1, 0"

apply(raj_kapoor_sons, 2, toString)
## name                            date_of_birth 
## "Randhir, Rishi, Rajiv" "1947-Feb-15, 1952-Sept-04, 1962-Aug-25" 
## n_spouses                               n_children 
## "1, 1, 1"                                "2, 1, 0" 

When applied to a data frame by column, apply behaves identically to sapply 
(remember that data frames can be thought of as nonnested lists where the elements 
  are of the same length):
  sapply(raj_kapoor_sons, toString)
## name                            date_of_birth 
## "Randhir, Rishi, Rajiv" "1947-Feb-15, 1952-Sept-04, 1962-Aug-25" 
## n_spouses                               n_children 
## "1, 1, 1"                                "2, 1, 0" 

Of course, simply printing a dataset in different forms isn’t that interesting. 
Using sapply combined with range, on the other hand, is a great way to quickly determine the 
extent of your data:
  sapply(raj_kapoor_sons, range)
##      name    date_of_birth n_spouses n_children
## [1,] "Rajiv" "1947-Feb-15" "1"       "0"       
## [2,] "Rishi" "1962-Aug-25" "1"       "2"

The function mapply, short for “multiple argument list apply,” lets you pass in as many 
vectors as you like, solving the first problem. A common usage is to pass in a list in 
one argument and the names of that list in another, solving the second problem. One little 
annoyance is that in order to accommodate an arbitrary number of vector arguments, the 
order of the arguments has been changed. For mapply, the function is passed as the first argument:
  msg <- function(name, factors)
  {
    ifelse(
      length(factors) == 1,
      paste(name, "is prime"),
      paste(name, "has factors", toString(factors))
    )
  }
mapply(msg, names(prime_factors), prime_factors)
##                         two                       three
##              "two is prime"            "three is prime"
##                        four                        five
##     "four has factors 2, 2"             "five is prime"
##                         six                       seven
##      "six has factors 2, 3"            "seven is prime"
##                       eight                        nine
## "eight has factors 2, 2, 2"     "nine has factors 3, 3"
##                         ten
##      "ten has factors 2, 5"

Instant Vectorization
The function Vectorize is a wrapper to mapply that takes a function that usually accepts a scalar input, and returns a new function that accepts vectors. This next function is not vectorized because of its use of switch, which requires a scalar input:
  baby_gender_report <- function(gender)
  {
    switch(
      gender,
      male   = "It's a boy!",
      female = "It's a girl!",
      "Um..."
    )
  }
If we pass a vector into the function, it will throw an error:
  genders <- c("male", "female", "other")
baby_gender_report(genders)
While it is theoretically possible to do a complete rewrite of a function that is inherently 
vectorized, it is easier to use the Vectorize function:
  vectorized_baby_gender_report <- Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)
##           male         female          other
##  "It's a boy!" "It's a girl!"        "Um..."

Split-Apply-Combine
A really common problem when investigating data is how to calculate some statistic on a 
variable that has been split into groups. Here are some scores on the classic road safety 
awareness computer game, Frogger:
  (ipl_scores <- data.frame(
    player = rep(c("Virat", "Dhoni", "Ajinkya"), times = c(2, 5, 3)),
    score  = round(rlnorm(10, 8), -1)
  ))
## player score
## 1    Virat  4540
## 2    Virat  1020
## 3    Dhoni  2900
## 4    Dhoni  1960
## 5    Dhoni   880
## 6    Dhoni  5300
## 7    Dhoni 13690
## 8  Ajinkya  3100
## 9  Ajinkya  2980
## 10 Ajinkya  3920

If we want to calculate the mean score for each player, then there are three steps. First, 
we split the dataset by player:
  (scores_by_player <- with(
    ipl_scores,
    split(score, player)
  ))
## $Ajinkya
## [1] 3100 2980 3920
## 
## $Dhoni
## [1]  2900  1960   880  5300 13690
## 
## $Virat
## [1] 4540 1020

Next we apply the (mean) function to each element:
  (list_of_means_by_player <- lapply(scores_by_player, mean))
## $Ajinkya
## [1] 3333.333
## 
## $Dhoni
## [1] 4946
##
## $Virat
## [1] 2780

Finally, we combine the result into a single vector:
  (mean_by_player <- unlist(list_of_means_by_player))
## Ajinkya    Dhoni    Virat 
## 3333.333 4946.000 2780.000 

The last two steps can be condensed into one by using vapply or sapply, but split-apply-combine 
is such a common task that we need something easier. That something is the tapply function, 
which performs all three steps in one go:
  with(ipl_scores, tapply(score, player, mean))
## Ajinkya    Dhoni    Virat 
## 3333.333 4946.000 2780.000 

There are a few other wrapper functions to tapply, namely by and aggregate. They perform 
the same function with a slightly different interface.

The plyr Package
The *apply family of functions are mostly wonderful, but they have three drawbacks that stop 
them being as easy to use as they could be. Firstly, the names are a bit obscure. 
The “l” in lapply for lists makes sense, but after using R for nine years, I still don’t 
know what the “t” in tapply stands for.
Secondly, the arguments aren’t entirely consistent. Most of the functions take a data object 
first and a function argument second, but mapply swaps the order, and tapply takes the 
function for its third argument. The data argument is sometimes X and sometimes object, 
and the simplification argument is sometimes simplify and sometimes SIMPLIFY.
Thirdly, the form of the output isn’t as controllable as it could be. Getting your results as a 
data frame — or discarding the result — takes a little bit of effort.
This is where the plyr package comes in handy. The package contains a set of functions 
named **ply, where the blanks (asterisks) denote the form of the input and output, 
respectively. So, llply takes a list input, applies a function to each element, 
and returns a list, making it a drop-in replacement for lapply:
  library(plyr)
llply(prime_factors, unique)
## $two
## [1] 2
##
## $three
## [1] 3
##
## $four
## [1] 2
##
## $five
## [1] 5
##
## $six
## [1] 2 3
##
## $seven
## [1] 7
##
## $eight
## [1] 2
##
## $nine
## [1] 3
##
## $ten
## [1] 2 5

laply(prime_factors, length)
## [1] 1 1 2 1 2 1 3 2 2

laply(list(), length)
## logical(0)

raply replaces replicate (not rapply!), but there are also rlply and rdply functions 
that let you return the result in list or data frame form, and an r_ply function 
that discards the result (useful for drawing plots):
  raply(5, runif(1))  #array output
## [1] 0.009415 0.226514 0.133015 0.698586 0.112846
rlply(5, runif(1))  #list output
## [[1]]
## [1] 0.6646
##
## [[2]]
## [1] 0.2304
##
## [[3]]
## [1] 0.613
##
## [[4]]
## [1] 0.5532
##
## [[5]]
## [1] 0.3654

rdply(5, runif(1))  #data frame output
##   .n     V1
## 1  1 0.9068
## 2  2 0.0654
## 3  3 0.3788
## 4  4 0.5086
## 5  5 0.3502

r_ply(5, runif(1))  #discarded output
## NULL

Perhaps the most commonly used function in plyr is ddply, which takes data frames as inputs 
and outputs and can be used as a replacement for tapply. Its big strength is that it 
makes it easy to make calculations on several columns at once. Let’s add a level column 
to the Frogger dataset, denoting the level the player reached in the game:
  ipl_scores$level <- floor(log(ipl_scores$score))

There are several different ways of calling ddply. All methods take a data frame, 
the name of the column(s) to split by, and the function to apply to each piece. 
The column is passed without quotes, but wrapped in a call to the . function.
For the function, you can either use colwise to tell ddply to call the function on every 
column (that you didn’t mention in the second argument), or use summarize and specify 
manipulations of specific columns:
  ddply(
    ipl_scores,
    .(player),
    colwise(mean) #call mean on every column except player
  )
## player    score    level
## 1 Ajinkya 3333.333 7.666667
## 2   Dhoni 4946.000 7.400000
## 3   Virat 2780.000 7.000000
ddply(
  ipl_scores,
  .(player),
  summarize,
  mean_score = mean(score), #call mean on score
  max_level  = max(level)   #... and max on level
)
##    player mean_score max_level
## 1 Ajinkya   3333.333         8
## 2   Dhoni   4946.000         9
## 3   Virat   2780.000         8

Packages
R is not limited to the code provided by the R Core Team. It is very much a community effort, 
and there are thousands of add-on packages available to extend it. The majority of R packages 
are currently installed in an online repository called CRAN (the Comprehensive R Archive Network), 
which is maintained by the R Core Team. Installing and using these add-on packages is an 
important part of the R experience.

We’ve just seen the plyr package for advanced looping. Throughout the rest of the course, 
we’ll see many more common packages: lubridate for date and time manipulation, 
xlsx for importing Excel files, reshape2 for manipulating the shape of data frames, 
ggplot2 for plotting etc

Loading Packages
To load a package that is already installed on your machine, you call the library function. 
It is widely agreed that calling this function library was a mistake, and that calling 
it load_package would have saved a lot of confusion, but the function has existed long 
enough that it is too late to change it now.

A package is a collection of R functions and datasets, and a library is a folder on 
your machine that stores the files for a package.

library(lattice)
We can now use all the functions provided by lattice. For example, below displays a fancy dot plot of the 
famous Immer’s barley dataset:
  dotplot(
    variety ~ yield | site,
    data   = barley,
    groups = year
  )
Note
The lattice package is covered in detail in later.
Notice that the name of the package is passed to library without being enclosed in quotes. 
If you want to programmatically pass the name of the package to library, then you can set the 
argument character.only = TRUE. This is mildly useful if you have a lot of packages to load:
  pkgs <- c("lattice", "utils", "rpart")
for(pkg in pkgs)
{
  library(pkg, character.only = TRUE
}

If you use library to try to load a package that isn’t installed, then it will throw an 
error. Sometimes you might want to handle the situation differently, in which case the 
require function provides an alternative. Like library, require loads a package, but rather 
than throwing an error it returns TRUE or FALSE

You can see the packages that are loaded with the search function:
  search()
## [1] ".GlobalEnv"        "package:lattice"   "package:plyr"      "package:matlab"    "tools:rstudio"    
## [6] "package:stats"     "package:graphics"  "package:grDevices" "package:utils"     "package:datasets" 
## [11] "package:methods"   "Autoloads"         "package:base" 

This list shows the order of places that R will look to try to find a variable. The global 
environment always comes first, followed by the most recently loaded packages. The last 
two values are always a special environment called Autoloads, and the base package. 
If you define a variable called var in the global environment, R will find that before it 
finds the usual variance function in the stats package, because the global environment 
comes first in the search list.

The function installed.packages returns a data frame with information about all the packages
that R knows about on your machine. If you’ve been using R for a while, this can easily 
be several hundred packages, so it is often best to view the results away from the console:
  View(installed.packages())

The packages that come with the R install (base, stats, and nearly 30 others) are stored in the library subdirectory of wherever you installed R. You can retrieve the location of this with:
  R.home("library")   #or
## [1] "/usr/lib/R/library"
.Library
## [1] "/usr/lib/R/library"

You also get a user library for installing packages that will only be accessible by you. 
(This is useful if you install on a family PC and don’t want your six-year-old to update 
  packages and break compatibility in your code.) The location is OS dependent. 
Under Windows, for R version x.y.z, it is in the R/win-library/x.y subfolder of the 
home directory, where the home directory can be found via:
  
  path.expand("~")    #or
## [1] "C:\\Users\\richie\\Documents"
Sys.getenv("HOME")
## [1] "C:\\Users\\richie\\Documents"

Under Linux, the folder is similarly located in the R/R.version$platform-library/x.y 
subfolder of the home directory. R.version$platform will typically return a string like 
“i686-pc-linux-gnu,” and the home directory is found in the same way as under Windows. 
Under Mac OS X, it is found in Library/R/x.y/library.
One problem with the default setup of library locations is that when you upgrade R, 
you need to reinstall all your packages. This is the safest behavior, since different 
versions of R will often need different versions of packages. In practice, on a 
development machine the convenience of not having to reinstall packages often outweighs 
versioning worries. To make life easier for yourself, it’s a very good idea to create your 
own library that can be used by all versions of R. The simplest way of doing this is to 
define an environment variable named R_LIBS that contains a path to your desired library 
location. Although you can define environment variables programmatically with R, 
they are only available to R, and only for the rest of the session — define them from 
within your operating system instead.
You can see a character vector of all the libraries that R knows about using the .libPaths function:
  .libPaths()
## [1] "D:/R/library"
## [2] "C:/Program Files/R/R-devel/library"
The first value in this vector is the most important, as this is where packages will be
installed by default.
  
Installing packages
install.packages(
  c("xts", "zoo"),
  repos = "http://www.stats.bris.ac.uk/R/"
)
To install to a different location, you can pass the lib argument to install.packages:
  install.packages(
    c("xts", "zoo"),
    lib   = "some/other/folder/to/install/to",
    repos = "http://www.stats.bris.ac.uk/R/"
  )
Obviously, you need a working Internet connection for R to be able to download packages, 
and you need sufficient permissions to be able to write files to the library folder. 
Inside corporate networks, R’s access to the Internet may be restricted. Under Windows, 
you can get R to use internet2.dll to access the Internet, making it appear as though 
it is Internet Explorer and often bypassing restrictions. To achieve this, type:
  setInternet2()

To install a package directly from GitHub, you first need to install the devtools package:
  install.packages("devtools")
The install_github function accepts the name of the GitHub repository that contains the package (usually the same as the name of the package itself) and the name of the user that maintains that repository. For example, to get the development version of the reporting package knitr, type:
  library(devtools)
install_github("knitr", "yihui")

Packrat
-------
You’re getting ready to start a new project, so you create a new directory that will eventually 
contain all the .R scripts, CSV data, and other files that are needed for this particular project.

You know you’re going to need to make use of several R packages over the course of this 
project. So before you write your first line of code, set up the project directory 
to use Packrat with packrat::init:
  install.packages("packrat")

Adding these packages to packrat:
  _         
packrat   0.5.0

Fetching sources for packrat (0.5.0) ... OK (CRAN current)
Snapshot written to '/home/watts/lal/Kaggle/test/R-test/packrat/packrat.lock'
Installing packrat (0.5.0) ... 
OK (built source)
Initialization complete!
  
  Restarting R session...
packrat::init("~/Kaggle/test/R-test")
packrat::on()
Initializing packrat project in directory:
  - "~/lal/Kaggle/test/R-test"
Packrat mode off. Resetting library paths to:
  - "/home/watts/R/x86_64-pc-linux-gnu-library/3.4"
- "/usr/local/lib/R/site-library"
- "/usr/lib/R/site-library"
- "/usr/lib/R/library"
Initialization complete!
init complete!
  Packrat mode on. Using library in directory:
  - "~/projects/babynames/packrat/lib" 
(Tip: If the current working directory is the project directory, you can omit the path.)

After initializing the project, you will be placed into packrat mode in the project directory. 
You’re ready to go!
  
  You’re no longer in an ordinary R project; you’re in a Packrat project. The main difference 
is that a packrat project has its own private package library. Any packages you install from 
inside a packrat project are only available to that project; and packages you install outside 
of the project are not available to the project.

This is what we mean by “isolation” and it’s a Very Good Thing, as it means that upgrading 
a package for one project won’t break a totally different project that just happens to 
reside on the same machine, even if that package contained incompatible changes.

Date and Time Classes
There are three date and time classes that come with R: POSIXct, POSIXlt, and Date

POSIX Dates and Times
POSIX dates and times are classic R: brilliantly thorough in their implementation, navigating 
all sorts of obscure technical issues, but with awful Unixy names that make everything seem 
more complicated than it really is.
The two standard date-time classes in R are POSIXct and POSIXlt. POSIX is a set of standards 
that defines compliance with Unix, including how dates and times should be specified. 
ct is short for “calendar time,” and the POSIXct class stores dates as the number of seconds 
since the start of 1970, in the Coordinated Universal Time (UTC) zone.
POSIXlt stores dates as a list, with components for seconds, minutes, hours, day of month, etc. 
POSIXct is best for storing dates and calculating with them, whereas POSIXlt is best for 
extracting specific parts of a date.
The function Sys.time returns the current date and time in POSIXct form:
  
  (now_ct <- Sys.time())
## "2019-04-28 15:18:00 IST"

The class of now_ct has two elements. It is a POSIXct variable, and POSIXct is inherited 
from the class POSIXt:
  class(now_ct)
## [1] "POSIXct" "POSIXt"

When a date is printed, you just see a formatted version of it, so it isn’t obvious how 
the date is stored. By using unclass, we can see that it is indeed just a number:
  unclass(now_ct)
## [1] 1556444881

When printed, the POSIXlt date looks exactly the same, but underneath the storage mechanism 
is very different:
  (now_lt <- as.POSIXlt(now_ct))
## [1] "2019-04-28 15:18:00 IST"

class(now_lt)
## [1] "POSIXlt" "POSIXt"

unclass(now_lt)
# $sec
# [1] 0.837276
# 
# $min
# [1] 18
# 
# $hour
# [1] 15
# 
# $mday
# [1] 28
# 
# $mon
# [1] 3
# 
# $year
# [1] 119
# 
# $wday
# [1] 0
# 
# $yday
# [1] 117
# 
# $isdst
# [1] 0
# 
# $zone
# [1] "IST"
# 
# $gmtoff
# [1] 19800
# 
# attr(,"tzone")
# [1] ""    "IST" "IST"

You can use list indexing to access individual components of a POSIXlt date:
  now_lt$sec
## [1] 0.837276

now_lt[["min"]]
## [1] 18

The Date Class
The third date class in base R is slightly better-named: it is the Date class. This stores 
dates as the number of days since the start of 1970. The Date class is best used when you 
don’t care about the time of day. Fractional days are possible (and can be generated by 
                                                                calculating a mean Date, for example), 
but the POSIX classes are better for those situations:
  (now_date <- as.Date(now_ct))
## [1] "2019-04-28"

class(now_date)
## [1] "Date"

unclass(now_date)
## [1] 18014

Parsing dates
------------
  When we read in dates from a text or spreadsheet file, they will typically be stored as a 
character vector or factor. To convert them to dates, we need to parse these strings. 
This can be done with another appallingly named function, strptime (short for “string parse time”), 
which returns POSIXlt dates. (There are as.POSIXct and as.POSIXlt functions too. If you call 
                              them on character inputs, then they are just wrappers around strptime.) 
To parse the dates, you must tell strptime which bits of the string correspond to which bits 
of the date.

In the following example, %H is the hour (24-hour system), %M is the minute, %S is the second, 
%m is the number of the month, %d (as previously discussed) is the day of the month, 
and %Y is the four-digit year. The complete list of component specifiers varies from system 
to system. See the ?strptime help page for the details:
  moon_landings_str <- c(
    "20:17:40 20/07/1969",
    "06:54:35 19/11/1969",
    "09:18:11 05/02/1971",
    "22:16:29 30/07/1971",
    "02:23:35 21/04/1972",
    "19:54:57 11/12/1972"
  )
(moon_landings_lt <- strptime(
  moon_landings_str,
  "%H:%M:%S %d/%m/%Y",
  tz = "UTC"
))
## [1] "1969-07-20 20:17:40 UTC" "1969-11-19 06:54:35 UTC"
## [3] "1971-02-05 09:18:11 UTC" "1971-07-30 22:16:29 UTC"
## [5] "1972-04-21 02:23:35 UTC" "1972-12-11 19:54:57 UTC"

Formatting dates
strftime(now_ct, "It's %I:%M%p on %A %d %B, %Y.")
## [1] "It's 03:18PM on Sunday 28 April, 2019."

strftime(now_ct, tz = "America/Los_Angeles")
## [1] "2019-04-28 02:48:00"
strftime(now_ct, tz = "Africa/Brazzaville")
## [1] "2019-04-28 10:48:00"
strftime(now_ct, tz = "Asia/Kolkata")
## [1] "2019-04-28 15:18:00"
strftime(now_ct, tz = "Australia/Adelaide")
## [1] "2019-04-28 19:18:00"

The next most reliable method is to give a manual offset from UTC, in the form "UTC"+n" 
or "UTC"-n". Negative times are east of UTC, and positive times are west. The manual nature 
at least makes it clear how the times are altered, but you have to manually do the 
daylight savings corrections too, so this method should be used with care. 
Recent versions of R will warn that the time zone is unknown, but will perform the offset correctly:
  strftime(now_ct, tz = "UTC-5")
## Warning: unknown timezone 'UTC-5'
## [1] "2019-04-28 14:48:00"

strftime(as.POSIXct(now_lt), tz = "Asia/Tokyo")
## [1] "2013-07-18 06:47:01"

strftime(as.POSIXct(moon_landings_lt), tz = "Asia/Kolkata")
## [1] "1969-07-21 01:47:40" "1969-11-19 12:24:35" "1971-02-05 14:48:11" "1971-07-31 03:46:29" "1972-04-21 07:53:35"
## [6] "1972-12-12 01:24:57"

Arithmetic with Dates and Times
R supports arithmetic with each of the three base classes. Adding a number to a POSIX date shifts 
it by that many seconds. Adding a number to a Date shifts it by that many days:
  
  now_ct + 86400 #Tomorrow.  I wonder what the world will be like!
## [1] "2019-04-29 15:18:00 IST"

now_lt + 86400 #Same behavior for POSIXlt
## [1] "2019-04-29 15:18:00 IST"

now_date + 1   #Date arithmetic is in days
## [1] "2019-04-29"

Adding two dates together doesn’t make much sense, and throws an error. 
Subtraction is supported, and calculates the difference between the two dates.
The behavior is the same for all three date types. In the following example, 
note that as.Date will automatically parse dates of the form %Y-%m-%d or %Y/%m/%d, 
if you don’t specify a format:
  the_start_of_time <-    #according to POSIX
  as.Date("1970-01-01")
the_end_of_time <-      #according to Mayan conspiracy theorists
  as.Date("2012-12-21")
(all_time <- the_end_of_time - the_start_of_time)
## Time difference of 15695 days

The difference has class difftime, and the value is stored as a number with a unit attribute 
of days. Days were automatically chosen as the “most sensible” unit due to the difference 
between the times. Differences shorter than one day are given in hours, minutes, or seconds, 
as appropriate. For more control over the units, you can use the difftime function:
  difftime(the_end_of_time, the_start_of_time, units = "secs")
## Time difference of 1.356e+09 secs

difftime(the_end_of_time, the_start_of_time, units = "weeks")
## Time difference of 2242 weeks

The seq function for generating sequences also works with dates. This can be particularly 
useful for creating test datasets of artificial dates. The choice of units in the by 
argument differs between the POSIX and Date types. See the ?seq.POSIXt and ?seq.Date 
help pages for the choices in each case:
  seq(the_start_of_time, the_end_of_time, by = "1 year")
##  [1] "1970-01-01" "1971-01-01" "1972-01-01" "1973-01-01" "1974-01-01"
##  [6] "1975-01-01" "1976-01-01" "1977-01-01" "1978-01-01" "1979-01-01"
## [11] "1980-01-01" "1981-01-01" "1982-01-01" "1983-01-01" "1984-01-01"
## [16] "1985-01-01" "1986-01-01" "1987-01-01" "1988-01-01" "1989-01-01"
## [21] "1990-01-01" "1991-01-01" "1992-01-01" "1993-01-01" "1994-01-01"
## [26] "1995-01-01" "1996-01-01" "1997-01-01" "1998-01-01" "1999-01-01"
## [31] "2000-01-01" "2001-01-01" "2002-01-01" "2003-01-01" "2004-01-01"
## [36] "2005-01-01" "2006-01-01" "2007-01-01" "2008-01-01" "2009-01-01"
## [41] "2010-01-01" "2011-01-01" "2012-01-01"

Lubridate
If you’ve become disheartened with dates and are considering skipping the rest of the lecture, 
do not fear! Help is at hand. lubridate, as the name suggests, adds some 
much-needed lubrication to the process of date manipulation.

library(lubridate)
## Attaching package: 'lubridate'
## The following object is masked from 'package:chron':
##
## days, hours, minutes, seconds, years
raj_kapoor_birth_date <- c( #He invented the marine chronometer
  "1924-12 14",
  "1924/12\\14",
  "Tuesday+1924.12*14"
)
ymd(raj_kapoor_birth_date)  #All the same
## [1] "1924-12-14" "1924-12-14" "1924-12-14"

The important thing to remember with ymd is to get the elements of the date in the 
right order. If your date data is in a different form, then lubridate provides other 
functions (ydm, mdy, myd, dmy, and dym) to use instead. Each of these functions has 
relatives that allow the specification of times as well, so you get ymd_h, ymd_hm, 
and ymd_hms, as well as the equivalents for the other five date orderings. If your 
dates aren’t in any of these formats, then the lower-level parse_date_time lets you 
give a more exact specification.

All the parsing functions in lubridate return POSIXct dates and have a default time 
zone of UTC. Be warned: these behaviors are different from base R’s strptime! 
  (Although usually more convenient.) In lubridate terminology, these individual 
dates are “instants.”
For formatting dates, lubridate provides stamp, which lets you specify a format in 
a more human-readable manner. You specify an example date, and it returns a f
unction that you can call to format your dates:
  date_format_function <-
  stamp("A moon landing occurred on Monday 01 Jan 0000 at 18:00:00.")
## Multiple formats matched: "A moon landing occurred on %A %m January %d%y
## at %H:%M:%OS"(1), "A moon landing occurred on %A %m January %Y at
## %d:%H:%M."(1), "A moon landing occurred on %A %d %B %Y at %H:%M:%S."(1)
## Using: "A moon landing occurred on %A %d %B %Y at %H:%M:%S."

date_format_function(moon_landings_lt)
## [1] "A moon landing occurred on Sunday 20 July 1969 at 20:17:40."

For dealing with ranges of times, lubridate has three different variable types. 
“Durations” specify time spans as multiples of seconds, so a duration of a day 
is always 86,400 seconds (60 * 60 * 24), and a duration of a year is always 
31,536,000 seconds (86,400 * 365). This makes it easy to specify ranges of dates that 
are exactly evenly spaced, but leap years and daylight savings time put them out of sync 
from clock time. In the following example, notice that the date slips back one day 
every time there is a leap year. today gives today’s date:
  
  (duration_one_to_ten_years <- dyears(1:10))
### [1] "31536000s (~52.14 weeks)" "63072000s (~2 years)"     "94608000s (~3 years)"     "126144000s (~4 years)"   
### [5] "157680000s (~5 years)"    "189216000s (~6 years)"    "220752000s (~7 years)"    "252288000s (~7.99 years)"
### [9] "283824000s (~8.99 years)" "315360000s (~9.99 years)"

today() + duration_one_to_ten_years
##  [1] "2014-07-17" "2015-07-17" "2016-07-16" "2017-07-16" "2018-07-16"
##  [6] "2019-07-16" "2020-07-15" "2021-07-15" "2022-07-15" "2023-07-15"
Other functions for creating durations are dseconds, dminutes, and so forth, 
as well as new_duration for mixed-component specification.
“Periods” specify time spans according to clock time. That means that their 
exact length isn’t apparent until you add them to an instant. For example, a period 
of one year can be 365 or 366 days, depending upon whether or not it is a leap year. 
In the following example, notice that the date stays the same across leap years:
  (period_one_to_ten_years <- years(1:10))
##  [1] "1y 0m 0d 0H 0M 0S"  "2y 0m 0d 0H 0M 0S"  "3y 0m 0d 0H 0M 0S"
##  [4] "4y 0m 0d 0H 0M 0S"  "5y 0m 0d 0H 0M 0S"  "6y 0m 0d 0H 0M 0S"
##  [7] "7y 0m 0d 0H 0M 0S"  "8y 0m 0d 0H 0M 0S"  "9y 0m 0d 0H 0M 0S"
## [10] "10y 0m 0d 0H 0M 0S"
today() + period_one_to_ten_years
##  [1] "2014-07-17" "2015-07-17" "2016-07-17" "2017-07-17" "2018-07-17"
##  [6] "2019-07-17" "2020-07-17" "2021-07-17" "2022-07-17" "2023-07-17"

a_year <- dyears(1)    #exactly 60*60*24*365 seconds
as.period(a_year)      #only an estimate
## estimate only: convert durations to intervals for accuracy
## [1] "1y 0m 0d 0H 0M 0S"

start_date <- ymd("2016-02-28")
(interval_over_leap_year <- interval(
  start_date,
  start_date + a_year
))
## [1] 2016-02-28 UTC--2017-02-27 UTC
as.period(interval_over_leap_year)
## [1] "11m 30d 0H 0M 0S"

Intervals also have some convenience operators, namely %--% for defining intervals and %within% 
for checking if a date is contained within an interval:
  ymd("2016-02-28") %--% ymd("2016-03-01") #another way to specify interval
## [1] 2016-02-28 UTC--2016-03-01 UTC
ymd("2016-02-29") %within% interval_over_leap_year
## [1] TRUE
