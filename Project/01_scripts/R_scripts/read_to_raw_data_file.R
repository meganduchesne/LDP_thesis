# Sun Sep 15 23:47:24 2024 ------------------------------

# the purpose of this script is to take my raw xlsx files from my laptop and save
#them as csv files in my raw data file for this project

#load libraries
library(openxlsx)
library(tidyverse)

# read in data files
file_morphology <- "Project/00_Raw_data/standardized_traits_sep11.xlsx"  
morphology <- read.xlsx(file_morphology)


# Write the data to a CSV in the rawdata folder
write.csv(morphology, file = "Project/00_Raw_data/standardized_traits_sep11.csv", row.names = FALSE)
