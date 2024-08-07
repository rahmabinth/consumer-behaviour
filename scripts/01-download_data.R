#### Preamble ####
# Purpose: Downloads and saves the data from Statistics Canada
# Author: Rahma Binth Mohammad
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rahma.binthmohammad@mail.utoronto.ca
# Pre-requisites: Run "00-install_packages.R".
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(cansim)
library(tidyverse)
library(dplyr)

#### Download data ####

#Household spending data
spending <- get_cansim("11-10-0222-01")

#Annual CPI data
cpi <- get_cansim("18-10-0005-01")

#Household income
income <- get_cansim("11-10-0008-01")

#### Save data ###
write_csv(spending, "data/raw_data/spending.csv") 
write_csv(cpi, "data/raw_data/cpi.csv") 
write_csv(income, "data/raw_data/income.csv") 
