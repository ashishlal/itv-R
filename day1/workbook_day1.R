Exercise 1
(a) Calculate the inverse tangent (a.k.a. arctan) of the reciprocal of all integers from 1 to 1,000. 
Hint: take a look at the ?Trig help page to find the inverse tangent function. You don’t need a function to calculate reciprocals.
Assign the numbers 1 to 1,000 to a variable x. 
(b) Calculate the inverse tangent of the reciprocal of x, as in part (a), 
and assign it to a variable y. Now reverse the operations by calculating the reciprocal of the tangent of y and assigning 
this value to a variable z. 

Exercise 2
Compare the variables x and z from Exercise 1 (b) using ==, identical, and all.equal. For all.equal, try changing the 
tolerance level by passing a third argument to the function. What happens if the tolerance is set to 0?

Exercise 3
Define the following vectors:
(a) true_and_missing, with the values TRUE and NA (at least one of each, in any order)
(b) false_and_missing, with the values FALSE and NA
(c) mixed, with the values TRUE, FALSE, and NA 
(d) Apply the functions any and all to each of your vectors.

Exercise 4
Find the class, type, mode, and storage mode of the following values: Inf, NA, NaN, "". 

Exercise 5
Randomly generate 1,000 pets, from the choices “dog,” “cat,” “hamster,” and “goldfish,” with equal 
probability of each being chosen. Display the first few values of the resultant variable, 
and count the number of each type of pet.

Exercise 6
Create some variables named after vegetables. List the names of all the variables in the user 
workspace that contain the letter “a.”

Exercise 7
The nth triangular number is given by n * (n + 1) / 2. Create a sequence of the first 20 
triangular numbers. R has a built-in constant, letters, that contains the lowercase letters 
of the Roman alphabet. Name the elements of the vector that you just created with the first 20 
letters of the alphabet. Select the triangular numbers where the name is a vowel.

Exercise 8
The diag function has several uses, one of which is to take a vector as its input and 
create a square matrix with that vector on the diagonal. Create a 21-by-21 matrix with 
the sequence 10 to 0 to 11 (i.e., 11, 10, … , 1, 0, 1, …, 11).

Exercise 9
By passing two extra arguments to diag, you can specify the dimensions of the output. 
Create a 20-by-21 matrix with ones on the main diagonal. Now add a row of zeros above 
this to create a 21-by-21 square matrix, where the ones are offset a row below the main diagonal.
Create another matrix with the ones offset one up from the diagonal.
Add these two matrices together, then add the answer from Exercise 8. The resultant matrix is called 
a Wilkinson matrix.
The eigen function calculates eigenvalues and eigenvectors of a matrix. Calculate the eigenvalues for 
your Wilkinson matrix. What do you notice about them?

Exercise 10
Create a list variable that contains all the square numbers in the range 0 to 9 in the first element, 
in the range 10 to 19 in the second element, and so on, up to a final element with square numbers 
in the range 90 to 99. Elements with no square numbers should be included! 
  
Exercise 11
R ships with several built-in datasets, including the famous iris (flowers, not eyes) 
data collected by Anderson and analyzed by Fisher in the 1930s. Type iris to see the dataset. 
Create a new data frame that consists of the numeric columns of the iris dataset, 
and calculate the means of its columns.

Exercise 12
The beaver1 and beaver2 datasets contain body temperatures of two beavers. 
Add a column named id to the beaver1 dataset, where the value is always 1. 
Similarly, add an id column to beaver2, with value 2. Vertically concatenate the two data frames and 
find the subset where either beaver is active.

Exercise 13
Create a new environment named multiples_of_pi. Assign these variables into the environment:
  two_pi, with the value 2 * π, using double square brackets
three_pi, with the value 3 * π, using the dollar sign operator
four_pi, with the value 4 * π, using the assign function 
List the contents of the environment, along with their values.

Exercise 14
Write a function that accepts a vector of integers (for simplicity, you don’t have to 
                                                    worry about input checking) and 
