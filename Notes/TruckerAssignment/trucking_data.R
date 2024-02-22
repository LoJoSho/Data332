library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/TruckerAssignment')

#df = dataframe
df_truck <- read_excel('data/NP_EX_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

# Select 4->15 columns
df <- df_truck[, c(4:15)]
# Deselecting column "...10" (it was an empty column)
df <- subset(df, select = -c(...10))

# Getting difference in days within a column
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max - date_min
print(number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)
number_of_days_recorded = nrow(df)
print(number_of_days_recorded)

total_hours <- sum(df$Hours)
avg_hours_per_day_recorded <- round(total_hours / number_of_days_recorded, digits = 3)
print(avg_hours_per_day_recorded)

# Next problems up to bat
df$fuel_cost <- df$Gallons * df$Price.per.Gallon
df$total_cost <- df$Tolls + df$Misc + df$fuel_cost

total_gallons <- sum(df$Gallons)
total_miles <- sum(df$Odometer.Ending- df$Odometer.Beginning)
miles_per_gallon <- total_miles / total_gallons
total_cost_per_mile <- sum(df$total_cost) / total_miles

print(total_gallons)
print(total_miles)
print(miles_per_gallon)
print(total_cost_per_mile)

df[c('warehouse', 'city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)

