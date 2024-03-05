# Student Data

library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/StudentData')

#df = dataframe
course <- read_excel('data/Course.xlsx', .name_repair = 'universal')
registration <- read_excel('data/Registration.xlsx', .name_repair = 'universal')
students <- read_excel('data/Student.xlsx', .name_repair = 'universal')

df <- left_join(students, registration, by = c('Student.ID'))
df <- left_join(registration, course, by = c('Instance.ID'))


df_payment_plan <- df %>% 
  group_by(Student.ID) %>%
  summarize(
    payment_amount = mean(Balance.Due, na.rm = TRUE),
    paymentplan = Payment.Plan
  )

df_payment_plan <- df_payment_plan %>%
  dplyr::filter(payment_amount > 0)

ggplot(df_payment_plan, aes(x = paymentplan, y = payment_amount)) + 
  geom_col() +
  geom_bar(stat="identity", fill="orange") + 
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))






