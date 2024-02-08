# Chapter 1 Exercises

# Arithmotigcic (this is so butchered that I am unsure how I even wrote this)
1+1

#Print between 100-130
100:130

# Multi-Line
5-

1

# Exercise 1
10 + 2

12+ 3

36-6

3/3

# Dice!
1:6

# Objects (Variables >:( )

a <- 5
a + 3

die <- 1:6

die

my_number <- 1
my_Number

ls()

# Extra

die - 1
die / 2
die * die # oooo, it does it to all of the variables in the array w/o loop (less boilerplate!)

# Functions
args(round) # Args tell you the args that a function can take
function # Throwing a function w/o args shows the code behind it

round(3.1415) # Rounds to 3
factorial(3) # Factorializations to 3
mean(1:5) # Exactly as it sounds
sample(1:6) # Your friendly randomizer, better than new Random()
round(1.1415, digits = 2) # digits are digits after '.'

# Alright, let's actually make this damn dice
# first, definiting "static" variables
rollAmount <- 3

die <- 1:6 # First, six sided dice
sample(x = die, size = rollAmount, REPLACE = true) # Let's roll 3 times and average it out. Replace ensures samples are independent of each other
round(mean(die))

# Woo, Functions!
# Basic void function
roll <- function() {
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)
}

roll()
# Take Arguments function
roll2 <- function(bones = 1:6) {
dice <- sample(bones, size = 2, replace = TRUE)
sum(dice)
}






