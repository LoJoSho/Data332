library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/TruckerAssignment')

df_truck <- read_excel('data/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

