
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

billing <- read_excel("data/Billing.xlsx", .name_repair = 'universal', col_types = c("numeric", "numeric", "date", "numeric", "text", "logical"))
patient <- read_excel("data/Patient.xlsx", .name_repair = 'universal', col_types = c("numeric", "text", "text", "date", "text", "text", "text", "text", "numeric", "text"))
visit <- read_excel("data/Visit.xlsx", .name_repair = 'universal', col_types = c("numeric", "numeric", "date", "text", "logical"))

# Visit from txt file seems obsolete as it's on the visit.xlsx file?
#additional_visit <- read.csv("data/Visit.txt", header = FALSE, col.names = c("VisitID", "PatientID", "VisitDate", "Reason", "Walkin"))
#additional_visit$PatientID <- as.numeric(additional_visit$PatientID)
#additional_visit$Walkin <- as.logical(additional_visit$Walkin)
#additional_visit$VisitDate <- as.Date(additional_visit$VisitDate)
#additional_visit <- read.csv("data/Visit.txt", header = FALSE, colClasses = c("numeric", "numeric", "Date", "character", "logical"))
#visit <- visit %>%
#  left_join(additional_visit)

# Group Visit Reasons together

## In case you wanted to do it by followup/checkups 
#visit <- visit %>%
#  mutate(Reason = case_when(
#    grepl("FollowUp", Reason) ~ "followup",
#    grepl("check-up", Reason) ~ "followup",
#    grepl("check up", Reason) ~ "followup",
#    grepl("Hypertension", Reason) ~ "Hypertension",
#    grepl("Hypotension", Reason) ~ "Hypotension",
#    grepl("Hypothyroidism", Reason) ~ "Hypothyroidism",
#    grepl("Laceration", Reason) ~ "Laceration",
#    TRUE ~ Reason  # Keep the original value if none of the conditions match
#  ))

visit <- visit %>%
  mutate(Reason = case_when(
    grepl("Annual wellness visit", Reason) ~ "Annual wellness visit",
    grepl("Bronchitis", Reason) ~ "Bronchitis",
    grepl("Dermatitis", Reason) ~ "Dermatitis",
    grepl("Hypertension", Reason) ~ "Hypertension",
    grepl("Hypotension", Reason) ~ "Hypotension",
    grepl("Hypothyroidism", Reason) ~ "Hypothyroidism",
    grepl("Laceration", Reason) ~ "Laceration",
    grepl("Rhinitis", Reason) ~ "Rhinitis",
    grepl("Spotted fever rickettsiosis", Reason) ~ "Spotted fever rickettsiosis",
    grepl("UTI", Reason) ~ "UTI",
    grepl("Cyst removal", Reason) ~ "Cyst removal",
    grepl("Allergic reaction", Reason) ~ "Allergic reaction",
    grepl("Migraine", Reason) ~ "Migraine",
    TRUE ~ Reason  # Keep the original value if none of the conditions match
  ))


# Numero Uno - Reason for visit based on walk in or not. 

walkin_reasons <- visit %>%
  group_by(Reason, WalkIn) %>%
  summarize(
    amount = n()
  )

ggplot(walkin_reasons, aes(
  x = Reason, 
  y = amount,
  fill = WalkIn
)) + 
  geom_col(position = position_dodge2(preserve = "single", width = 0.8), color = "black") +
  theme_dark() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

# NUmber 2 - Reason for visit based on City/State or zip code

visits_and_patients <- visit %>%
  left_join(patient)

reasons_on_city <- visits_and_patients %>%
  group_by(Zip, Reason) %>%
  summarize(
    amount = n()
  )

## Eh, I don't really like it but I can't think of much better atm
ggplot(reasons_on_city, aes(
  x = as.factor(Zip),
  y = amount,
  fill = Reason
)) + 
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  theme_dark() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = "Zip Code", y = "Amount")

# Number 3 - Total invoice amount based on reason for visit. Segmented (stacked bar chart) with it was paid. 

visit_payments <- visit %>%
  left_join(billing)

# Number 4 - And student is to find one insight into the data that they find interesting. In a chart.
