
# S3 System
# How does R handle objects?

num <- 1000000000
print(num)

class(num) <- c("POSIXct", "POSIXt")
print(num)

attributes(num)

one_play <- play()
attributes(one_play) # NULL

attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play) # [1] "B" "0" "B"

attr(one_play, "symbols") # "B" "0" "B"

# Modify the play function found in Chapter 7
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

play <- function() {
 symbols <- get_symbols()
 prize <- score(symbols)
 attr(prize, "symbols") <- symbols
 prize
}

play()

# Batter up
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}

slot_display <- function(prize){
  # extract symbols
  symbols <- attr(prize, "symbols")
  # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  # combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  # display regular expression in console without quotes
  cat(string)
}

# Ex. BBB 7 C
#     $2
slot_display(play()) 

symbols <- paste(symbols, collapse = " ")
symbols # "BBB B 7"

## Generic Functions
print(pi)
print(play())

## Methods
print.POSIXct # Prints the code

methods(print) # Prints out a list of methods 

## Method Dispatch (Like in Kotlin)

print.slots <- function(x, ...) {
  #cat("I'm using the print.slots method")
  slot_display()
}

print.slots(play())

# Fixed to show properly
play()

## Classes

methods(class = "factor")

# There's more code, but I'm unsure what this relates. This textbook is leaving me on a cliffhanger >:(
