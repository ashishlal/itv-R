# 3.Data Import & Manipulation
#  Importing data
# o Reading Tabular Data files
# o Reading CSV files
# o Importing data from excel
# o R Assignment Operators
# o Accessing database
# o Saving in R data
# o Loading R data objects
# o Writing to files
# 
#  Manipulating Data
# o Selecting rows/observations
# o Selecting columns/fields
# o Merging data
# o Relabelling the column names
# o Converting variable types
# o Data sorting and Data aggregation

Built-in Datasets
One of the packages in the base R distribution is called datasets, and it is entirely filled with 
example datasets. While you’ll be lucky if any of them are suited to your particular area of research, 
they are ideal for testing your code and for exploring new techniques. Many other packages also 
contain datasets. You can see all the datasets that are available in the packages that you have 
loaded using the data function:
  data()

For a more complete list, including data from all packages that have been installed, 
use this invocation:
  data(package = .packages(TRUE))

To access the data in any of these datasets, call the data function, this time passing the 
name of the dataset and the package where the data is found (if the package has been loaded, 
                                                             then you can omit the package argument):
  data("kidney", package = "survival")
Now the kidney data frame can be used just like your own variables:
  head(kidney)
##   id time status age sex disease frail
## 1  1    8      1  28   1   Other   2.3
## 2  1   16      1  28   1   Other   2.3
## 3  2   23      1  48   2      GN   1.9
## 4  2   13      0  48   2      GN   1.9
## 5  3   22      1  32   1   Other   1.2
## 6  3   28      1  32   1   Other   1.2

There are many, many formats and standards of text documents for storing data. 
Common formats for storing data are delimiter-separated values (CSV or tab-delimited),
eXtensible Markup Language (XML), JavaScript Object Notation (JSON), and YAML 
(which recursively stands for YAML Ain’t Markup Language). Other sources of 
text data are less well-structured — a book, for example, contains text data 
without any formal (that is, standardized and machine parsable) structure.

The main advantage of storing data in text files is that they can be read by 
more or less all other data analysis software and by humans. This makes your 
data more widely reusable by others.

CSV and Tab-Delimited Files
Rectangular (spreadsheet-like) data is commonly stored in delimited-value files, 
particularly comma-separated values (CSV) and tab-delimited values files. 
The read.table function reads these delimited files and stores the results in a 
data frame. In its simplest form, it just takes the path to a text file and imports the contents.

RedDeerEndocranialVolume.dlm is a whitespace-delimited file containing measurements 
of the endocranial volume of some red deer, measured using different techniques. 
(For those of you with an interest in deer skulls, the methods are 
  computer tomography; filling the skull with glass beads; measuring the length, 
  width, and height with calipers; and using Finarelli’s equation. A second measurement 
  was taken in some cases to get an idea of the accuracy of the techniques. I’ve been assured 
  that the deer were already long dead before they had their skulls filled with beads!) 
The data file can be found inside the extdata folder in the learningr package.

The data has a header row, so we need to pass the argument header = TRUE to read.table. 
Since a second measurement wasn’t always taken, not all the lines are complete. 
Passing the argument fill = TRUE makes read.table substitute NA values for the 
missing fields. The system.file function in the following example is used to locate 
files that are inside a package (in this case, the RedDeerEndocranialVolume.dlm file in 
                                 the extdata folder of the package learningr).
library(learningr)
deer_file <- system.file(
  "extdata",
  "RedDeerEndocranialVolume.dlm",
  package = "learningr"
)
deer_data <- read.table(deer_file, header = TRUE, fill = TRUE)

#vec.len	
numeric (>= 0) indicating how many ‘first few’ elements are displayed of each vector. 
The number is multiplied by different factors (from .5 to 3) depending on the kind of vector. 
Defaults to the vec.len component of option "str" (see options) which defaults to 4.

#str gives structure
str(deer_data, vec.len = 1)      #vec.len alters the amount of output
## 'data.frame':        33 obs. of  8 variables:
##  $ SkullID     : Factor w/ 33 levels "A4","B11","B12",..: 14  ...
##  $ VolCT       : int  389 389  ...
##  $ VolBead     : int  375 370  ...
##  $ VolLWH      : int  1484 1722  ...
##  $ VolFinarelli: int  337 377  ...
##  $ VolCT2      : int  NA NA  ...
##  $ VolBead2    : int  NA NA  ...
##  $ VolLWH2     : int  NA NA  ...

head(deer_data)
##   SkullID VolCT VolBead VolLWH VolFinarelli VolCT2 VolBead2 VolLWH2
## 1   DIC44   389     375   1484          337     NA       NA      NA
## 2     B11   389     370   1722          377     NA       NA      NA
## 3   DIC90   352     345   1495          328     NA       NA      NA
## 4   DIC83   388     370   1683          377     NA       NA      NA
## 5  DIC787   375     355   1458          328     NA       NA      NA
## 6 DIC1573   325     320   1363          291     NA       NA      NA

There are several convenience wrapper functions to read.table. read.csv sets the 
default separator to a comma, and assumes that the data has a header row. read.csv2 
is its European cousin, using a comma for decimal places and a semicolon as a separator. 
Likewise read.delim and read.delim2 import tab-delimited files with full stops 
or commas for decimal places, respectively.

Back in August 2008, scientists from the Centre for Environment, Fisheries, and 
Aquaculture Science (CEFAS) in Lowestoft, UK, attached a tag with a pressure sensor 
and a temperature sensor to a brown crab and dropped it into the North Sea. The crab 
then spent just over a year doing crabby things before being caught by fishermen, 
who returned the tag to CEFAS.

