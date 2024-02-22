die <- c(1,2,3,4,5,6)
is.vector(die)

five <- 5
five

is.vector(five)
length(five)
length(die)

int <- 1L
text <- "ace"

int <- c(1L, 5L)
text <- c("ace", "hearts")

sum(int) # It's num in the text, but I assume that's int
sum(text)

# Doubles
die <- c(1,2,3,4,5,6)
typeof(die)

# Integers
int <- c(-1L, 2L, 4L)
typeof(int)

# Numbers can sometimes be inaccurate
sqrt(2)^2 - 2

# Characters
text <- c("Hello", "World")
text

typeof(text)
typeof("hello")

# Logic
logic <- c(TRUE, FALSE, TRUE)
logic
typeof(logic)
typeof(F)

# Complex and Raw
comp <- c(1 + 1i, 1+2i, 1+3i)
comp
typeof(comp)

raw(3)
typeof(raw(3))

hand <- c("ace", "king", "queen", "jack", "ten")
hand

typeof(hand)

# Attributes
names(die) <- c("one", "two", "three", "four", "five", "six")
attributes(die)
die
die + 1
names(die) <- c("uno", "dos", "tres", "quatro", "cinco", "seis")
die
names(die) <- NULL
die

# Dim
dim(die) <- c(2,3)
dim

dim(die) <- c(3, 2)
die

dim(die) <- c(1, 2, 3)
die

# Matrices
