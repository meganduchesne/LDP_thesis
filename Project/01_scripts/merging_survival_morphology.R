# Mon Sep 23 20:14:55 2024 ------------------------------

# The purpose of this script is to merge the morphology and survival files together in preparation for selection analyses

#Load libraries
library(dplyr)
library(tidyverse)
library(openxlsx)
library(tidyr)

#Read in the data 
surv<-read.xlsx("Project/02_outdata/survival_1975-2023_updated_23Sep2024_MD.xlsx", na.strings=c(".", "NA"))
morphology<-read.xlsx("Project/02_outdata/morphology_1975-2023_updated_23Sep2024_MD.xlsx", na.strings=c(".", "NA"))


#####################################################
# Prepare for merge by ninecode:

# Change ninecode in surv to match column names in morphology 
surv<-surv %>% 
  rename(NINECODE=ninecode) 


# Ensure ninecode is of the same class in both files
# reminder ninecode should not be numeric, the purpose of the numbers is to serve as a unique identifier

#morphology 
morphology$NINECODE<-as.character(morphology$NINECODE)
class(morphology$NINECODE) # good

#surv
surv$NINECODE<-as.character(surv$NINECODE)
class(surv$NINECODE) # good

#####################################################



#####################################################
# a priori:

# 1) after this merge there should be as many distinct ninecodes as there are rows in morphology
nrow(morphology) #1927
# 2) every bird in each year should have a survival score 

#####################################################



#####################################################
# merge:

# merge all data from both files by ninecode 
merged_data <- full_join(surv, morphology, by = "NINECODE")

# Now lets filter out rows with NINECODEs not in morphology (e.g., sneaky birds that were never measured)
filter_merged_data <- merged_data %>%
  filter(NINECODE %in% morphology$NINECODE)

# Now lets remove any rows where surv=NA (e.g., migrants that were measured but never settled)
length(which(is.na(filter_merged_data$surv))) # should be 256 rows removed

selection<-filter_merged_data %>% 
  filter(!is.na(surv))

#####################################################




######################################################
# check a priori constraints:

# are there 1927 unique ninecodes (ie individual birds) present in the data
selection %>% 
  distinct(NINECODE) %>% 
  nrow() #yes!


selection %>% 
  group_by(NINECODE) %>% 
  verify(nrow(.) == 1927)))

# check for NAs in survival
length(which(is.na(selection$surv))) # good, 0 rows with surv=NA
#####################################################






#####################################################
# categorize age:

# we want to break up birds into age classes of yearlings (age=0) and adults (age=>0)
selection_data_aged<-selection %>% 
  mutate(age= case_when(
    age==0 ~ "subadult",
    age>0 ~ "adult"))

# remove rows where age=NA. For now we are only interested in comparing selection on birds of known ages
selection_data_aged<-selection_data_aged %>% 
  filter(!is.na(age))


#####################################################






#####################################################
# average bill dimensions in each age/sex class:

table

# or survival rate in each age/sex class
#####################################################





#####################################################
# bills over time or something

fig
# save fig to figs file

#####################################################





#####################################################
# save final file:
write.xlsx(selection_data_aged, "Project/02_outdata/selection_1975-2023_updated_24Sep2024_MD.xlsx")