The data from this tag is stored in a CSV file, along with some metadata. The first 
few rows of the file look like this:
  
  Comment :- clock reset to download data
The following data are the ID block contents
Firmware Version No 2
Firmware Build Level 70
The following data are the Tag notebook contents 
Mission Day 405          
Last Deployment Date 08/08/2008 09:55:00
Deployed by Host Version 5.2.0
Downloaded by Host Version 6.0.0
Last Clock Set Date 05/01/2010 10:34:00
The following data are the Lifetime notebook contents
Tag ID A03401
Pressure Range 10
No of sensors 2

In this case, we can’t just read everything with a single call to read.csv, since different 
pieces of data have different numbers of fields, and indeed different fields. We need 
to use the skip and nrow arguments of read.csv to specify which bits of the file to read:
  crab_file <- system.file(
    "extdata",
    "crabtag.csv",
    package = "learningr"
  )
(crab_id_block <- read.csv(
  crab_file,
  header = FALSE,
  skip = 3,
  nrow = 2
))
## V1 V2
## 1  Firmware Version No  2
## 2 Firmware Build Level 70

(crab_tag_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 8,
  nrow = 5
))
##                           V1                  V2
## 1                Mission Day                 405
## 2       Last Deployment Date 08/08/2008 09:55:00
## 3   Deployed by Host Version               5.2.0
## 4 Downloaded by Host Version               6.0.0
## 5        Last Clock Set Date 05/01/2010 10:34:00
(crab_lifetime_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 15,
  nrow = 3
))
##                V1     V2
## 1          Tag ID A03401
## 2 Pressure Range      10
## 3  No of sensors       2

If your data has been exported from another language, you may need to pass the 
na.strings argument to read.table. For data exported from SQL, use na.strings = "NULL". 
For data exported from SAS or Stata, use na.strings = ".". For data exported from 
Excel, use na.strings = c("", "#N/A", "#DIV/0!", "#NUM!").

Both functions take a data frame and a file path to write to. They also provide a few 
options to customize the output (whether or not to include row names and what the 
                                 character encoding of the output file should be, for example):
  
write.csv(
  crab_lifetime_notebook,
  "./data/crab lifetime data.csv",
  row.names    = FALSE,
  fileEncoding = "utf8"
)

Unstructured Text Files
Not all text files have a well-defined structure like delimited files do. If the structure 
of the file is weak, it is often easier to read in the file as lines of text and then parse 
or manipulate the contents afterward. readLines (notice the capital “L”) provides such a 
facility. It accepts a path to a file (or a file connection) and, optionally, a maximum 
number of lines to read. Here we import the Project Gutenberg version of Shakespeare’s The Tempest:
  text_file <- system.file(
    "extdata",
    "Shakespeare_s_The_Tempest_from_Project_Gutenberg.pg2235.txt",
    package = "learningr"
  )
the_tempest <- readLines(text_file)
the_tempest[1926:1927]

writeLines performs the reverse operation to readLines. It takes a character vector and a file to write to:
  writeLines(
    rev(text_file),     #rev reverses vectors
    "Shakespeare_s_The_Tempest_backwards.txt"
  )
install.packages("XML")
library(XML)
xml_file <- system.file("extdata", "options.xml", package = "learningr")
r_options <- xmlParse(xml_file)
One of the problems with using internal nodes is that summary functions like str 
and head don’t work with them. To use R-level nodes, set useInternalNodes = FALSE 
(or use xmlTreeParse, which sets this as the default):
  xmlParse(xml_file, useInternalNodes = FALSE)
