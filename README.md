# Predicting Emergency Service Demands in Toronto

## Overview

This repository explores how weather conditions and time-based factors influence the demand for emergency services in Toronto, particularly 911 calls. The analysis predicts peak demand periods, allowing more efficient allocation of resources and improving response times. By combining historical 911 call data with weather records, the study investigates how temperature, precipitation, time of day, and day of the week impact emergency service demand.

## File Structure

The repo is structured as:
-   `data/raw_data` contains the raw data as obtained from OpenDataToronto.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatHorse and the entire chat history is available in inputs/llms/usage.txt.
