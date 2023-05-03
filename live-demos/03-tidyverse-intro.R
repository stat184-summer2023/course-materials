#####################
### Intro to the Tidyverse 
#####################
#Load the Library
library(tidyverse)



### Loading in a data set in Tidyverse --------------------------------


## In Tidyverse use read_filetype("path/to/file.filetype")
# To read in a tsv we use 
?read_tsv
dat.football <- read_tsv(file = "https://raw.githubusercontent.com/ada-lovecraft/ProcessingSketches/master/Bits%20and%20Pieces/Football_Stuff/data/nfl-salaries.tsv")

### Explore the data ---------------------------------
# Before we can do wrangling or visualizations, we need to know some
# basic properties of the data


## View the top portion of the data to get an idea of what it looks like 
head(dat.football) #default is first 6 rows and all the columns
head(dat.football, n =10)
dat.football %>%
  slice(1:10)

## The following 4 functions are not tidyverse functions, 
## they are part of base R. But they help us understand our data set

## Get the dimensions of the data
dim(dat.football)

## Get the column names of the data 
colnames(dat.football)

## Get the row names of the data 
rownames(dat.football) #meaningless! (most times they will be)

## Get a summary of the data 
summary(dat.football) # gives summary info by column



### Basic Functions in Tidyverse -------------------------------------------------
# Tidyverse uses "verbs" as function names to describe what it is doing to the data
# Let's look at a few of these "verbs"

#Filter 
dat.football %>%
  filter(Team == "Denver Broncos")
  
#Arrange 
dat.football %>%
  arrange(Salary) #lowest to highest

dat.football %>%
  arrange(desc(Salary)) #highest to lowest

#Select
dat.football %>%
  select(PlayerName, Position)

#Rename 
dat.football %>%
  rename(TeamName = Team)

#Mutate
dat.football %>%
  mutate(PercentOfCap = Salary / SalaryCap * 100)

#Group 
dat.football %>%
  group_by(Team) #doesn't look like it did anything??? 

#Summarise 
dat.football %>%
  summarise(MeanSalary = mean(Salary))

dat.football %>%
  summarize(SdSalary = sd(Salary))

?summarise
dat.football %>%
  group_by(Team) %>%
  summarise(MeanSalary = mean(Salary), .groups = "keep" )


### Exploratory Analysis - Combining it all together ------------------------------------
# What is the highest salary? 
max(dat.football$Salary)

#Which player has this salary? 

# Method 1 - base R
max.salary <- max(dat.football$Salary) #get the max salary
row.max.salary <- dat.football$Salary == max.salary
answer.1 <- dat.football$PlayerName[row.max.salary]

#c(1, 2, 3, 4)[c(FALSE, FALSE, TRUE, FALSE)]

# Method 2 - tidyverse
answer.2 <- dat.football %>%
  filter(Salary == max(Salary) ) %>%
  select(PlayerName)

# Method 3 - tidyverse
answer.3 <- dat.football %>%
  arrange(desc(Salary)) %>%
  slice(1) %>%
  select(PlayerName)

### Whats the benefit of using tidyverse functions? -------------------------------------
library(utils)
object.size(c(max.salary, row.max.salary, answer.1))
object.size(answer.2)
object.size(answer.3)

944/12304 # used only 7% of the storage space by using tidyverse 


### More Involved questions ---------------------------------------------------
## What is the team with the highest paid roster, and what was their total pay? 
## What is the team with the lowest paid roster, and what was their total pay?
Paid <- dat.football %>%
  group_by(Team)%>% 
  summarize(PaidRoster = sum(Salary)) %>% 
  arrange(desc(PaidRoster))
Paid[1, ] #highest paid 
# how many teams are in our data set> 
dim(Paid)
length(unique(dat.football$Team))
Paid[31, ] 

#Bonus Question, if I said this data was from 2016 what team is missing from our data?
sort(unique(dat.football$Team)) 


#------ Pivot Wider and Pivot Longer ----------------------
# You don't need to know these right now, we will have a lecture on pivot wider
# and pivot longer in a few weeks. I just wanted to show a brief introduction. 


## Pivot Wider 
?pivot_wider

# names_from = new column names 
# value_from = values to fill in in the table
us_rent_income
us_rent_income %>%
  pivot_wider(
    names_from = variable,
    values_from = c(estimate, moe)
  )
# is the above table tidy? What is each case?

## Pivot Longer 
?pivot_longer
#name_to = new column name that will contain the old column names
#values_to = new column name that will contain the data from the original table
relig_income
relig_income %>%
  pivot_longer(!religion,  # every column but religion 
               names_to = "income", 
               values_to = "count")
# Is the above table Tidy? What is a case?

world_bank_pop
world_bank_pop %>%
  pivot_longer(!c(country, indicator),
               names_to = "year",
               values_to = "count")
# is the above table tidy? What is a case?