returns a logical vector that is TRUE whenever the input is even, FALSE whenever the 
input is odd, and NA whenever the input is nonfinite (nonfinite means anything that 
                                                      will make is.finite return 
                                                      FALSE: Inf, -Inf, NA, and NaN). 
Check that the function works with positive, negative, zero, and nonfinite inputs.

Exercise 15
Write a function that accepts a function as an input and returns a list with two elements: 
  an element named args that contains a pairlist of the input’s formal arguments, 
and an element named body that contains the input’s body. Test it by calling the 
function with a variety of inputs. 

Exercise 16
Display the value of pi to 16 significant digits.

Exercise 17
Split these strings into words, removing any commas or hyphens:
  x <- c(
    "Swan swam over the pond, Swim swan swim!",
    "Swan swam back again - Well swum swan!"
  )
  
Exercise 18
This is the text for the famous “sea shells” tongue twister:
  sea_shells <- c(
    "She", "sells", "sea", "shells", "by", "the", "seashore",
    "The", "shells", "she", "sells", "are", "surely", "seashells",
    "So", "if", "she", "sells", "shells", "on", "the", "seashore",
    "I'm", "sure", "she", "sells", "seashore", "shells"
  )
Use the nchar function to calculate the number of letters in each word. Now loop over possible 
word lengths, displaying a message about which words have that length. For example, at length six, 
you should state that the words “shells” and “surely” have six letters.

Exercise 19
Loop over the list of children in the celebrity Wayans family. How many children does each of the 
first generation of Wayanses have?
  wayans <- list(
    "Dwayne Kim" = list(),
    "Keenen Ivory" = list(
      "Jolie Ivory Imani",
      "Nala",
      "Keenen Ivory Jr",
      "Bella",
      "Daphne Ivory"
    ),
    Damon = list(
      "Damon Jr",
      "Michael",
      "Cara Mia",
      "Kyla"
    ),
    Kim = list(),
    Shawn = list(
      "Laila",
      "Illia",
      "Marlon"
    ),
    Marlon = list(
      "Shawn Howell",
      "Arnai Zachary"
    ),
    Nadia = list(),
    Elvira = list(
      "Damien",
      "Chaunté"
    ),
    Diedre = list(
      "Craig",
      "Gregg",
      "Summer",
      "Justin",
      "Jamel"
    ),
    Vonnie = list()
  )

Exercise 20
state.x77 is a dataset that is supplied with R. It contains information about the population, 
income, and other factors for each US state. You can see its values by typing its name, 
just as you would with datasets that you create yourself:
  state.x77
Inspect the dataset using the method that you learned in Chapter 3.
Find the mean and standard deviation of each column. 

Exercise 21
Recall the time_for_commute function from earlier in the lecture. Calculate the 75th-percentile 
commute time by mode of transport:
  commute_times <- replicate(1000, time_for_commute())
commute_data <- data.frame(
  time = commute_times,
  mode = names(commute_times)
)

Exercise 22
Using R GUI, install the Hmisc package.

Exercise 23
Using the install.packages function, install the lubridate package.

Exercise 24
Count the number of packages that are installed on your machine in each library.

Exercise 25
Parse the birth dates of the Narendra Modi, Rahul Gandhi, and print them in the form 
“AbbreviatedWeekday DayOfMonth AbbreviatedMonthName TwoDigitYear” 
(for example, “Wed 09 Oct 40”). 

Exercise 26
Write a function that accepts a date as an input and returns the astrological sign of the 
zodiac corresponding to that date. The date ranges for each sign are given in the following table.
Zodiac sign	Start date	End date
Aries  March 21         April 19
Taurus April 20         May 20
Gemini May 21           June 20
Cancer June 21          July 22
Leo    July 23          August 22
Virgo  August 23        September 22
Libra  September 23     October 22
Scorpio October 23      November 21
Sagittarius November 22 December 21
Capricorn December 22   January 19
Aquarius  January 20    February 18
Pisces    February 19   March 20

