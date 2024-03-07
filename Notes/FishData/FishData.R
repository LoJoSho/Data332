
library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(here)

# Clear variables
rm(list = ls())
# Set working directory 
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/FishData')

fish <- read.csv("data/fish.csv")
kelp_abur <- read_excel("data/kelp_fronds.xlsx", sheet = "abur")

fish_garibaldi <- fish %>% 
  filter(common_name == "garibaldi")

fish_mohk <- fish %>% 
  filter(site == "mohk")

fish_over50 <- fish %>% 
  filter(total_count >= 50)

#fish_3sp <- fish %>% 
#  filter(common_name == "garibaldi" | 
#           common_name == "blacksmith" | 
#           common_name == "black surfperch")

fish_3sp <- fish %>% 
  filter(common_name %in% c("garibaldi", "blacksmith", "black surfperch"))

# 8.3.3.1 Activity
fish_gar_2016 <- fish %>% 
  filter(year == 2016 | common_name == "garibaldi")

# AND conditions
aque_2018 <- fish %>% 
  filter(year == 2018 & site == "aque")
# or you can do this for AND conditions
aque_2018 <- fish %>% 
  filter(year == 2018) %>% 
  filter(site == "aque")

fish_bl <- fish %>%
  filter(str_detect(common_name, "black"))

# Joining

abur_kelp_fish <- kelp_abur %>% 
  full_join(fish, by = c("year", "site")) 

kelp_fish_left <- kelp_abur %>% 
  left_join(fish, by = c("year","site"))

kelp_fish_injoin <- kelp_abur %>% 
  inner_join(fish, by = c("year", "site"))

my_fish_join <- fish %>% 
  filter(year == 2017, site == "abur") %>% 
  left_join(kelp_abur, by = c("year", "site")) %>% 
  mutate(fish_per_frond = total_count / total_fronds)









