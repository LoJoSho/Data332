library(tidytext)
library(janeaustenr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(wordcloud)


# Clear variables
rm(list = ls())

setwd('C:/Users/stick/Documents/GitHub/Data332/Assignments/SentimentAnalysis')
# Get Consumer File
consumers_complaints <- read.csv('data/Consumer_Complaints.csv')
# Filter it down to complaints that have a narratives to them
complaints <- consumers_complaints %>%
  filter(Consumer.complaint.narrative != '')

# What insitutuion has the most negative complains?
# What state is "the most negative?"
# What is the most complained banking products
# Are people more negative on the web?

# Negative on the web graph

# Get the angry list from nrc sentiments
nrc_angry <- get_sentiments("nrc") %>% 
  filter(sentiment == "anger")

# Remove all rows that don't have narratives, pivot by Complaint ID,
# Get all the words from each narrative and put them in their own rows
tidy_complaints <- complaints %>%
  filter(Consumer.complaint.narrative != '') %>%
  group_by(Complaint.ID) %>%
  ungroup() %>%
  unnest_tokens(word, Consumer.complaint.narrative) 

# Rows now have a word each, do an inner join with the nrc angry
# Get the top 24, then sort them 
negative_complaints <- tidy_complaints %>%
  group_by(Company) %>%
  inner_join(nrc_angry) %>%
  summarise(count = n_distinct(Complaint.ID)) %>%
  top_n(24) %>%
  arrange(desc(count))

# Plot the graph, first reorder it so that the biggest companies are on the 
# left hand side. 
ggplot(negative_complaints, aes(x = reorder(Company, -count), y = count)) +
  scale_x_discrete(labels = negative_complaints$Company) +
  geom_bar(stat="identity", width=.5, fill="blue1") +
  labs(x = "Companies", y = "Angry Complaints", title = "Top 25 Companies with the most angry reviews") +
  theme(axis.text.x = element_text(angle=90, vjust=0.6))

ggsave("images/TopAngristCompanies.png")

# How angry are people?
# To do this, we get the bing sentiments which has positive and negative numbers. Then we sum them all up.
# Then we find the average for each company, before filtering to total company reviews over 250+ 
# Before finding the top 10 most negative and arranging them in a desc order. 
average_sentiment <- tidy_complaints %>%
  inner_join(get_sentiments("bing")) %>%
  group_by(Company) %>%
  summarise(positive = sum(sentiment == "positive", na.rm = TRUE),
            negative = sum(sentiment == "negative", na.rm = TRUE),
            total = n()) %>%
  mutate(average_sentiment_score = (negative - positive) / total) %>%
  filter(total > 250) %>%
  top_n(24) %>%
  arrange(desc(average_sentiment_score))

ggplot(average_sentiment, aes(x =  reorder(Company, -average_sentiment_score), y = average_sentiment_score)) +
  scale_x_discrete(labels = average_sentiment$Company) +
  geom_bar(stat="identity", width=.5, fill="blue1") +
  labs(x = "Companies", y = "Avg Complaints", title = "Top 25 Companies with the most angry reviews") +
  theme(axis.text.x = element_text(angle=90, vjust=.5))

ggsave("images/HowAngryCompanies.png")

# Then we create a word graph of the most angry words used to describe companies!
# Create a slight filter to remove basic words that could mean differen things:
custom_stop_words <- bind_rows(tibble(word = c("money"),  
                                      lexicon = c("limited")), 
                               stop_words)

tidy_complaints %>%
  anti_join(custom_stop_words) %>%
  inner_join(nrc_angry) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# Can't use ggsave, need to manually go through RStudio >:(
#ggsave("images/WordBubble.png")

