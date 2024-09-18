# Sun Sep 15 23:47:24 2024 ------------------------------

# the purpose of this script is to take my raw xlsx files from my laptop and save
#them as csv files in my raw data file for this project

#load libraries
library(openxlsx)
library(tidyverse)

# read in data files
file_morphology <- "mean_traits_merged_morphology.xlsx"  
morphology <- read.xlsx(file_morphology)

file_survival_before_2019 <- "survival_pirmin.xlsx"  
survival_before_2019 <- read.xlsx(file_survival_before_2019)

file_survival_after_2019 <- "2019-2023_survival_file.xlsx"  
survival_after_2019 <- read.xlsx(file_survival_after_2019)



# Write the data to a CSV in the rawdata folder
write.csv(morphology, file = "Project/00_Raw_data/morphology.csv", row.names = FALSE)
write.csv(survival_before_2019, file = "Project/00_Raw_data/survival_before_2019.csv", row.names = FALSE)
write.csv(survival_after_2019, file = "Project/00_Raw_data/survival_after_2019.csv", row.names = FALSE)
