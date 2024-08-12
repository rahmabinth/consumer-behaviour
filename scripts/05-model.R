#### Preamble ####
# Purpose: Models the data two different ways.
# Author: Rahma Binth Mohammad
# Date: July 24, 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the "00-install_packages.R", "02-download_data.R", and "03-data_cleaning.R" files. 

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
total_ex_cpi <- read.csv("data/analysis_data/total_ex_cpi.csv") 
ex_cpi_income <- read.csv("data/analysis_data/ex_cpi_income.csv")

### Model data ####
first_model <-
  stan_glm(
    formula = expenditure ~ cpi,
    data = total_ex_cpi,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 5678
  )

second_model <-
  stan_glm(
    formula = expenditure ~ cpi + income,
    data = ex_cpi_income,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 5678
  )
  
#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)
