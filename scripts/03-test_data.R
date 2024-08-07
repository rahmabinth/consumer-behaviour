#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: Run the "00-install_packages.R", "01-download_data", and "02-data_cleaning"
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Load data ####
spending <- read.csv("data/analysis_data/spending.csv")
cpi <- read.csv("data/analysis_data/cpi.csv")
income <- read.csv("data/analysis_data/income.csv")

#### Test data ####
#Check class of data columns for all three datasets
spending$Year |> class() == "integer"
spending$GEO |> class() == "character"
spending$expenditure_categories |> class() == "character"
spending$VALUE |> class() == "integer"

cpi$Year |> class() == "integer"
cpi$GEO |> class() == "character"
cpi$product_groups |> class() == "character"
cpi$VALUE |> class() == "numeric"

income$Year |> class() == "integer"
income$GEO |> class() == "character"
income$Sex |> class() == "character"
income$income_categories |> class() == "character"
income$VALUE |> class() == "integer"

#Check years in common
years_spending <- unique(spending$Year)
years_cpi <- unique(cpi$Year)
years_income <- unique(income$Year)
years_common <- Reduce(intersect, list(years_spending, years_cpi, years_income))

#Check missing values
is.na(spending)
is.na(cpi)
is.na(income)

