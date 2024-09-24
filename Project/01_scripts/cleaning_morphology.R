# Mon Sep 23 20:26:14 2024 ------------------------------

# Megan Duchesne

# The purpose of this script is to clean the morphology file before merging it with the survival file. Whoever created it (ahem, me) 


# load libraries
library(dplyr)
library(tidyverse)
library(openxlsx)
library(assertr)


# read in data from raw data file
morphology<-read.xlsx("Project/00_Raw_data/morphology_LDP.xlsx", na.strings=c(".", "NA"))


################################################################
# ensure that each bird only appears once in data 
morphology %>% 
 group_by(NINECODE) %>% 
  summarise(count=n()) %>% 
  filter(count>1) # good, 0 occasions where unique ninecodes appear more than once in data
################################################################




################################################################
# Initial cleaning of measured traits columns:

# 1) Rearrange the columns for better organization to see the most important stuff immediately. I'm also going to drop the count columns
# and mass, wing, and tarsus columns because they aren't needed for these analyses
morphology_rearranged<-morphology %>% 
  select(NINECODE, Sex, Bill_length, Bill_depth, Bill_width)



# 2) clean measures, should only be 2 decimal places
traits<-c("Bill_length", "Bill_depth", "Bill_width") #apply to all 3 traits!

morphology_rearranged<-morphology_rearranged %>% 
  mutate(across(all_of(traits),~round(.,2))) # round to 2 decimal places


# 3) when we remove mass, wing and tarsus we see a lot of rows were missing data for all 3 bill measures. Lets remove those rows
morphology_rearranged %>% 
  filter(is.na(Bill_length) & (is.na(Bill_depth)) & (is.na(Bill_width))) %>% 
  count() # 236 rows should be removed

morphology_cleaned<-morphology_rearranged %>%  # remove these rows
  filter(if_any(c(Bill_length, Bill_depth, Bill_width), ~!is.na(.)))

morphology_cleaned %>% 
  filter(is.na(Bill_length) & (is.na(Bill_depth)) & (is.na(Bill_width))) %>% 
  count() # good 0 rows have NA for all 3 traits


# 4) ensure traits are class numeric
traits<-as.numeric(traits) # is this the correct way?
class(morphology_cleaned$Bill_length)
class(morphology_cleaned$Bill_length)
class(morphology_cleaned$Bill_length)

###############################################################





###############################################################
#sex column clean:

# For now, lets remove birds where sex=NA. We are only interested in comparing traits for birds of known sex
morphology_cleaned %>% 
  filter(is.na(Sex)) %>% 
  count() # remove 51 rows

morphology_sex_cleaned<-morphology_cleaned %>% 
  filter(!is.na(Sex))

morphology_sex_cleaned %>% 
  filter(is.na(Sex)) %>% 
  count() #good 0 rows have NA for sex
###############################################################






###############################################################
#Check for outliers:

# Visually inspect data
hist(morphology_sex_cleaned$Bill_length, breaks =20) #length
hist(morphology_sex_cleaned$Bill_depth, breaks = 20) # depth
hist(morphology_sex_cleaned$Bill_width, breaks = 20) # width


# Lets check for outliers by using the insist function to search for median absolute deviations.

#Note that for fully grown birds who were measured more than once, their traits have been averaged 
# so its less likely we will see outliers but not impossible. 

# Lets choose 4 deviations (because this will mean these are really outliers?)
morphology_sex_cleaned %>% 
  insist(within_n_mads(4), Bill_length) %>% 
  group_by(Sex) %>% 
  summarise(mean_bill_length=mean(Bill_length, na.rm=TRUE))

morphology_sex_cleaned %>% 
  insist(within_n_mads(4), Bill_depth) %>% 
  group_by(Sex) %>% 
  summarise(mean_bill_depth=mean(Bill_depth, na.rm=TRUE))

morphology_sex_cleaned %>% 
  insist(within_n_mads(4), Bill_width) %>% 
  group_by(Sex) %>% 
  summarise(mean_bill_width=mean(Bill_width, na.rm=TRUE))

###############################################################




###############################################################

# Lets save this data to out data to merge with a cleaned survival file
write.xlsx(morphology_sex_cleaned, "Project/02_outdata/morphology_1975-2023_updated_23Sep2024_MD.xlsx")
