#### Preamble ####
# Purpose: Cleans the raw Paramedic Services Incident Data from Open Data Toronto
# Author: Denise Chang
# Date: 25 November 2024
# Contact: dede.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.R

#### Workspace setup ####
library(tidyverse)
library(openxlsx)
library(janitor)
library(arrow)

#### Clean data ####

# read the different XLSX files
data_2017 <-
  read_xlsx("data/01-raw_data/paramedic_services_2017.xlsx")
data_2018 <-
  read_xlsx("data/01-raw_data/paramedic_services_2018.xlsx")
data_2019 <-
  read_xlsx("data/01-raw_data/paramedic_services_2019.xlsx")
data_2020 <-
  read_xlsx("data/01-raw_data/paramedic_services_2020.xlsx")
data_2021 <-
  read_xlsx("data/01-raw_data/paramedic_services_2021.xlsx")
data_2022 <-
  read_xlsx("data/01-raw_data/paramedic_services_2022.xlsx")

# combine files into one dataframe
all_data <- bind_rows(data_2017,
                      data_2018,
                      data_2019,
                      data_2020,
                      data_2021,
                      data_2022)

expanded_data <-
  clean_names(all_data) |>
  # remove the entries with missing values
  filter(!is.na(dispatch_time),!is.na(incident_type)) |>
  # make incident_type uniform
  mutate(incident_type = trimws(tolower(incident_type))) |>
  filter(incident_type != "-", incident_type != "airport standby") |>
  # separate time factors from dispatch time
  mutate(
    year = as.integer(year(dispatch_time)),
    month = month(dispatch_time, label = TRUE),
    day_of_week = wday(dispatch_time, label = TRUE),
    hour = hour(dispatch_time)
  )

# select the variables of interest
selected_data <-
  expanded_data |>
  select(year,
         month,
         day_of_week,
         hour,
         incident_type,
         units_arrived_at_scene)

# find average of units_arrived_at_scene while other variables are constant
clean_data <-
  selected_data |>
  group_by(year, month, day_of_week, hour, incident_type) |>
  summarise(
    avg_units_arrived = as.numeric(format(round(mean(units_arrived_at_scene, na.rm = TRUE), 1), nsmall = 1)),
    count = n()
  ) |>
  ungroup()

#### Save data ####
write_parquet(x = clean_data,
              sink = "data/02-analysis_data/analysis_data.parquet")