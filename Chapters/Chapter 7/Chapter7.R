# Spooky Chapter 7 (It's April)

# If statements:
num <- -2
if (num < 0) {
  num <- num * -1
}

if (num < 0) {
  print("num is negative.")
  print("Don't worry, I'll fix it.")
  num <- num * -1
  print("Now num is positive.")
} else {
  print("Number is already positive >:)")
}

dec <- 3.14
if (dec >= 0.5) {
  a <- trunc(a) + 1
} else {
  a <- trunc(a) # Returns just the decimal part
}

a <- 1
b <- 1
if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}

# Get's 3 symbols to act as a "roll"
#  diamonds (DD), sevens (7), triple bars (BBB), double bars (BB), single bars (B), cherries (C), and zeroes (0).
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sampled <- sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
  sampled <- na.omit(sampled)
}

# Pg 133

play <- function() {
  # step 1: generate symbols
  symbols <- get_symbols()
  # step 2: display the symbols
  print(cat(paste(symbols, ', ')))
  # step 3: score the symbols
  score <- score(symbols)
  print(cat("You have won $", score, "!"))
  
  # I keep getting null at the end of my strings??? Will eventually figure this out!
}

score <- function(symbols) {
  # Itdentification of the Cases which the gambling machine recongnizes (beep boop)
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # Get the prize that one may find (in terms of cash)
  if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5# assign $5
  } else {
    # count cherries
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  # Adjusted for those diamond slots
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}
  
play()





