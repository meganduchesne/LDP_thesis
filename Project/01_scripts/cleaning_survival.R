# Mon Sep 23 20:26:50 2024 ------------------------------

# Megan Duchesne

# The purpose of this script is to clean the survival file before merging it with the morphology file, Multiple people have contributed
# to it over time and I want to double check that data entry was done without error


# load libraries
library(dplyr)
library(tidyverse)
library(openxlsx)
library(assertr)


# read in data from raw data file
surv<-read.xlsx("Project/00_Raw_data/survival_LDP.xlsx", na.strings=c(".", "NA"))



# rearrange the columns to see the most relevant information easier and drop columns that aren't useful to 
# this study. I'm dropping year1 and expt here 
surv_selected<-surv %>% 
  select(ninecode, year2, surv, age, natal_yr, is, cens)


# lets clean/check the remaining 8 columns now: 


###################################
# ninecode

#check that each bird is only entered once per year
surv_selected %>% 
  group_by(year2, ninecode) %>% 
  summarise(count=n()) %>% 
  filter(count>1) #good, 0 occasions where there is more than 1 ninecode/year

###################################
# year2

# year2 should be renamed to year for clarity
surv_selected<-surv_selected %>% 
  rename(Year=year2)

# years should range from 1975-2023
surv_selected %>% #use assertr within bounds to check age range
  verify(within_bounds(1975,2023)(Year)) #good, execution was not stopped


###################################
# age

# age can be 0 or greater but given that song sparrows usually live ~4 years, it would be unreasonable to see age=20
surv_selected %>% #use assertr within bounds to check age range
  verify(within_bounds(0, 15)(age)) #good, execution was not stopped


# we assume all birds who are immigrants (is=1) arrive at age=1. Ensure no immigrants' age is ever entered as 0
surv_selected %>% 
  filter(age==0 & is==1) # good 0 occasions


###################################
# natal year

# natal year can only be  between 1975-2023
surv_selected %>% #use assertr within bounds to check range of years birds could be born
  verify(within_bounds(1975, 2023)(natal_yr)) #good, execution was not stopped

# natal year should be consistent for each bird over time
surv_selected %>% 
  group_by(ninecode) %>% 
  summarise(natal_yr_count=n_distinct(natal_yr)) %>% # summarize the number of unique natal years that each bird has
  filter(natal_yr_count>1) #filter for any birds with more than 1 unique natal year
#good, 0 occasions!

###################################
# is 

# is can be 0 or 1 (resident or immigrant)
surv_selected %>% # lets use these "in_set" function from assertr to say values must be either 0 or 1
  assert(in_set(0,1), is) #good, execution was not stopped

###################################
# cens

# cens can be 0 or 1 (not in an experiment or in an experiment)
surv_selected %>% # lets use these "in_set" function from assertr to say values must be either 0 or 1
  assert(in_set(0,1), cens) #good, execution was not stopped

###################################
# surv

# surv can only be 0 or 1 (died or survived over winter)
surv_selected %>% # lets use these "in_set" function from assertr to say values must be either 0 or 1
  assert(in_set(0,1), surv) # good, execution was not stopped


# surv can't be 0 more than once for each bird
surv_selected %>% 
  group_by(ninecode) %>% 
  summarise(count_surv_zero = sum(surv == 0), .groups = 'drop') %>% 
  filter(count_surv_zero>1) #good, 0 occasions 


###################################

# Lets save this data to out data to merge with a cleaned morphology file

write.xlsx(surv_selected, "Project/02_outdata/survival_1975-2023_updated_23Sep2024_MD.xlsx")
