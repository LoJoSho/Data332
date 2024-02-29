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
df_truck_0001 <- read_excel('data/truck data 0001.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_0369 <- read_excel('data/truck data 0369.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1226 <- read_excel('data/truck data 1226.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1442 <- read_excel('data/truck data 1442.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1478 <- read_excel('data/truck data 1478.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1539 <- read_excel('data/truck data 1539.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1769 <- read_excel('data/truck data 1769.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df_paysheet  <- read_excel('data/Driver Pay Sheet.xlsx', .name_repair = 'universal')

df <- rbind(df_truck_0001, 
            df_truck_0369, 
            df_truck_1226, 
            df_truck_1442, 
            df_truck_1478,
            df_truck_1539,
            df_truck_1769
            )
df <- subset(df, select = -c(2, 10))

# Creating a pivot table
df_starting_pivot <- df %>% 
  group_by(Truck.ID) %>%
  summarize(count = n()
  )

# Joins the right table to the left data.
# Exploding join is when you get more rows AFTER you run a join

df <- left_join(df, df_paysheet, by = c('Truck.ID'))

df$cost <- (df$Odometer.Ending - df$Odometer.Beginning) * df$labor_per_mil
df$full_name <- paste(df$first, df$last)

df_costing <- df %>% 
  group_by(Truck.ID, full_name) %>%
  summarize(
    driver_cost = sum(cost, na.rm = TRUE)
  )

# Plotting
ggplot(df_costing, aes(x = full_name, y = driver_cost)) + 
  geom_col() +
  geom_bar(stat="identity", fill="orange") + 
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))












