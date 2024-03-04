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
#deck[c(-1, 1), 1]

# Zero
deck[0, 0]

# Blank Spaces (Returns all values)
deck[1, ]

# Logical Values
deck[1, c(TRUE, TRUE, FALSE)]

# Names
deck[1, c("face", "suit", "value")]

# Deal a card
deal <- function(cards) {
  cards[1, ]
}

deal(deck)
deal(deck)
deal(deck)

# Shuffle Cards

deck2 <- deck[1:52, ]
head(deck2)

deck3 <- deck[c(2, 1, 3:52), ]
head(deck3)

## Randomizes the values
random <- sample(1:52, size = 52)
random

deck4 <- deck[random, ]
head(deck4)

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}

deal(deck)
deck2 <- shuffle(deck)
deal(deck2)

# Dollar signs and Double Brackets
deck$value # Returns all values as a vector
mean(deck$value)
median(deck$value)

lst <- list(numbers = c(1, 2), logical = T, strings = c("a", "b", "c"))
lst

lst[1] # Get the first value in the list (subset it)

# sum(lst[1]) # errors out
lst$numbers # returns the numbers
sum(lst$numbers)
lst[[1]] # Does the same thing as the $ notation, returns 1 2

lst["numbers"] # get the element of the list
lst[["numbers"]] # Same thing as above










