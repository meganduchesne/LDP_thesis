# Mon Sep 23 20:26:14 2024 ------------------------------


# The purpose of this script is to clean the morphology file before merging it with the survival file








# rearrange columns



morphology_cleaned<-morphology %>% 
  select(NINECODE, SEX ,pred_sex, pred_sex_error, Bill_length, Bill_depth, Bill_width, Mass, Tarsus, Wing, BLCOUNT, BDCOUNT, BWCOUNT, MASSCOUNT, TARSUSCOUNT, WINGCOUNT)
