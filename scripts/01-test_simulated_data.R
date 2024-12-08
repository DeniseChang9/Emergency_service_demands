#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Paramedic Service Data
# Author: Denise Chang
# Date: 3 December 2024
# Contact: dede.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-simulate_data.R 

#### Workspace setup ####
library(testthat)
library(arrow)
library(here)

sim_data <- read_parquet(here::here("data/00-simulated_data/simulated_data.parquet"))

#### Test data ####

## Test that there are no missing data
# Test that there are no missing values in critical columns
test_that("no missing values in critical columns", {
  expect_true(all(!is.na(sim_data$year)))
  expect_true(all(!is.na(sim_data$incident_type)))
  expect_true(all(!is.na(sim_data$avg_units_arrived)))
})

# Test that 'incident_type' does not contain "-"
test_that("'incident_type' does not contain '-'", {
  expect_false("-" %in% sim_data$incident_type)
})

# Test that there are no empty strings in critical columns
test_that("no empty strings in critical columns", {
  expect_false(any(sim_data$avg_units_arrived == "" |
                     sim_data$count == ""))
})

## Test that the variables are of appropriate type
# Test that the 'year' column is integer type
test_that("'year' is of type integer", {
  expect_type(sim_data$year, "integer")
})

# Test that the 'month' column is an ordered factor
test_that("'month' is ordered", {
  expect_s3_class(sim_data$month, "ordered")
})

# Test that the 'day_of_week' column is an ordered factor
test_that("'day_of_week' is ordered", {
  expect_s3_class(sim_data$day_of_week, "ordered")
})

# Test that the 'hour' column is integer type
test_that("'hour' is integer", {
  expect_type(sim_data$hour, "integer")
})

# Test that the 'incident_type' column is character type
test_that("'incident_type' is character", {
  expect_type(sim_data$incident_type, "character")
})

# Test that the 'avg_units_arrived' column is double type
test_that("'avg_units_arrived' is double", {
  expect_type(sim_data$avg_units_arrived, "double")
})

# Test that the 'count' column is integer type
test_that("'count' is integer", {
  expect_type(sim_data$count, "integer")
})

## Test that the variables are in bounds
# Test that 'year' column values are between 2017 and 2022
test_that("'year' is between 2017 and 2022", {
  expect_true(all(sim_data$year >= 2017 & sim_data$year <= 2022))
})

# Test that 'hour' column values are between 0 and 23
test_that("'hour' is between 0 and 23", {
  expect_true(all(sim_data$hour >= 0 & sim_data$hour < 24))
})

# Test that 'incident_type' contains only valid values
valid_types <-
  c("emergency transfer",
    "fire",
    "medical",
    "motor vehicle accident")
test_that("'incident_type' contains only valid values", {
  expect_true(all(sim_data$incident_type %in% valid_types))
})

# Test that 'avg_units_arrived' column values are non-negative
test_that("'avg_units_arrived' is non-negative", {
  expect_true(all(sim_data$avg_units_arrived >= 0))
})