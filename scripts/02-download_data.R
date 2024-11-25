#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Denise Chang
# Date: 20 November 2024
# Contact: dede.chang@utoronto.ca
# License: MIT
# Pre-requisites: None

#### Preamble ####
# Purpose: Download and save the actual Paramedic Services Incident Data from 2017 to 2022
# from Open Data Toronto
# Author: Julia Lee
# Date: 23 September 2024
# Contact: jlee.lee@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? N/A


#### Setting Up the Workspace ####

library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Downloading the Data #### 

package <- show_package("c21f3bd1-e016-4469-abf5-c58bb8e8b5ce")

resources <- list_package_resources("c21f3bd1-e016-4469-abf5-c58bb8e8b5ce")

datastore_resources <- filter(resources, tolower(format) %in% c('xlsx', 'geojson'))

data <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

data

#### Creating a Dataframe with the Downloaded Data ####

# As the downloaded data is in "xlsx" format and very large, a dataframe for each year's 
# raw data will be created and saved as separate csv files
# Each dataframe will be saved in the "data/raw_data" folder

# Dataframe for 2017 Data

paramedic_services_data_2017 <- 
  tibble(
    data$"2017")

paramedic_services_data_2017

write.csv(paramedic_services_data_2017, file = "data/raw_data/raw_data_2017.csv")

# Dataframe for 2018 Data

paramedic_services_data_2018 <- 
  tibble(
    data$"2018")

paramedic_services_data_2018

write.csv(paramedic_services_data_2018, file = "data/raw_data/raw_data_2018.csv")

# Dataframe for 2019 Data

paramedic_services_data_2019 <- 
  tibble(
    data$"2019")

paramedic_services_data_2019

write.csv(paramedic_services_data_2019, file = "data/raw_data/raw_data_2019.csv")

# Dataframe for 2020 Data

paramedic_services_data_2020 <- 
  tibble(
    data$"2020")

paramedic_services_data_2020

write.csv(paramedic_services_data_2020, file = "data/raw_data/raw_data_2020.csv")

# Dataframe for 2021 Data

paramedic_services_data_2021 <- 
  tibble(
    data$"2021")

paramedic_services_data_2021

write.csv(paramedic_services_data_2021, file = "data/raw_data/raw_data_2021.csv")

# Dataframe for 2022 Data

paramedic_services_data_2022 <- 
  tibble(
    data$"2022")

paramedic_services_data_2022

write.csv(paramedic_services_data_2022, file = "data/raw_data/raw_data_2022.csv")