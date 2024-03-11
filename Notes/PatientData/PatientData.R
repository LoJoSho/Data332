
library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(here)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/PatientData')

billing <- read_excel("data/Billing.xlsx", .name_repair = 'universal')
patient <- read_excel("data/Patient.xlsx", .name_repair = 'universal')
visit <- read_excel("data/Visit.xlsx", .name_repair = 'universal', col_types = c("numeric", "numeric", "date", "text", "logical"))
# Fixed the datatypes
#visit$VisitID <- as.numeric(visit$VisitID)
#visit$VisitID <- as.numeric(visit$PatientID)

additional_visit <- read.csv("data/Visit.txt", header = F, col_types = cols("numeric", "numeric", "date", "character", "logical"))

visit <- visit %>%
  left_join(additional_visit, by = c('VisitID'='V1', 'PatientID'='V2', 'VisitDate'='V3', 'Reason'='V4', 'Walkin'='V5'))


