# Shuffle Dem Cards

# Sets working directory
setwd('C:/Users/stick/Documents/GitHub/Data332/Notes/DealTheCards')
# Clear Variables
rm(list = ls())

deck <- read.csv('data/deck.csv')

# Creating the functions
deal <- function(deck) {
  drawn_card <- deck[1, ]
  cat("Drawn card:", drawn_card$face, "of", drawn_card$suit, "\n")
  
  # Remove the drawn card from the deck
  deck <- deck[-1, ]
  
  # Print the updated deck
  cat("Remaining cards in the deck:\n")
  print(deck)
  
  return(list(drawn_card = drawn_card, updated_deck = deck))
}

formatCard <- function(cards) {
  result <- ""
  for (card in cards) {
    if (is.data.frame(card)) {
      result <- paste(result, cat("Card:", card$face, "of", card$suit, " (", card$value, ")\n"))
    } else if (is.atomic(card)) {
      result <- paste(result, cat("Card:", card, "\n"))
    } else {
      cat("Invalid card format\n")
    }
  }
  return(result)
}

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}

over21 <- function(cards) {
  if (sum(cards$value) >= 21) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

exit <- function() {
  .Internal(.invokeRestart(list(NULL, NULL), NULL))
}

gameon <- function() {
  gameOver <- F
  # Empty Starting Lists
  hand <- data.frame(face = character(), suit = character(), value = numeric())
  dealer <- data.frame(face = character(), suit = character(), value = numeric())
  while (gameOver == F) {
    gameDeck <- shuffle(deck)
  
    result <- deal(gameDeck)
    hand <- append(hand, result$drawn_card)
    gameDeck <- result$updated_deck
    
    
    result <- deal(gameDeck)
    dealer <- append(dealer, result$drawn_card)
    gameDeck <- result$updated_deck
  
    print("Dealers hand: ")
    print(formatCard(dealer))
    
    if (over21(dealer)) {
      print("The dealer went over 21! You Win!")
      gameOver <- T
      return()
    }
    cat("Your hand: ")
    #for (card in hand) { print(formatCard(data.frame(card))) }
    
    stay <- readline(prompt = "Stay? [Y/N] ")
  
    if (over21(hand)) {
      cat("You went over 21! You lose!")
      gameOver <- T
    }
  }
}

print("Welcome to the game! ")
readyup <- readline(prompt = "Are you ready to play? [Y/N] ")

if (as.character(readyup) == "Y") {
  print("We are ready!")
} else {
  print("We are not ready!")
  exit()
}

print("Lets keep going!")
gameon()

