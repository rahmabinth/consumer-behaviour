#### Preamble ####
# Purpose: Cleans the raw plane data recorded by Statistics Canada and filters the necessary columns
# Author: Rahma Binth Mohammad
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run "00-install_packages.R" and "01-download_data". 
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####

#Filter and rename the household spending data
spending <- read.csv("data/raw_data/spending.csv")

spending <- spending %>% 
  rename(expenditure_categories = Household.expenditures..summary.level.categories, Year = REF_DATE)

spending <- spending %>%
  filter(GEO == "Ontario",
         expenditure_categories %in% c("Total expenditure", "Shelter", "Food expenditures", "Recreation")) %>%
  select(Year, GEO, expenditure_categories, VALUE)

#Filter and rename the annual CPI data
cpi <- read.csv("data/raw_data/cpi.csv")

cpi <- cpi %>% 
  rename(product_groups = Products.and.product.groups, Year = REF_DATE)
  
cpi <- cpi %>%
  filter(GEO == "Ontario", Year >= 2010, Year <= 2021,
         product_groups %in% c("All-items", "Shelter", "Food", "Recreation, education and reading")) %>%
  select(Year, GEO, product_groups, VALUE)

#Filter and rename the household income data
income <- read.csv("data/raw_data/income.csv")

income <- income %>% 
  rename(income_categories = Persons.with.income, Year = REF_DATE, age = Age.group)

income <- income %>%
  filter(GEO == "Ontario", Year >= 2010, Year <= 2021, age == "All age groups",
         Sex == "Both sexes", income_categories == "All persons with income") %>%
  select(Year, GEO, Sex, income_categories, VALUE)

#Combine household spending and annual CPI data
spending_n_cpi <- bind_rows(spending, cpi)

#Isolate total household spending and all-items CPI data with just year and value
total_ex_year <- spending %>%
  filter(expenditure_categories == "Total expenditure") %>%
  select(Year, VALUE)

all_cpi_year <- cpi %>%
  filter(product_groups == "All-items") %>%
  select(Year, VALUE)

#Combine the isolated data
total_ex_cpi <- inner_join(all_cpi_year, total_ex_year, by = "Year")

#Rename the values
total_ex_cpi <- total_ex_cpi %>% 
  rename(cpi = VALUE.x, expenditure = VALUE.y)

#Isolate spending and CPI data for the SHELTER category with just year and value
shelter_ex <- spending %>%
  filter(expenditure_categories == "Shelter") %>%
  select(Year, VALUE)

shelter_cpi <- cpi %>%
  filter(product_groups == "Shelter") %>%
  select(Year, VALUE)

#Combine the isolated data
shelter_ex_cpi <- inner_join(shelter_cpi, shelter_ex, by = "Year")

#Isolate spending and CPI data for the FOOD category with just year and value
food_ex <- spending %>%
  filter(expenditure_categories == "Food expenditures") %>%
  select(Year, VALUE)

food_cpi <- cpi %>%
  filter(product_groups == "Food") %>%
  select(Year, VALUE)

#Combine the isolated data
food_ex_cpi <- inner_join(food_cpi, food_ex, by = "Year")

#Isolate spending and CPI data for the RECREATION category with just year and value
recreation_ex <- spending %>%
  filter(expenditure_categories == "Recreation") %>%
  select(Year, VALUE)

recreation_cpi <- cpi %>%
  filter(product_groups == "Recreation, education and reading") %>%
  select(Year, VALUE)

#Combine the isolated data
recreation_ex_cpi <- inner_join(recreation_cpi, recreation_ex, by = "Year")

#Isolate income data with just year and value
income_year <- income %>%
  select(Year, VALUE)

#Combine total expenditure data and income values
spending_n_income <- inner_join(income_year, total_ex_year, by = "Year")

#Combine total expenditure and cpi data with total household income values
ex_cpi_income <- inner_join(income_year, total_ex_cpi, by = "Year")

#Rename the values
ex_cpi_income <- ex_cpi_income %>% 
  rename(income = VALUE)

#### Save data ###
write_csv(spending, "data/analysis_data/spending.csv") 
write_csv(cpi, "data/analysis_data/cpi.csv")
write_csv(income, "data/analysis_data/income.csv")
write_csv(total_ex_cpi, "data/analysis_data/total_ex_cpi.csv") 
write_csv(shelter_ex_cpi, "data/analysis_data/shelter_ex_cpi.csv")
write_csv(food_ex_cpi, "data/analysis_data/food_ex_cpi.csv")
write_csv(recreation_ex_cpi, "data/analysis_data/recreation_ex_cpi.csv")
write_csv(spending_n_income, "data/analysis_data/spending_n_income.csv")
write_csv(ex_cpi_income, "data/analysis_data/ex_cpi_income.csv") 


