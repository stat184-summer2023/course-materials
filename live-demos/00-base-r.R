###########################
### R Programming Basics
##########################

## To run a line either click "Run" at the top of the script 
## or press "Ctrl + enter" on a Windows machine 
## or press "Cmnd + return" on a Mac

##########################
### The Basics
###########################

## R works just like a calculator for numbers 
5 + 2
10 * (2 - 9)
3^2 / 9
2.8923 * 23.231
10e3 #scientific notaation 

## Use " " or ' ' for character stings strings
"Hello World"
'Hello World'
'This is also a string'
"1, 2, 3" #this is a string, NOT a vector 

## Use c() to create a vector
c(1, 2, 3)
c("A", "B", "C")
c("1", "2", "3")
c(1, "B", 3) #note R forces all of these to become character strings


## Use : to create a sequential list 
# list all numbers from 1 to 10 
1:10

#list all numbers from 10 to 1
10:1

## Logicals in R are TRUE and FALSE or T and F
TRUE
T
FALSE
F

## R has some basic functions already loaded in 

#mean of 1, 2, 3, 4, 5
mean(c(1, 2, 3, 4, 5)) 

# calculate 4!
factorial(4) 

#generate 10 normal random variables with mean 5 and standard deviation 2
rnorm(10, mean = 5, sd = 2)

# find the object type
class(TRUE)
class("A")
class(1:6)
class(1.3)

## Whenever we want more information about a function we type ?function_name
## this will prompt the help files to pop up in the bottom right pane of RStudio
## Help files provide information about what the function does, the arguments is takes in, and examples
?mean
?rnorm
?c
?class
?sample

#############################
### Assignment
#############################

## in R we use <- (assign) to assign variable and function values
## we ues = (equals) inside functions to give arguments values 

rolls <- 10
dice <- 1:6
results <- sample(x = dice, size = rolls, replace = TRUE)


###########################
### Indexing
###########################
## WARNING: R starts indexing a 1 (most other coding languages start indexing at 0)

## In R we use [ ] to reference items at an index in a vector 
my.vector <- c("First", "Second", "Third", "Fourth", "Fifth")

# get the 1st element in my.vector
my.vector[1] 

# get the 2nd, 3rd, 4th elements in my.vector
my.vector[2:4] 

# Be careful that you do not try to index something that does not exist
my.vector[7] # this will say NA because there is nothing in the 7th element of my.vector
my.vector[0] # this will say character(0) means the object is "of 0 length" i.e. nothing is there

## We can use the "-" sign to indicate we want all elements "except" the ones listed
# output all elements except the first one 
my.vector[ -1 ]

#output all elements except the the first and third ones 
my.vector[ -c(1, 3) ]


## When indexing matrices, the format is [row_number, column_number]
#Create a matrix 
?matrix
my.matrix <- matrix(1:10, nrow = 2, ncol=5)

#look at the matrix
my.matrix

#look at the element in the 1st row and 2nd column
my.matrix[1, 2]

# If we leave the row_number blank, it will output every element in that column
my.matrix[ , 5] #outputs all number in column 5

# Similar for columns
my.matrix[1, ] #outputs all number in row 1



########################
### Vectorization
########################
## Unlike most other coding languages, R is vectorized
## What does this mean??? 
## The default for R is to do component wise operations, 
## and not traditional matrix multiplication 

## In R, I can multiply a constant by a vector 
## This works just like traditional mathematics would
x <- c(1, 2, 3)
2 * x # = c(2, 4, 6)

## However, that is where the similarities between R and traditional mathematics end
## In traditional mathematics if I multiply [ 2  4  6] * [5, 10, 15]  I would get 
## [ 2  4  6] * [5, 10, 15] = (2 * 5) + (4 * 10) + (6 * 15) = 140
## This is not what happen in R 
v1 <- c(2, 4, 6)
v2 <- c(5, 10, 15) 

v1 * v2 #outputs c(10, 40, 90). This is not 140. What happened? 

## R did element wise computations 
## R saw that you have 2 vectors, each of length 3 
## It multiplied the first element in v1 and the first element in v2,
## then multiplied the second element in v1 and the second element in v2,
## then multiplied the third element in v1 and the third element in v2,
## and outputs one vector of length 3.

## Similar things happen for +, -, /, and ^
v1 + v2
v1 - v2
v1 / v2
v2^v1

## If we want to do traditional matrix multiplication, we use %*%
## The output will be a matrix, not a vector 
v1 %*% v2 # = 140

## Note, if we ever want to calculate the inverse of a matrix, we use solve()
mat <- matrix(c(1,2,3,4), nrow = 2, ncol = 2)

?solve
solve(mat) #inverse of mat

mat %*% solve(mat) # identity matrix

#########################
### Data Frames
########################

## R stores data in objects called data frames 
## Lets create a data frame with 2 columns, Age (in years) and Height (in cm)

my.data <- data.frame( "Age" = c(23, 12, 90, 41, 87),
                       "Height" = c(162.3, 121.0, 174.8, 185.2, 168.9))

# This will display your data frame in the console
my.data

# This is will display your data in a new window 
View(my.data)
# Equivalently, you can also click on the "my.data" row in the Environment pane

## We can reference the information in "Age" column in a few different ways
## All of the following are equivalent 
my.data[ , 1]
my.data[ , "Age"]
my.data$Age

## If you have a large ata set, you can use `head()` to look at the first few rows
iris #this is big! too much to look at on one screen

#just look at the top few rows
head(iris)

## R has a few built in constants 
pi
letters
LETTERS
state.abb
state.name
month.abb
month.name

######################
### Logicals and Operators 
###  >, <, ==, <=, >=, !=, |, &
######################

### As mentioned above, R uses TRUE and FALSE and T and F
TRUE
T
FALSE
F

# >, < is greater than and less than 
5 > 3        # True 
7 * 2 > 100  # False 
9 < 9        # False

# >=, <= greater than or equal to, and less than or equal to
5 >= 3          # True
(7 * 2) >= 100  # False 
9 <= 9          # True 

# == is "is equal to?"
10 == 2 * 5    # True
7 == 14 / 3    # False  
TRUE == TRUE   # True
FALSE == FALSE # True
TRUE == FALSE  # False

# Be careful of precision errors 
sqrt(2) == 1.414214      # False
pi == 3.14159265358979   # False

# >, <, <=, >=, == are also vectorized functions
c(5, 6) <= c(9, 12)
c(TRUE, 5 * 8) <= c(FALSE, 40)
5 == c(5, 6)

## Comparing NA values
#you can not use typical comparison operators with NA values
5 == NA # = NA, not FALSE #notice the caution arrow on next to the line number
NA == NA # = NA, not TRUE
# We use is.na() to test for NA values 
is.na(5) # False
is.na(NA) # True 
is.na(NA * 5) # True

### And" and "Or"
# & is the "and" operator 
TRUE & FALSE #False 
TRUE & TRUE #True
FALSE & FALSE #False 
x <- 2
y <- -10
(x < 3) & (y > -50) #True
(x <= 2) & (y < -25 ) #False


# | is the "or" operator (in math, "or" mean one, the other, or both)
TRUE | FALSE #True 
TRUE | TRUE #True
FALSE | FALSE #False 

x <- 2
y <- -10
(x < 3) | (y > -50) #True
(x <= 2) | (y < -25 ) #True

# | and & are also vectorized operators 
c(TRUE, TRUE, FALSE) | c(FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE) & c(FALSE, TRUE, FALSE)


