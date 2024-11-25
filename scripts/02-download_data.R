#### Preamble ####
# Purpose: Download and save the Paramedic Services Incident Data from Open Data Toronto
# Author: Denise Chang
# Date: 25 November 2024
# Contact: dede.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(openxlsx)

#### Download data ####
# get package
package <- show_package("c21f3bd1-e016-4469-abf5-c58bb8e8b5ce")

resources <-
  list_package_resources("c21f3bd1-e016-4469-abf5-c58bb8e8b5ce")

xlsx_resource <-
  resources[resources$name == "paramedic-services-incident-data-2017-2022",]

raw_data <- get_resource(xlsx_resource)

#### Save data ####

# Each year is saved as a separate file to preserve the structure.
data_2017 <- tibble(raw_data$"2017")
data_2018 <- tibble(raw_data$"2018")
data_2019 <- tibble(raw_data$"2019")
data_2020 <- tibble(raw_data$"2020")
data_2021 <- tibble(raw_data$"2021")
data_2022 <- tibble(raw_data$"2022")

# save as separate XLSX files (original format)
write_xlsx(data_2017, "data/01-raw_data/paramedic_services_2017.xlsx")
write_xlsx(data_2018, "data/01-raw_data/paramedic_services_2018.xlsx")
write_xlsx(data_2019, "data/01-raw_data/paramedic_services_2019.xlsx")
write_xlsx(data_2020, "data/01-raw_data/paramedic_services_2020.xlsx")
write_xlsx(data_2021, "data/01-raw_data/paramedic_services_2021.xlsx")
write_xlsx(data_2022, "data/01-raw_data/paramedic_services_2022.xlsx")