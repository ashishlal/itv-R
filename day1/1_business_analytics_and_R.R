# Introduction to Data Analytics
#  Business Analytics and R
# o Understand the use of ‘R’ in the industry
'
R, also called the Language for Statistical Computing, was developed by Ross Ihaka and
Robert Gentleman at the University of Auckland in the nineties. It is considered an open
source implementation of the S language, which was developed by John Chambers in the Bell
Laboratories in the eighties.
R provides a wide variety of statistical techniques and visualization capabilities. Another very
important feature about R is that it is higly extensible. Because of this and more importantly
because R is open source, it actually was the vehicle to bring the power of S to a larger
community.
'
# o Compare R with other softwares in analytics
First of all, it's open source, so it's free! Next, R's graphical capabilities are top notch
and it's very easy to build publication quality plots. In comparison to many other statistical
software packages, R uses a command line interface, which means that you have to actually code
things in your console and in scripts. While this might be frustrating at first, it makes
your work reproducible. You can now wrap your work in R scripts, which you can then easily
share with your colleagues. Because of these advantages, R appeals to a large audience
both in academia and in business. Moreover, it's fairly easy to create
R packages, which are extensions of R, aimed at solving particular problems. R's
very active community has created thousands of well-documented R packages for a very broad
range of applications in the financial sector, health care and for cutting edge research.
However, as with anything, there are also some disadvantages. R seems to be relatively
easy to learn at first, but it is hard to really master it. Also the fact that R is
command-based is a frightening detail for statisticians that are used to the typical
point and click programs out there. This steep learning curve sometimes results in poorly
written R code that can be hard, both to read and to maintain. Furthermore, poorly written
R code can become slow if you're working with large data sets.


  One of the most important components of R, and where most of the action happens, is the
R console. It's a place where you can execute R commands. You simply
type something at the prompt in the console, hit Enter, and R interprets and executes your
command.

# o Perform basic operations in R using command line
Let's start our experiments by having R do some basic arithmetic; we'll calculate the
sum of 1 and 2. We simply type 1 + 2 in the console and hit Enter. R compiles what you
typed, calculates the result and prints that result as a numerical value.
Now let's try to type some text in the console. We use double quotes for this.
You can also simply type a number and hit Enter.
R understood your character string and numerical value, but simply printed that string as an
output. This brings me to the first super important concept in R: the variable. A variable
allows you to store a value or an object in R. You can then later use this variables
name to easily access the value or the object that is stored within this variable. You can
use the less than sign followed by a dash to create a variable. Suppose the number 2
is the height of a rectangle. Let's assign this value 2 to a variable height. We type
height, less than sign, dash, 2:
This time, R does not print anything, because it assumes that you will be using this variable
in the future. If we now simply type and execute height in the console, R returns 2:
We can do a similar thing for the width of our imaginary rectangle. We assign the value
4 to a variable width.
If we type width, we see that indeed, it contains the value 4.
As you're assigning variables in the R console, you're actually accumulating an R workspace.
It's the place where variables and information is stored in R. You can access the objects
in the workspace with the ls() function. Simply type ls followed by empty parentheses and
hit enter.
This shows you a list of all the variables you have created in the R session. If you
have followed all the examples up to now, you should see "height" and "width". This
tells you that there are two objects in your workspace at the moment. When you type height
in the console, R looks for the variable height in the workspace, finds it, and prints the
corresponding value. If, however, we try to print a non-existing variable, depth for example,
R throws an error, because depth is not defined in the workspace and thus not found.
The principle of accumulating a workspace through variable assignment makes these variables
available for further use. Suppose we want to find out the area of our imaginary rectangle,
which is height multiplied by width. Let's go ahead and type height asterisk width.
The result is 8, as you'd expect. We can take it one step further and also assign the result
of this calculation to a new variable, area. We again use the assignment operator.
If you now type area, you'll see that it contains 8 as well.
Inspecting the workspace again with ls, shows that the workspace contains three objects
now: area, height and width.
Now, this is all great, but what if you want to recalculate the area of your imaginary
rectangle when the height is 3 and the width is 6? You'd have to reassign the variables
width and height, and then recalculate the area. That's quite some coding you have to
redo, isn't it?
  This is the place where R scripts come in! An R script is simply a text file, containing
a collection of succesive lines of R code that solve a particular task. When using R,
you will build a lot of scripts to make things easier for you, and hopefully automate parts
of your work.
We can create a new script, "rectangle.R", that contains the code that we've written
up to now.
Next, you can run this script. Depending on the software you're using, there's several
ways to do this. In RStudio, R's most popular IDE, there's a "Source" button to
run the script you're editing. In either case, R goes through your code, line by line, executing
every command one by one, just as if you are manually typing each command in the console.
The cool thing is, that if you want to change some variables here and there, you can simply
do this in the script, source your code again and see how the output has changed. Let's
change the height to 3 and the width to 6, and rerun the script.
This is the true power of reproducibility at work here! This also makes sharing your
scripts very easy; you just send your R file and the recipient can simply run it on his
or her own system. However, you'll sometimes have to help people understand what you've
written and clarify your code here and there. You can use comments for this, which are lines
of code that start with a pound sign, like this one. Let's extend the script with some
more information. We add three lines of comments; one line before the assignment of height and
width, another one before the calculation of area, and a last one just before the printout
of area.
If you would run this script again, the lines starting with the pound sign do not affect
R's execution. But beware! Perfectly valid R code that you place behind a comment sign
is interpreted as a comment and won't be considered by R!

  Let's have a final look at the workspace: as before, there are three variables in your
workspace: area, height and width.
If you're working on big projects that have tons of data involved, this workspace can
consume a lot of your computer's resources. It's a good idea to clean up your workspace
from time to time to make sure it does not get bloated. You can use the rm() function
for this. To remove the area variable, you can type rm followed by area inside parenthesis.
If you now check your workspace again, using ls(), you will see that only height and width
remain.

# o Install R and the packages from CRAN

Windows
=======
To install R on Windows just download it from MRO Downloads and then execute the installer.
You can also install from CRAN
To install RStudio just visit RStudio Downloads and download the last version. 

Linux
=====
You should install R with OpenBLAS. In plain terms, OpenBLAS will boost some operations.
> sudo apt-get install libopenblas-base r-base
> sudo apt-get install gdebi
> cd ~/Downloads
> Google RStudio download. Goto the download page and select the latest version for your OS. Then download.
For eg. if you have downloaded rstudio-1.2.1335-amd64.deb
> sudo gdebi rstudio-1.2.1335-amd64.deb
Start rstudio.
Install Tidyverse
>install.packages("tidyverse", repos = 'https://cran.us.r-project.org')

# o Introduction to R Studio
When R is started, it follows this process:

1. R is started in the working directory.
2. If present, the .Rprofile file’s commands are executed.
3. If present, the .Rdata file is loaded.

Other actions described in ?Startup are followed.
When R quits, a user is queried to “Save workspace image?” When the workspace is
saved it writes the contents to an .Rdata file, so that when R is restarted the workspace
can persist between sessions. (One can also initiate this with save.image .)
This process allows R users to place commands they desire to run in every session in
an .Rprofile file, and to have per directory .Rdata files, so that different global work-
spaces can be used for different projects.

# o User Interface of RStudio - The R IDE


