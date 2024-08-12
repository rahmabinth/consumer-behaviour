#### Preamble ####
# Purpose: Simulates the dataset
# Author: Rahma Binth Mohammad
# Date: July 20, 2024
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run "00-install_packages.R."

#### Workspace setup ####

library(tidyverse)

#### Simulate data ####

set.seed(5678)

years <- seq(1990, 2021, by = 1)

expenditure_predictions <- tibble(
  Year = years,
  cpi = rnorm(length(years), mean = 120, sd = 10),
  income = round(rnorm(length(years), mean = 10000, sd = 1500))
)

print(expenditure_predictions)

#### Test simulated data ####

nrow(expenditure_predictions) == 32

expenditure_predictions$Year |> class() == "numeric"

expenditure_predictions$cpi |> class() == "numeric"

expenditure_predictions$income |> class() == "integer"


