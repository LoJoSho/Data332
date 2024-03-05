library(tidyverse)
library(readxl)
library(here)
library(skimr) # install.packages('skimr')
library(kableExtra) # install.packages('kableExtra')

# Clear variables
rm(list = ls())

setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/Lobster Data')

lobsters <- read.csv('data/Lobster_Abundance_All_Years_20230831.csv')

skimr::skim(lobsters)

#lobsters %>%
#  group_by(YEAR) %>%
#  summarize(count_by_year = n())

#lobsters %>%
#  group_by(SITE, YEAR) %>%
#  summarize(count_by_siteyear = n())

lobsters %>%
  group_by(SITE, YEAR) %>%
  summarize(
    count_by_siteyear = n(),
    mean_size_mm = mean(SIZE_MM, na.rm=TRUE),
    sd_size_mm = sd(SIZE_MM, na.rm=TRUE)
    )

lobsters <- lobsters %>%
  dplyr::filter(SIZE_MM > 0)


siteyear_summary <- lobsters %>%
  group_by(SITE, YEAR) %>%
  summarize(
    count_by_siteyear = n(),
    mean_size_mm = mean(SIZE_MM, na.rm=TRUE),
    median_size_mm = median(SIZE_MM, na.rm=TRUE),
    sd_size_mm = sd(SIZE_MM, na.rm=TRUE)
  )

siteyear_summary

# Table Formatting with Kable
siteyear_summary %>%
  kable()

ggplot(data = siteyear_summary, aes(x = YEAR, y = median_size_mm, color=SITE)) +
  geom_line()

ggsave(here("lobsters-line.png"))

ggplot(siteyear_summary, aes(x = year, y = median_size_mm)) +
  geom_col() +
  facet_wrap(~SITE)



