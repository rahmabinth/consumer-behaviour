#### Preamble ####
# Purpose: Downloads and saves the data from Statistics Canada
# Author: Rahma Binth Mohammad
# Date: July 20, 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# Pre-requisites: Run "00-install_packages.R".

#### Workspace setup ####
library(cansim)
library(tidyverse)
library(dplyr)

#### Download data from Statistics Canada ####

#Household spending data
spending <- get_cansim("11-10-0222-01")

#Annual CPI data
cpi <- get_cansim("18-10-0005-01")

#Household income, Data is too large to push to git, hence it is downloaded. 
#You can use this code to get it directly. 
#income <- get_cansim("11-10-0008-01")

#### Save data ###
write_csv(spending, "data/raw_data/spending.csv") 
write_csv(cpi, "data/raw_data/cpi.csv") 
#write_csv(income, "data/raw_data/income.csv") 
