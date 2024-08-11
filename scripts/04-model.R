#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rahma Binth Mohammad
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run the "00-install_packages.R", "01-download_data.R", "02-data_cleaning.R", "03-test_data.R"
# Any other information needed? [...UPDATE THIS...]

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

