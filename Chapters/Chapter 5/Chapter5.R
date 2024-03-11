setwd('C:/Users/stick/Documents/GitHub/Data332/Chapters/Chapter 5')

deck <- read.csv('data/deck.csv')

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}

vec <- c(0,0,0,0,0,0)
vec

# Select first value
vec[1]

# Modify first value
vec[1] <- 1000


# Modify multiple values
vec[c(1,3,5)] <- c(1, 1, 1)
vec

vec[4:6] <- vec[4:6] + 1

# Append additional value
vec[7] <- 0

# Logical Subsetting
vec[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)]

# Deck Changes
deck$new <- NULL

deck[c(13, 26, 39, 52)]

deck$value[c(13, 26, 39, 52)]

deck$value[c(13, 26, 39, 52)] <- 14

# Newly shuffled deck
deck3 <- shuffle(deck)

deck3$face == "ace"
sum(deck3$face == "ace")

deck3$value[deck3$face == "ace"] <- 14

# Deck #4
deck4 <- deck
deck4$value <- 0
head(deck4, 13)

deck4$value[deck4$suit == "hearts"]
deck4$value[deck4$suit == "hearts"] <- 1
deck4$value[deck4$suit == "hearts"]

deck4[deck4$face == "queen", ]
deck4[deck4$suit == "spades", ]

### Right from the book about the %in% operation
1 %in% c(3, 4, 5)
## FALSE
c(1, 2) %in% c(3, 4, 5)
## FALSE FALSE
c(1, 2, 3) %in% c(3, 4, 5)
## FALSE FALSE TRUE
c(1, 2, 3, 4) %in% c(3, 4, 5)
## FALSE FALSE TRUE TRUE


# Boolean Operators
### Something neat from the book
a <- c(1, 2, 3)
b <- c(1, 2, 3)
c <- c(1, 2, 4)
a == b
## TRUE TRUE TRUE
b == c
## TRUE TRUE FALSE
a == b & b == c
## TRUE TRUE FALSE

# Yippie Do da Zippiedie de hey, oh how my what a wonderful day
queenOfSpades <- deck4$face == "queen" & deck4$suit == "spades"
deck4$value[queenOfSpades, ]
deck4$value[queenOfSpades] <- 13
deck4$value[queenOfSpades, ]

deck5 <- deck
head(deck5, 13)

facecard <- deck5$face %in% c("king", "queen", "jack")
deck5[facecard, ]

deck5$value[facecard] <- 10
head(deck5, 13)


# Missing Information
1 + NA
## Equels to NA (Not Available)

NA == 1
# Well, still NA. Funny how that works/

# na.rm will ignore NA values, so they don't mess up data
mean(c(NA, 1:50), na.rm = TRUE)

is.na(NA) # Amazing check right here
vec <- c(1, 2, 3, NA)
is.na(vec)

# Let's do some funky stuff with the deck
deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)



