#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Denise Chang
# Date: 20 November 2024
# Contact: dede.chang@utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(arrow)

#### Download data ####
# [...ADD CODE HERE TO DOWNLOAD...]

# Code to download



#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
