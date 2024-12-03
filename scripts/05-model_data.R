#### Preamble ####
# Purpose: Models number of calls based on temporal factors, incident type and average units on incident scene
# Author: Denise Chang
# Date: 2 December 2024
# Contact: dede.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.R and 03-clean_data.R

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Model data ####
# Read data
clean_data <-
  read_parquet("data/02-analysis_data/analysis_data.parquet")

# Prepare data
clean_data <- clean_data |>
  mutate(
    avg_units_arrived = as.numeric(avg_units_arrived),
    month = factor(month, levels = month.abb, ordered = TRUE),
    day_of_week = factor(
      day_of_week,
      levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"),
      ordered = TRUE
    ),
    incident_type = factor(incident_type)
  )

# Fit the model using rstanarm
incident_model <- stan_glm(
  formula = count ~ year + month + day_of_week + hour + incident_type + avg_units_arrived,
  data = clean_data,
  family = gaussian(),
  prior = normal(0, 2.5),
  prior_intercept = normal(0, 2.5),
  prior_aux = exponential(1),
  seed = 123
)

#### Save model ####
saveRDS(incident_model,
        file = "models/incident_model.rds")
