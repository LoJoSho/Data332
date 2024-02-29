setwd('C:/Users/stick/Documents/GitHub/Data332/Chapters/Chapter 4')

deck <- read.csv('data/deck.csv')

head(deck)
deck[c(1,1), c(1,2,3)]

vec <- c(6,1,3,6,10,5)
vec[1:3]

# Negative Integers
# Negatives do the opposite of positive numbers,
# In this case, it'll exclude those indexes
deck[-(2:52), 1:3]

# Errors out
deck[c(-1, 1), 1]

# Zero
deck[0, 0]

# Blank Spaces (Returns all values)
deck[1, ]

# Logical Values
deck[1, c(TRUE, TRUE, FALSE)]

# Names
deck[1, c("face", "suit", "value")]

# Deal a card



