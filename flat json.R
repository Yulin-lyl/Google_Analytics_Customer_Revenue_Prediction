library(plyr)
library(tidyverse)
library(jsonlite)
library(magrittr)
library(caret)
library(lubridate)
library(lightgbm)
library(foreach)
library(data.table)

###Defining types of extracted attributes
ctypes <- cols(fullVisitorId = col_character(),
               channelGrouping = col_character(),
               date = col_datetime(),
               device = col_character(),
               geoNetwork = col_character(),
               socialEngagementType = col_skip(), 
               totals = col_character(),
               trafficSource = col_character(),
               visitId = col_integer(), 
               visitNumber = col_integer(),
               visitStartTime = col_integer(),
               hits = col_skip(),
               customDimensions = col_skip())

###Data extraction
message("Data Extraction")
tr0 <- read_csv("/Users/miana/Documents/6420 Predictive Analysis/Project/ga-customer-revenue-prediction/train_v2.csv", col_types = ctypes)
te0 <- read_csv("/Users/miana/Documents/6420 Predictive Analysis/Project/ga-customer-revenue-prediction/test_v2.csv", col_types = ctypes)


###Data parsing
flatten_json <- . %>% 
  str_c(., collapse = ",") %>% 
  str_c("[", ., "]") %>% 
  fromJSON(flatten = T)

parse <- . %>% 
  bind_cols(flatten_json(.$device)) %>%
  bind_cols(flatten_json(.$geoNetwork)) %>% 
  bind_cols(flatten_json(.$trafficSource)) %>% 
  bind_cols(flatten_json(.$totals)) %>% 
  select(-device, -geoNetwork, -trafficSource, -totals)

message("Data Parsing")
tr <- parse(tr0)
#write.csv(tr, "/Users/miana/Documents/6420 Predictive Analysis/Project/ga-customer-revenue-prediction/cleaned_train_v2.csv")
te <- parse(te0)
#write.csv(te, "/Users/miana/Documents/6420 Predictive Analysis/Project/ga-customer-revenue-prediction/cleaned_test_v2.csv")
