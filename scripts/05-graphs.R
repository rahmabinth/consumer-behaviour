#### Preamble ####
# Purpose: Creates graphs with filtered data that is included in the paper, useful for reproduction
# Author: Rahma Binth Mohammad
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rahma.binthmohammad@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(scales)

#### Load data ####
spending <- read.csv("data/analysis_data/spending.csv")

# Calculate summary statistics
spending_stats <- spending %>%
  group_by(expenditure_categories) %>%
  summarise(
    mean_value = mean(VALUE, na.rm = TRUE),
    median_value = median(VALUE, na.rm = TRUE),
    sd_value = sd(VALUE, na.rm = TRUE),
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
    mean_value = mean(VALUE, na.rm = TRUE),
    median_value = median(VALUE, na.rm = TRUE),
    sd_value = sd(VALUE, na.rm = TRUE),
    .groups = 'drop'
  )

# Print summary statistics
print(cpi_stats)

#### Load data ####
income <- read.csv("data/analysis_data/income.csv")

# Calculate and print summary statistics
# Only one category in data - "All persons with income"
summary(income$VALUE)

#Plot spending categories for the years
spending_colours <- c(
  "Total expenditure" = "goldenrod3", 
  "Food" = "purple",
  "Shelter" = "darkgreen",
  "Recreation" = "blue")
spending_n_year <- ggplot(spending, aes(x = Year, y = VALUE, color = expenditure_categories, group = expenditure_categories)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Household Spending per Year",
    x = "Year",
    y = "Expenditure Value ($)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom") +
  scale_color_manual(values = spending_colours, name = NULL) +
  scale_x_continuous(
    breaks = seq(2010, 2021, by = 2)) +
  scale_y_continuous(
      labels = scales::comma
    )

print(spending_n_year)
#Plot CPI values for each category for each year
#Set colours so that it is easily comparible with spending data
cpi_colours <- c(
  "All-items" = "goldenrod3", 
  "Food" = "purple",
  "Shelter" = "darkgreen",
  "Recreation" = "blue")

cpi_n_year <- ggplot(cpi, aes(x = Year, y = VALUE, color = product_groups, group = product_groups)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Consumer Price Index (CPI) per Year",
    x = "Year",
    y = "CPI",
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5), 
    legend.position = "bottom") +
  scale_color_manual(values = cpi_colours, name = NULL) +
  scale_x_continuous(
    breaks = seq(2010, 2021, by = 2)) +
  scale_y_continuous(
    breaks = seq(100, 160, by = 10),
    limits = c(100, 160)
  )

print(cpi_n_year)

#Plot the number of income earners against the year
ggplot(income, aes(x = Year, y = VALUE)) +
  geom_line(colour = "darkred") +
  geom_point(colour = "darkred") +
  labs(
    title = "Number of Income Earners",
    x = "Year",
    y = "Income Earners"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(
    breaks = seq(2010, 2021, by = 2)) +
  scale_y_continuous(
    labels = scales::comma,
    limits = c(9600000, 11250000)
  )

#Plot spending against cpi
ggplot(total_ex_cpi, aes(x = cpi, y = expenditure, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) +
  labs(
    x = "All-Items CPI",
    y = "Total Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d() +
  scale_x_continuous(
    limits = c(115, 145)) +
  scale_y_continuous(
    labels = scales::comma,
    limits = c(75000, 100000)
  )

ggplot(shelter_ex_cpi, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5,  aes(group = 1)) +
  labs(
    x = "Shelter CPI",
    y = "Shelter Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d() +
  scale_x_continuous(
    limits = c(120, 160)) +
  scale_y_continuous(
    labels = scales::comma,
    limits = c(16000, 25000)
  )

ggplot(food_ex_cpi, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5,  aes(group = 1)) +
  labs(
    x = "Food CPI",
    y = "Food Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d() +
  scale_x_continuous(
    limits = c(120, 160)) +
  scale_y_continuous(
    labels = scales::comma,
    limits = c(7000, 11000)
  )

ggplot(recreation_ex_cpi, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) +
  labs(
    x = "Recreation CPI",
    y = "Recreation Expenditure",
    color = "Year"
  ) +
  theme_minimal() +
  scale_color_viridis_d() +
  scale_y_continuous(
    labels = scales::comma
  )

# Plot with points and lines
ggplot(spending_n_income, aes(x = VALUE.x, y = VALUE.y, color = factor(Year))) +
  geom_point(size = 1) +
  geom_line(linewidth = 0.5, aes(group = 1)) + # Connect the points with a line
  labs(
    x = "Number of Income Earners",
    y = "Total Expenditure",
    color = "Year") +
  theme_minimal() +
  scale_color_viridis_d() +
  scale_x_continuous(
    labels = scales::comma) +
  scale_y_continuous(
    labels = scales::comma)

