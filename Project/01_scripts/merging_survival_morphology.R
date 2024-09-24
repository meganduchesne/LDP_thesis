# Mon Sep 23 20:14:55 2024 ------------------------------

# The purpose of this script is to merge the morphology and survival files together in preparation for selection analyses

#Load libraries
library(dplyr)
library(tidyverse)
library(openxlsx)
library(tidyr)
library(readxl)

#Read in the data 
surv<-read.xlsx("Project/00_Raw_data/survival_LDP.xlsx", na.strings=c(".", "NA"))
morphology<-read.xlsx("Project/00_Raw_data/morphology_LDP.xlsx", na.strings=c(".", "NA"))


######################################################
# remove columns not helpful for analyses



#surv
surv_cleaned<-surv %>% 
rm year 1

#####################################################






#####################################################

# change the column names in surv to match morphology
colnames(surv_selected)[colnames(surv_selected)=="ninecode"]<-"NINECODE"
colnames(surv_selected)[colnames(surv_selected)=="year2"]<-"Year"

#####################################################




#####################################################
# we will merge by ninecode so lets make sure they are of the same class
# reminder ninecode should not be numeric, the purpose of the numbers is to serve as a unique identifier

#morphology 
morphology_cleaned$NINECODE<-as.character(morphology_cleaned$NINECODE)
class(morphology_cleaned$NINECODE) # good

#surv
surv_selected$NINECODE<-as.character(surv_selected$NINECODE)
class(surv_selected$NINECODE)

#####################################################