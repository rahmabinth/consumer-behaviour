#### Preamble ####
# Purpose: Creates graphs with filtered data
# Author: Rahma Binth Mohammad
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Load data ####
spending <- read.csv("data/analysis_data/spending.csv")

summary(spending)
# Calculate summary statistics
spending_stats <- spending %>%
  group_by(expenditure_categories) %>%
  summarise(
    count = n(),
    mean_value = mean(VALUE, na.rm = TRUE),
    median_value = median(VALUE, na.rm = TRUE),
    sd_value = sd(VALUE, na.rm = TRUE),
    min_value = min(VALUE, na.rm = TRUE),
    max_value = max(VALUE, na.rm = TRUE),
    .groups = 'drop'
  )

# Print summary statistics
print(spending_stats)

#### Load data ####
cpi <- read.csv("data/analysis_data/cpi.csv")

# Calculate summary statistics
cpi_stats <- cpi %>%
  group_by(product_groups) %>%
  summarise(
    count = n(),
    mean_value = mean(VALUE, na.rm = TRUE),
    median_value = median(VALUE, na.rm = TRUE),
    sd_value = sd(VALUE, na.rm = TRUE),
    min_value = min(VALUE, na.rm = TRUE),
    max_value = max(VALUE, na.rm = TRUE),
    .groups = 'drop'
  )

# Print summary statistics
print(cpi_stats)

#### Load data ####
income <- read.csv("data/analysis_data/income.csv")

# Calculate and print summary statistics
# Only one category in data - "All persons with income"
summary(income$VALUE)

ggplot(total_ex_cpi, aes(x = cpi, y = expenditure, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) + # Connect the points with a line
  labs(
    title = "Total Expenditure vs All-Items CPI",
    x = "All-Items CPI",
    y = "Total Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d()

ggplot(shelter_ex_cpi, aes(x = VALUE.x, y = VALUE.y)) +
  geom_point() +
  labs(
    title = "Shelter Expenditure vs Shelter CPI",
    x = "Shelter CPI",
    y = "Shelter Expenditure"
  ) +
  theme_minimal()

ggplot(food_ex_cpi, aes(x = VALUE.x, y = VALUE.y)) +
  geom_point() +
  labs(
    title = "Food Expenditure vs Food CPI",
    x = "Food CPI",
    y = "Food Expenditure"
  ) +
  theme_minimal()

ggplot(recreation_ex_cpi, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) + # Connect the points with a line
  labs(
    title = "Recreation Expenditure vs Recreation CPI",
    x = "Recreation CPI",
    y = "Recreation Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d()

# Plot with points and lines
ggplot(spending_n_income, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) + # Connect the points with a line
  labs(
    title = "Income vs Expenditure by Year",
    x = "Income",
    y = "Total Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d()