xmlTreeParse(xml_file)      #the same
XPath is a language for interrogating XML documents, letting you find nodes that 
correspond to some filter. In this next example we look anywhere in the document (//) for 
a node named variable where ([]) the name attribute (@) contains the string warn.
xpathSApply(r_options, "//variable[contains(@name, 'warn')]")
## [[1]]
## <variable name="nwarnings" type="numeric">
##   <value>50</value>
## </variable>
##
## [[2]]
## <variable name="warn" type="numeric">
##   <value>0</value>
## </variable>
##
## [[3]]
## <variable name="warning_length" type="numeric">
##   <value>1000</value>
## </variable>

install.packages("RJSONIO")
library(RJSONIO)
install.packages("rjson")
library(rjson)
jamaican_city_file <- system.file(
  "extdata",
  "Jamaican.Cities.json",
  package = "learningr"
)
(jamaican_cities_RJSONIO <- RJSONIO::fromJSON(jamaican_city_file))
## $Kingston
## $Kingston$population
## [1] 587798
##
## $Kingston$coordinates
## longitude  latitude
##     17.98     76.80
##
##
## $`Montego Bay`
## $`Montego Bay`$population
## [1] 96488
##
## $`Montego Bay`$coordinates
## longitude  latitude

(jamaican_cities_rjson <- rjson::fromJSON(file = jamaican_city_file))
## $Kingston
## $Kingston$population
## [1] 587798
##
## $Kingston$coordinates
## $Kingston$coordinates$longitude
## [1] 17.98
##
## $Kingston$coordinates$latitude
## [1] 76.8
##
##
##
## $`Montego Bay`
## $`Montego Bay`$population
## [1] 96488
##
## $`Montego Bay`$coordinates
## $`Montego Bay`$coordinates$longitude
## [1] 18.47
##
## $`Montego Bay`$coordinates$latitude
## [1] 77.92

Annoyingly, the JSON spec doesn’t allow infinite or NaN values, and it’s a little fuzzy 
on what a missing number should look like. The two packages deal with these values 
differently — RJSONIO maps NaN and NA to JSON’s null value but preserves positive and 
negative infinity, while rjson converts all these values to strings:
  special_numbers <- c(NaN, NA, Inf, -Inf)

RJSONIO::toJSON(special_numbers)
## [1] "[ null, null,    Inf,   -Inf ]"

rjson::toJSON(special_numbers)
## [1] "[\"NaN\",\"NA\",\"Inf\",\"-Inf\"]"

library(yaml)
yaml.load_file(jamaican_city_file)
## $Kingston
## $Kingston$population
## [1] 587798
##
## $Kingston$coordinates
## $Kingston$coordinates$longitude
## [1] 17.98
##
## $Kingston$coordinates$latitude
## [1] 76.8
##
##
##
## $`Montego Bay
## $`Montego Bay`$population
## [1] 96488
##
## $`Montego Bay`$coordinates
## $`Montego Bay`$coordinates$longitude
## [1] 18.47
##
## $`Montego Bay`$coordinates$latitude
## [1] 77.92
as.yaml performs the opposite task, converting R objects to YAML strings.

Reading Excel Files
Microsoft Excel is the world’s most popular spreadsheet package, and very possibly the 
world’s most popular data analysis tool. Unfortunately, its document formats, XLS and XLSX, 
don’t play very nicely with other software, especially outside of a Windows environment. 
This means that some experimenting may be required to find a setup that works for your 
choice of operating system and the particular type of Excel file.
That said , the xlsx package is Java-based and cross-platform, so at least in theory it 
can read any Excel file on any system. It provides a choice of functions for reading 
Excel files: spreadsheets can be imported with read.xlsx and read.xlsx2, which do more 
processing in R and in Java, respectively. The choice of two engines is rather superfluous; 
you want read.xlsx2, since it’s faster and the underlying Java library is more mature 
than the R code.
The next example features the fastest times from the Alpe d’Huez mountain stage of the 
Tour de France bike race, along with whether or not each cyclist has been found guilty 
of using banned performance-enhancing drugs. The colClasses argument determines what 
class each column should have in the resulting data frame. It isn’t compulsory, but 
it saves you having to manipulate the resulting data afterward:
install.packages("xlsx")
install.packages("learningr")
  library(xlsx)
install.packages("packrat")
bike_file <- system.file(
  "extdata",
  "Alpe.d.Huez.xls",
  package = "learningr"
)
bike_file

bike_data <- read.xlsx2(
  bike_file,
  sheetIndex = 1,
  startRow   = 2,
  endRow     = 38,
  colIndex   = 2:8,
  colClasses = c(
    "character", "numeric", "character", "integer",
    "character", "character", "character"
  )
)
head(bike_data)

Web Data
The Internet contains a wealth of data, but it’s hard work (and not very scalable) to manually 
visit a website, download a data file, and then read it into R from your hard drive.
Fortunately, R has a variety of ways to import data from web sources; retrieving the 
data programmatically makes it possible to collect much more of it with much less effort.
Sites with an API
Several packages exist that download data directly into R using a website’s application 
programming interface (API). For example, the World Bank makes its World Development 
Indicators data publically available, and the WDI package lets you easily import the 
data without leaving R. To run the next example, you first need to install the WDI package:
  install.packages("WDI")
library(WDI)
#list all available datasets
wdi_datasets <- WDIsearch()
head(wdi_datasets)
## indicator              name                                               
## [1,] "BX.TRF.PWKR.GD.ZS"    "Workers' remittances, receipts (% of GDP)"        
## [2,] "BX.TRF.PWKR.DT.GD.ZS" "Personal remittances, received (% of GDP)"        
## [3,] "BX.TRF.MGR.DT.GD.ZS"  "Migrant remittance inflows (% of GDP)"            
## [4,] "BX.KLT.DINV.WD.GD.ZS" "Foreign direct investment, net inflows (% of GDP)"
## [5,] "BX.KLT.DINV.DT.GD.ZS" "Foreign direct investment, net inflows (% of GDP)"
## [6,] "BX.GSR.MRCH.ZS"       "Merchandise exports (BOP): percentage of GDP (%)" 
#retrieve one of them
wdi_trade_in_services <- WDI(
  indicator = "BG.GSR.NFSV.GD.ZS"
)
str(wdi_trade_in_services)
## 'data.frame':  984 obs. of  4 variables:
##  $ iso2c            : chr  "1A" "1A" "1A" ...
##  $ country          : chr  "Arab World" "Arab World" "Arab World" ...
##  $ BG.GSR.NFSV.GD.ZS: num  17.5 NA NA NA ...
##  $ year             : num  2005 2004 2003 2002 ...

The SmarterPoland package provides a similar wrapper to Polish government data. quantmod 
provides access to stock tickers (Yahoo!’s by default, though several other 
                                  sources are available):
install.packages("quantmod")
library(quantmod)
#If you are using a version before 0.5.0 then set this option
#or pass auto.assign = FALSE to getSymbols.
options(getSymbols.auto.assign = FALSE)
microsoft <- getSymbols("MSFT")
# ‘getSymbols’ currently uses auto.assign=TRUE by default, but will
# use auto.assign=FALSE in 0.5-0. You will still be able to use
# ‘loadSymbols’ to automatically load data. getOption("getSymbols.env")
# and getOption("getSymbols.auto.assign") will still be checked for
# alternate defaults.
# 
# This message is shown once per session and may be disabled by setting 
# options("getSymbols.warning4.0"=FALSE). See ?getSymbols for details.


head(microsoft)
# MSFT.Open MSFT.High MSFT.Low MSFT.Close MSFT.Volume MSFT.Adjusted
# 2007-01-03     29.91     30.25    29.40      29.86    76935100      22.47883
# 2007-01-04     29.70     29.97    29.44      29.81    45774500      22.44119
# 2007-01-05     29.63     29.75    29.45      29.64    44607200      22.31321
# 2007-01-08     29.65     30.10    29.53      29.93    50220200      22.53152
# 2007-01-09     30.00     30.18    29.73      29.96    44636600      22.55411
# 2007-01-10     29.80     29.89    29.43      29.66    55017400      22.32826

Scraping Web Pages
R has its own web server built in, so some functions for reading data are Internet-enabled 
by default. read.table (and its derivatives, like read.csv) can accept a URL rather than a 
local file, and will download a copy to a temp file before importing the data. 

More advanced access to web pages can be achieved through the RCurl package, which provides 
access to the libcurl network client interface library. This is particularly useful if your 
data is contained inside an HTML or XML page, rather than a standard data format (like CSV) 
that just happens to be on the Web.
The next example retrieves the current date and time in several time zones from the United 
States Naval Observatory Time Service Department web page. The function getURL retrieves 
the page as a character string:
  install.packages("RCurl")
  library(RCurl)
time_url <- "https://tycho.usno.navy.mil/cgi-bin/timer.pl"
time_page <- RCurl::getURL(time_url)
cat(time_page)
## <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final"//EN>
## <html>
## <body>
## <TITLE>What time is it?</TITLE>
## <H2> US Naval Observatory Master Clock Time</H2> <H3><PRE>
## <BR>Jul. 17, 20:43:37 UTC            Universal Time
## <BR>Jul. 17, 04:43:37 PM EDT Eastern Time
## <BR>Jul. 17, 03:43:37 PM CDT Central Time
## <BR>Jul. 17, 02:43:37 PM MDT Mountain Time
## <BR>Jul. 17, 01:43:37 PM PDT Pacific Time
## <BR>Jul. 17, 12:43:37 PM AKDT        Alaska Time
## <BR>Jul. 17, 10:43:37 AM HAST        Hawaii-Aleutian Time
## </PRE></H3><P><A HREF="http://www.usno.navy.mil"> US Naval Observatory</A>
##
## </body></html>

install.packages("XML")
library(XML)
time_doc <- htmlParse(time_page)
pre <- xpathSApply(time_doc, "//pre")[[1]]
values <- strsplit(xmlValue(pre), "\n")[[1]][-1]
strsplit(values, "\t+")
## [[1]]
## [1] "Jul. 17, 20:43:37 UTC" "Universal Time"
##
## [[2]]
## [1] "Jul. 17, 04:43:37 PM EDT" "Eastern Time"
##
## [[3]]
## [1] "Jul. 17, 03:43:37 PM CDT" "Central Time"
##
## [[4]]
## [1] "Jul. 17, 02:43:37 PM MDT" "Mountain Time"
##
## [[5]]
## [1] "Jul. 17, 01:43:37 PM PDT" "Pacific Time"
##
## [[6]]
## [1] "Jul. 17, 12:43:37 PM AKDT" "Alaska Time"
##
## [[7]]
## [1] "Jul. 17, 10:43:37 AM HAST" "Hawaii-Aleutian Time"
The httr package is based on RCurl and provides syntactic sugar to make some tasks 
go down easier. The httr equivalent of RCurl’s getURL is GET, and the content function 
retrieves the page’s content, parsing it in the process. In the next example, we pass 
useInternalNodes = TRUE to mimic the behavior of htmlParse and repeat the action of 
the previous example:
  install.packages("httr")
  library(httr)
time_page <- GET(time_url)
#time_doc <- httr::content(page, useInternalNodes = TRUE)

Accessing Databases
Where data has to be accessed by many people, it is often best stored in a relational 
database. There are many database management systems (DBMSs) for working with relational 
databases, and R can connect to all the common ones. The DBI package provides a unified 
syntax for accessing several DBMSs — currently SQLite, MySQL/MariaDB, PostgreSQL, 
and Oracle are supported, as well as a wrapper to the Java Database Connectivity 
(JDBC) API. (Connections to SQL Server use a different system, as we’ll see below.)
To connect to an SQLite database, you must first install and load the DBI package 
and the backend package RSQLite:
  library(DBI)
install.packages("RSQLite")
library(RSQLite)
Then you define the database driver to be of type “SQLite” and set up a connection to 
the database, in this case by naming the file:
  driver <- dbDriver("SQLite")
db_file <- system.file(
  "extdata",
  "crabtag.sqlite",
  package = "learningr"
)
conn <- dbConnect(driver, db_file)
# The equivalent for a MySQL database would be to load the RMySQL package and set the driver 
# type to be “MySQL”:
#   driver <- dbDriver("MySQL")
# db_file <- "path/to/MySQL/database"
# conn <- dbConnect(driver, db_file)

To retrieve data from the databases you write a query, which is just a string 
containing SQL commands, and send it to the database with dbGetQuery. In this next 
example, SELECT * FROM IdBlock means “get every column of the table named IdBlock”:

query <- "SELECT * FROM IdBlock"
(id_block <- dbGetQuery(conn, query))
##   Tag ID Firmware Version No Firmware Build Level
## 1 A03401                   2                   70
Then, after you’ve finished manipulating the database, you need to clean up by 
disconnecting and unloading the driver:

dbDisconnect(conn)
## [1] TRUE

dbUnloadDriver(driver)
## [1] TRUE

It is very easy to accidentally leave connections open, especially if an error occurs 
while you are connected. One way to avoid this is to wrap your database code into a 
function, and use on.exit to make sure that the cleanup code always runs. on.exit runs 
R code whenever its parent function exits, whether it finishes correctly or throws 
an error. We can rewrite the previous example with safer code as follows:
  query_crab_tag_db <- function(query)
  {
    driver <- dbDriver("SQLite")
    db_file <- system.file(
      "extdata",
      "crabtag.sqlite",
      package = "learningr"
    )
    conn <- dbConnect(driver, db_file)
    on.exit(
      {
        #this code block runs at the end of the function,
        #even if an error is thrown
        dbDisconnect(conn)
        dbUnloadDriver(driver)
      }
    )
    dbGetQuery(conn, query)
  }
We can pass any SQL code to the function to query the crab tag database:
  query_crab_tag_db("SELECT * FROM IdBlock")
##   Tag ID Firmware Version No Firmware Build Level
## 1 A03401                   2                   70
In this case, the DBI package provides a convenience function that saves us having to 
write our own SQL code. dbReadTable does as you might expect: it reads a table from 
the connected database (use dbListTables(conn) if you can’t remember the name of 
                        the table that you want):
  dbReadTable(conn, "idblock")
##   Tag.ID Firmware.Version.No Firmware.Build.Level
## 1 A03401                   2                   70
## [1] TRUE
## [1] TRUE

Cleaning Strings
Earlier we looked at some simple string manipulation tasks like combining strings 
together using paste, and extracting sections of a string using substring.
One really common problem is when logical values have been encoded in a way that 
R doesn’t understand. In the alpe_d_huez cycling dataset, the DrugUse column 
(denoting whether or not allegations of drug use have been made about each rider’s 
  performance), values have been encoded as "Y" and "N" rather than TRUE or FALSE. 
For this sort of simple matching, we can directly replace each string with the 
correct logical value:
  yn_to_logical <- function(x)
  {
    y <- rep.int(NA, length(x))
    y[x == "Y"] <- TRUE
    y[x == "N"] <- FALSE
    y
  }
Setting values to NA by default lets us deal with strings that don’t match "Y" or "N". 
We call the function in the obvious way:
  alpe_d_huez = bike_data
  alpe_d_huez$DrugUse <- yn_to_logical(alpe_d_huez$DrugUse)
  
These next examples use the english_monarchs dataset from the learningr package. 
It contains the names and dates of rulers from post-Roman times (in the fifth century CE), 
when England was split into seven regions known as the heptarchy, until England 
took over Ireland in the early thirteenth century:
  data(english_monarchs, package = "learningr")
head(english_monarchs)
  ##       name     house start.of.reign end.of.reign      domain
  ## 1    Wehha Wuffingas             NA          571 East Anglia
  ## 2    Wuffa Wuffingas            571          578 East Anglia
  ## 3   Tytila Wuffingas            578          616 East Anglia
  ## 4  Rædwald Wuffingas            616          627 East Anglia
  ## 5 Eorpwald Wuffingas            627          627 East Anglia
  ## 6 Ricberht Wuffingas            627          630 East Anglia
  ##   length.of.reign.years reign.was.more.than.30.years
  ## 1                    NA                           NA
  ## 2                     7                        FALSE
  ## 3                    38                         TRUE
  ## 4                    11                        FALSE
  ## 5                     0                        FALSE
  ## 6                     3                        FALSE

library(stringr)
multiple_kingdoms <- str_detect(english_monarchs$domain, fixed(","))
english_monarchs[multiple_kingdoms, c("name", "domain")]
##                           name                    domain
## 17                        Offa       East Anglia, Mercia
## 18                        Offa East Anglia, Kent, Mercia
## 19           Offa and Ecgfrith East Anglia, Kent, Mercia
## 20                    Ecgfrith East Anglia, Kent, Mercia
## 22                     Cœnwulf East Anglia, Kent, Mercia
## 23        Cœnwulf and Cynehelm East Anglia, Kent, Mercia
## 24                     Cœnwulf East Anglia, Kent, Mercia
## 25                    Ceolwulf East Anglia, Kent, Mercia
## 26                   Beornwulf       East Anglia, Mercia
## 82      Ecgbehrt and Æthelwulf              Kent, Wessex
## 83      Ecgbehrt and Æthelwulf      Kent, Mercia, Wessex
## 84      Ecgbehrt and Æthelwulf              Kent, Wessex
## 85    Æthelwulf and Æðelstan I              Kent, Wessex
## 86                   Æthelwulf              Kent, Wessex
## 87 Æthelwulf and Æðelberht III              Kent, Wessex
## 88               Æðelberht III              Kent, Wessex
## 89                  Æthelred I              Kent, Wessex
## 95                       Oswiu       Mercia, Northumbria

If we wanted to split the name column into individual rulers, then we could use 
str_split (or strsplit from base R, which does the same thing) in much the same way. 
str_split accepts a vector and returns a list, since each input string can be 
split into a vector of possibly differing lengths. If each input must return the same 
number of splits, we could use str_split_fixed instead, which returns a matrix. The output 
shows the first few examples of multiple rulers:
individual_rulers <- str_split(english_monarchs$name, ", | and ")
head(individual_rulers[sapply(individual_rulers, length) > 1])
## [[1]]
## [1] "Sigeberht" "Ecgric"
##
## [[2]]
## [1] "Hun"     "Beonna"  "Alberht"
##
## [[3]]
## [1] "Offa"     "Ecgfrith"
##
## [[4]]
## [1] "Cœnwulf"  "Cynehelm"
##
## [[5]]
## [1] "Sighere" "Sebbi"
##
## [[6]]
## [1] "Sigeheard" "Swaefred"

If we want to replace the eths and thorns, we can use str_replace_all. 
(A variant function, str_replace, replaces only the first match.) Placing eth and 
thorn in square brackets means “match either of these characters”:
  english_monarchs$new_name <- str_replace_all(english_monarchs$name, "[ðþ]", "th")
This sort of trick can be very useful for cleaning up levels of a categorical variable. 
For example, genders can be specified in several ways in English, but we usually only 
want two of them. In the next example, we match on a string that starts with (^) “m” 
and is followed by an optional (?) “ale”, which ends the string ($):
  install.packages('searchable')
library(searchable)
  gender <- c(
    "MALE", "Male", "male", "M", "FEMALE",
    "Female", "female", "f", NA
  )
clean_gender <- str_replace(
  gender,
  ignore.case("^m(ale)?$"),
  "Male"
)
(clean_gender <- str_replace(
  clean_gender,
  ignore.case("^f(emale)?$"),
  "Female"))
## [1] "Male"   "Male"   "Male"   "Male"   "Female" "Female" "Female" "Female" NA  

Manipulating Data Frames
Much of the task of cleaning data involves manipulating data frames to get them 
into the desired form. We’ve already seen indexing and the subset function for 
selecting a subset of a data frame. Other common tasks include augmenting a data 
frame with additional columns (or replacing existing columns), dealing with missing 
values, and converting between the wide and long forms of a data frame. There are 
several functions available for adding or replacing columns in a data frame.

Adding and Replacing Columns
Suppose we want to add a column to the english_monarchs data frame denoting the 
number of years the rulers were in power. We can use standard assignment to achieve this:
  english_monarchs$length.of.reign.years <-
  english_monarchs$end.of.reign - english_monarchs$start.of.reign
english_monarchs$length.of.reign.years
# [1] NA  7 38 11  0  3  4 NA NA  2  8 50 36 NA NA 15 28  2  9  0  4  2 14  9  2  3 19 10 14
# [30]  6  0  4 11 12  0 16 60 17 12  1 36  7  4 19 11  1 14  0  6 23  8 12 40 14 NA NA NA 22
# [59] 56 26 24 NA NA NA  9 11  1  1  2  1  3 33 23 14  2  1 14 NA  2  9  2  4  1  9 12  4  3
# [88]  8  5 NA  9  7 11  2  3 17 29  5  7  0 41  0  1  2  9  1  0  0 12 22  5  4 28  7  0 20
# [117] 27 12  1  8  4  7  6  8 23 16  1  8  2 10  1 12 30 15  1  7  3  8  9 15 19  1 11  2 11
# [146]  2  6 21  1  6  9  5  9  2  6  0 10  2  2 31  3  0  5 13  5  0  5  4  2 17 NA NA  2  8
# [175]  3  5  7  6  2  3  1  1  3  2  0 37 53 93 25  0  2 NA NA  8 10  7  0  7  2 14 NA  5  6
# [204]  1  0 19 34 15 26 31  6 14 32 10  2  3 24  2  0  2  9  3 38 14 16  1 29 16 23  2  5 28
# [233] 25  0  3 12  7  9  4 16  3 35  1  2  0 19  5  2 24  0  0 21 13 35  6  0 13 35 10

This works, but the repetition of the data frame variable names makes this a lot of 
effort to type and to read. The with function makes things easier by letting you call 
variables directly. It takes a data frame and an expression to evaluate:
  english_monarchs$length.of.reign.years <- with(
    english_monarchs,
    end.of.reign - start.of.reign
  )

The within function works in a similar way, but returns the whole data frame:
  english_monarchs <- within(
    english_monarchs,
    {
      length.of.reign.years <- end.of.reign - start.of.reign
    }
  )
Although within requires more effort in this example, it becomes more useful if 
you want to change multiple columns:
  english_monarchs <- within(
    english_monarchs,
    {
      length.of.reign.years <- end.of.reign - start.of.reign
      reign.was.more.than.30.years <- length.of.reign.years > 30
    }
  )
A good heuristic is that if you are creating or changing one column, then use 
with; if you want to manipulate several columns at once, then use within.
An alternative approach is taken by the mutate function in the plyr 
package, which accepts new and revised columns as name-value pairs:
library(plyr)
english_monarchs <- mutate(
  english_monarchs,
  length.of.reign.years        = end.of.reign - start.of.reign,
  reign.was.more.than.30.years = length.of.reign.years > 30
)
head(english_monarchs)
# name     house start.of.reign end.of.reign      domain new_name length.of.reign.years
# 1    Wehha Wuffingas             NA          571 East Anglia    Wehha                    NA
# 2    Wuffa Wuffingas            571          578 East Anglia    Wuffa                     7
# 3   Tytila Wuffingas            578          616 East Anglia   Tytila                    38
# 4  Rædwald Wuffingas            616          627 East Anglia  Rædwald                    11
# 5 Eorpwald Wuffingas            627          627 East Anglia Eorpwald                     0
# 6 Ricberht Wuffingas            627          630 East Anglia Ricberht                     3
# reign.was.more.than.30.years
# 1                           NA
# 2                        FALSE
# 3                         TRUE
# 4                        FALSE
# 5                        FALSE
# 6                        FALSE

Dealing with Missing Values
The red deer dataset that we saw in the previous chapter contains measurements 
of the endocranial volume for each deer using four different techniques. For some 
but not all of the deer, a second measurement was taken to test the repeatability 
of the technique. This means that some of the rows have missing values. 
The complete.cases function tells us which rows are free of missing values:
  data("deer_endocranial_volume", package = "learningr")
has_all_measurements <- complete.cases(deer_endocranial_volume)
deer_endocranial_volume[has_all_measurements, ]

# SkullID VolCT VolBead VolLWH VolFinarelli VolCT2 VolBead2 VolLWH2
# 7     C120   346     335   1250          289    346      330    1264
# 8      C25   302     295   1011          250    303      295    1009
# 9       F7   379     360   1621          347    375      365    1647
# 10     B12   410     400   1740          387    413      395    1728
# 11     B17   405     395   1652          356    408      395    1639
# 12     B18   391     370   1835          419    394      375    1825
# 13      J7   416     405   1834          408    417      405    1876
# 15      A4   336     330   1224          283    345      330    1192
# 20      K2   349     355   1239          286    354      365    1243

The na.omit function provides a shortcut to this, removing any rows of 
a data frame where there are missing values:
na.omit(deer_endocranial_volume)
# SkullID VolCT VolBead VolLWH VolFinarelli VolCT2 VolBead2 VolLWH2
# 7     C120   346     335   1250          289    346      330    1264
# 8      C25   302     295   1011          250    303      295    1009
# 9       F7   379     360   1621          347    375      365    1647
# 10     B12   410     400   1740          387    413      395    1728
# 11     B17   405     395   1652          356    408      395    1639
# 12     B18   391     370   1835          419    394      375    1825
# 13      J7   416     405   1834          408    417      405    1876
# 15      A4   336     330   1224          283    345      330    1192
# 20      K2   349     355   1239          286    354      365    1243

By contrast, na.fail will throw an error if your data frame contains 
any missing values:
  na.fail(deer_endocranial_volume)
Both these functions can accept vectors as well, removing missing values 
or failing, as in the data frame case.

Converting Between Wide and Long Form
The red deer dataset contains measurements of the volume of deer skulls 
obtained in four different ways. Each measurement for a particular deer is 
given in its own column. (For simplicity, let’s ignore the columns for repeat 
  measurements.) This is known as the wide form of a data frame:
deer_wide <- deer_endocranial_volume[, 1:5]
head(deer_wide)
# SkullID VolCT VolBead VolLWH VolFinarelli
# 1   DIC44   389     375   1484          337
# 2     B11   389     370   1722          377
# 3   DIC90   352     345   1495          328
# 4   DIC83   388     370   1683          377
# 5  DIC787   375     355   1458          328
# 6 DIC1573   325     320   1363          291

An alternative point of view is that each skull measurement is the same type 
of thing (a measurement), just a different measurement. So, a different way of 
representing the data would be to have four rows for each deer, with a column 
for the skull ID, as before (so each value would be repeated four times), a 
column containing all the measurements, and a factor column explaining what 
type of measurement is contained in that particular row. This is called the 
long form of a data frame.

There is a function in base R for converting between wide and long form, 
called reshape. It’s very powerful, but not entirely intuitive; a better 
alternative is to use the functionality of the reshape2 package.
The melt function available in this package converts from wide form to long.
We choose SkullID as the ID column (with everything else being classed as a 
                                    measurement):
  library(reshape2)
deer_long <- melt(deer_wide, id.vars = "SkullID")
head(deer_long)
##   SkullID variable value
## 1   DIC44    VolCT   389
## 2     B11    VolCT   389
## 3   DIC90    VolCT   352
## 4   DIC83    VolCT   388
## 5  DIC787    VolCT   375
## 6 DIC1573    VolCT   325

You can, alternatively, supply the measure.vars argument, which is all the 
columns that aren’t included in id.vars. In this case it is more work, but it 
can be useful if you have many ID variables and few measurement variables:
  melt(deer_wide, measure.vars = c("VolCT", "VolBead", "VolLWH", "VolFinarelli"))

The dcast function converts back from long to wide and returns the result as 
a data frame (the related function acast returns a vector, matrix, or array):
  deer_wide_again <- dcast(deer_long, SkullID ~ variable)

Our reconstituted dataset, deer_wide_again, is identical to the original, 
deer_wide, except that it is now ordered alphabetically by SkullID.

head(deer_wide_again)
# SkullID VolCT VolBead VolLWH VolFinarelli
# 1      A4   336     330   1224          283
# 2     B11   389     370   1722          377
# 3     B12   410     400   1740          387
# 4     B17   405     395   1652          356
# 5     B18   391     370   1835          419
# 6      B2   380     365   1680          347

Using SQL
The sqldf package provides a way of manipulating data frames using SQL. In general, 
native R functions are more concise and readable than SQL code, but if you come 
from a database background this package can ease your transition to R:
  install.packages("sqldf")
The next example compares the native R and sqldf versions of a subsetting query:
  library(sqldf)
## Loading required package: DBI
## Loading required package: gsubfn
## Loading required package: proto
## Loading required namespace: tcltk
## Loading required package: chron
## Loading required package: RSQLite
## Loading required package: RSQLite.extfuns

subset(
  deer_endocranial_volume,
  VolCT > 400 | VolCT2 > 400,
  c(VolCT, VolCT2)
)
##    VolCT VolCT2
## 10   410    413
## 11   405    408
## 13   416    417
## 16   418     NA

query <-
  "SELECT
      VolCT,
      VolCT2
    FROM
      deer_endocranial_volume
    WHERE
      VolCT > 400 OR
      VolCT2 > 400"
sqldf(query)
##   VolCT VolCT2
## 1   410    413
## 2   405    408
## 3   416    417
## 4   418     NA

SORTING
It’s often useful to have numeric data in size order, since the interesting values 
are often the extremes. The sort function sorts vectors from smallest to largest 
(or largest to smallest):
  
x <- c(2, 32, 4, 16, 8)
sort(x)
## [1]  2  4  8 16 32

sort(x, decreasing = TRUE)
## [1] 32 16  8  4  2

Strings can also be sorted, but the sort order depends upon locale. Usually letters are 
ordered from “a” through to “z,” but there are oddities: in Estonian, “z” comes 
after “s” and before “t,” for example. More of these quirks are listed in 
the Comparison help page. In an English or North American locale, you’ll see 
results like this:
  sort(c("I", "shot", "the", "city", "sheriff"))
## [1] "city"    "I"       "sheriff" "shot"    "the"

The order function is a kind of inverse to sort. The ith element of the order 
contains the index of the element of x that will end up in the ith position 
after sorting. That takes a bit of getting your head around, but mostly what 
you need to know is that x[order(x)] returns the same result as sort(x):
  order(x)
## [1] 1 3 5 4 2

x[order(x)]
## [1]  2  4  8 16 32

identical(sort(x), x[order(x)])
## [1] TRUE

order is most useful for sorting data frames, where sort cannot be used 
directly. For example, to sort the english_monarchs data frame by the year of 
the start of the reign, we can use:
year_order <- order(english_monarchs$start.of.reign)
english_monarchs[year_order, ]

The arrange function from the plyr package provides a one-line alternative for 
ordering data frames:
arrange(english_monarchs, start.of.reign)

The rank function gives the rank of each element in a dataset, providing a few 
ways of dealing with ties:
(x <- sample(3, 7, replace = TRUE))
## [1] 1 2 1 3 3 3 2
rank(x)
## [1] 1.5 3.5 1.5 6.0 6.0 6.0 3.5
rank(x, ties.method = "first")
## [1] 1 3 2 5 6 7 4

Functional Programming
Several concepts from functional programming languages like LISP and Haskell 
have been introduced into R. You don’t need to know anything at all about 
functional programming to use them;[47] you just need to know that these 
functions can be useful for manipulating data.

The Negate function accepts a predicate (that is, a function that returns 
                                         a logical vector), and returns another 
predicate that does the opposite. It returns TRUE when the input returns FALSE 
and FALSE when the input returns TRUE:
  ct2 <- deer_endocranial_volume$VolCT2  #for convenience of typing
isnt.na <- Negate(is.na)
identical(isnt.na(ct2), !is.na(ct2))
## [1] TRUE

Filter takes a function that returns a logical vector and an input vector, 
and returns only those values where the function returns TRUE:
  Filter(isnt.na, ct2)
## [1] 346 303 375 413 408 394 417 345 354

The Position function behaves a little bit like which, which we saw in Vectors. 
It returns the first index where applying a predicate to a vector returns TRUE:
  Position(isnt.na, ct2)
## [1] 7

Find is similar to Position, but it returns the first value rather than the first index:
  Find(isnt.na, ct2)
## [1] 346

Map applies a function element-wise to its inputs. It’s just a wrapper to mapply, 
with SIMPLIFY = FALSE. In this next example, we retrieve the average measurement 
using each method for each deer in the red deer dataset. First, we need a function 
to pass to Map to find the volume of each deer skull:
  get_volume <- function(ct, bead, lwh, finarelli, ct2, bead2, lwh2)
  {
    #If there is a second measurement, take the average
    if(!is.na(ct2))
    {
      ct <- (ct + ct2) / 2
      bead <- (bead + bead2) / 2
      lwh <- (lwh + lwh2) / 2
    }
    #Divide lwh by 4 to bring it in line with other measurements
    c(ct = ct, bead = bead, lwh.4 = lwh / 4, finarelli = finarelli)
  }
Then Map behaves like mapply — it takes a function and then each argument to pass 
to that function:
  measurements_by_deer <- with(
    deer_endocranial_volume,
    Map(
      get_volume,
      VolCT,
      VolBead,
      VolLWH,
      VolFinarelli,
      VolCT2,
      VolBead2,
      VolLWH2
    )
  )
head(measurements_by_deer)
## [[1]]
##        ct      bead     lwh.4 finarelli
##       389       375       371       337
##
## [[2]]
##        ct      bead     lwh.4 finarelli
##     389.0     370.0     430.5     377.0
##
## [[3]]
##        ct      bead     lwh.4 finarelli
##     352.0     345.0     373.8     328.0
##
## [[4]]
##        ct      bead     lwh.4 finarelli
##     388.0     370.0     420.8     377.0
##
## [[5]]
##        ct      bead     lwh.4 finarelli
##     375.0     355.0     364.5     328.0
##
## [[6]]
##        ct      bead     lwh.4 finarelli
##     325.0     320.0     340.8     291.0

