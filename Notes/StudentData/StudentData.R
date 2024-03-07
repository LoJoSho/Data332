# Student Data

library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(here)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/StudentData')

#df = dataframe
course <- read_excel('data/Course.xlsx', .name_repair = 'universal')
registration <- read_excel('data/Registration.xlsx', .name_repair = 'universal')
students <- read_excel('data/Student.xlsx', .name_repair = 'universal')

df <- left_join(students, registration, by = c('Student.ID'))
df <- left_join(df, course, by = c('Instance.ID'))

# Number 1
df_majors <- df %>%
  group_by(Title) %>%
  summarize(
    amountPerMajor = n()
  )

ggplot(df_majors, aes(x = Title, y = amountPerMajor)) + 
  geom_col() +
  geom_bar(stat="identity", fill="orange") + 
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

ggsave(here("Notes/StudentData/images/NumberofStudentsPerMajor.png"))

# Number 2
df$year <- str_sub(df$Birth.Date, 1, 4)

df_birth_years <- df %>%
  group_by(year) %>%
  summarize(
    studentPerYear = n()
  )
ggplot(df_birth_years, aes(x = year, y = studentPerYear)) + 
  geom_col() +
  geom_bar(stat="identity", fill="orange") + 
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

ggsave(here("Notes/StudentData/images/NumberOfStudentBirthYears.png"))

# Number 3
df_cost_majors = df %>%
  group_by(Title, Payment.Plan) %>%
  summarize(
    cost = mean(Cost)
  )
    
ggplot(df_cost_majors, aes(
  x = Title, 
  y = cost,
  fill = Payment.Plan
  )) + 
  geom_col(position = "dodge", color = "black") +
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

ggsave(here("Notes/StudentData/images/CostsPerMajorPaymentPlan.png"))

# Number 4
df_balance_due_majors = df %>%
  group_by(Title, Payment.Plan) %>%
  summarize(
    cost = mean(Balance.Due)
  )

ggplot(df_balance_due_majors, aes(
  x = Title, 
  y = cost,
  fill = Payment.Plan
)) + 
  geom_col(position = "dodge", color = "black") +
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

ggsave(here("Notes/StudentData/images/BalanceDuePerMajor.png"))
