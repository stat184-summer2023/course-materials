######################
### Pole Vaulting 
### In class example
#####################

## Load Libraries -------------------------------------------
require(mosaic)
require(lubridate)
require(tidyverse)
require(rvest)

## Webscraping (Did this on Week 10) ------------------------------------

webpage <- "https://en.wikipedia.org/wiki/Men%27s_pole_vault_world_record_progression"

table_list <- 
  webpage %>%
  read_html(header=TRUE) %>%
  html_nodes(css = "table") %>%
  html_table(fill = TRUE)

PVRecords <- table_list[[2]]  # convert list to data frame
head(PVRecords, 3) # inspect the data


## Task 1 ------------------------------------------------------------------
# fix the variable name representing the number of world records achieved by each athlete
Part1 <-
  PVRecords %>%
  rename(numRecords = `#[4]` )

View(Part1)

## Task 2 ------------------------------------------------------------------
# locate and replace all footnotes in the `Date` variable using `gsub()`

Part2 <- 
  Part1 %>%
  mutate(Date = gsub(pattern = "\\[\\d\\]$", replacement = "", Date))
View(Part2)

Part2 <- 
  Part1 %>%
  mutate(Date = gsub(pattern = "\\[.\\]", replacement = "", Date))
View(Part2)


## Task 3 ------------------------------------------------------------------
# convert `Date` to a date class variable in R using a `lubridate` function
head(Part2)

Part3 <- 
  Part2 %>%
  mutate(Date = lubridate::mdy(Date))
head(Part3)
View(Part3)

## Task 4 ------------------------------------------------------------------
# use `tidyr::extract()` to store the metric heights from the `Record` variable 
# (make sure there are no spaces )


Part4 <- 
  Part3 %>%
  tidyr::extract(col= Mark,
                 into = "TidyMark", 
                 regex = "(^\\d\\.\\d\\d)"
                 ) %>%
  mutate(TidyMark = as.numeric(TidyMark))

View(Part4)

