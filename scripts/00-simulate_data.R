#### Preamble ####
# Purpose: Simulates a dataset of paramedics incidents in Toronto from 2017 to 2022
# Author: Denise Chang
# Date: 26 November 2024
# Contact: dede.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(arrow)

set.seed(304) # random seed for reproducibility

#### Simulate Data ####
incident_types <-
  c("emergency transfer",
    "fire",
    "medical",
    "motor vehicle accident")
months <- month.name  # Full month names
days_of_week <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")

# Create all combinations of year, month, and day_of_week (subset of real dataset)
year_month_day_combinations <- expand.grid(
  year = sample(2017:2022, 10, replace = TRUE),
  month = sample(months, 10, replace = TRUE),
  day_of_week = sample(days_of_week, 10, replace = TRUE)
)

# Create ordered factors for month and day_of_week
year_month_day_combinations$month <-
  factor(year_month_day_combinations$month,
         levels = months,
         ordered = TRUE)
year_month_day_combinations$day_of_week <-
  factor(year_month_day_combinations$day_of_week,
         levels = days_of_week,
         ordered = TRUE)

# For each combination of year, month, and day_of_week, create one record for each incident_type
simulated_data <- year_month_day_combinations |>
  rowwise() |>
  do({
    tibble(
      year = rep(.$year, length(incident_types)),
      month = rep(.$month, length(incident_types)),
      day_of_week = rep(.$day_of_week, length(incident_types)),
      incident_type = incident_types,
      hour = sample(0:23, length(incident_types), replace = TRUE),
      avg_units_arrived = runif(length(incident_types), 1, 5),
      count = sample(1:5, length(incident_types), replace = TRUE)
    )
  }) |>
  ungroup()  # Remove the grouping after generating all records

#### Save data ####
write_parquet(simulated_data,
              "data/00-simulated_data/simulated_data.parquet")
