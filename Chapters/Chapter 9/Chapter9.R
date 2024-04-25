
# Chapter 9 (Loops)

die <- c(1, 2, 3, 4, 5, 6)

## Expand.grid

# Give every possible variation
rolls <- expand.grid(die, die, die, die)
print(rolls)

rolls$value <- rolls$Var1 + rolls$Var2
head(rolls, 3)

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)
prob

rolls$Var1

rolls$prob1 <- prob[rolls$Var1]
head(rolls, 3)

# Lookup probabilities values
rolls$prob2 <- prob[rolls$Var2]
head(rolls, 3)

# Probability of rolling each combination
rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls, 3)

sum(rolls$value * rolls$prob)

# Combos (Fried rice+ + Orange Chicken)
combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
combos

# Readd function
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06,
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)

combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
head(combos, 3)

# Calculate every combination
combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos, 3)
sum(combos$prob) # <- SHOULD EQUAL ONE

# Symbooooooooools
symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
## "DD" "DD" "DD"
score(symbols)
## 800

## Finally getting to for loops!
for (value in c("My", "fiorst", "for", "loop")) {
  print(value)
}
# Several other loop da loops

chars <- vector(length = 4)
words <- c("My", "fourth", "for", "loop")
for (i in 1:4) {
  chars[i] <- words[i]
}
chars

# Bcak to combos
combos$prize <- NA
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}
head(combos, 3)

# How much out for every dollar
sum(combos$prize * combos$prob)


# Handle dem wild diamonds (override previous function) (IF cominbing from previous, rerun previous code bits)
score <- function(symbols) {
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  # identify case
  # since diamonds are wild, only nondiamonds
  # matter for three of a kind and all bars
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  # assign prize
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  # double for each diamond
  prize * 2^diamonds
}

## While Loops
# How long till they are borked?
plays_till_borked <- function(start_with) {
  cash <- start_with
  n <- 0
  while (cash > 0) {
    cash <- cash - 1 + play()
    n <- n + 1
  }
  n
}
plays_till_borked(100)

## Repeat Loops
plays_till_borked <- function(start_with) {
  cash <- start_with
  n <- 0
  repeat {
    cash <- cash - 1 + play()
    n <- n + 1
    if (cash <= 0) {
      break
    }
  }
  n
}
plays_till_borked(100)







