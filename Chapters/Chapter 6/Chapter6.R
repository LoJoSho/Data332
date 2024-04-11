# Chapter 6 Hands-on-R

library(devtools)
parenvs(all = TRUE)

### Working with Enviorments - Boring stuff 
as.environment("package:stats")

globalenv()
## <environment: R_GlobalEnv>
baseenv()
## <environment: base>
emptyenv()
##<environment: R_EmptyEnv>
parent.env(globalenv())
parent.env(emptyenv())
## Error in parent.env(emptyenv()) : the empty environment has no parent

# Getting an empty enviorment
ls(emptyenv())
# Get all the global variables
ls(globalenv())

# Get the top 3 of the deck (shown in chapter 5)
head(globalenv()$deck, 3)
# Assign a new variable in the global enviorment
assign("new", "Hello Global", envir = globalenv())
globalenv()$new

### The Active Enviorment

# See the enviorment to see the current active development
# environment() <- <environment: R_GlobalEnv> - This doesn't work, but is in the book??? 
  
### Evaluate
show_env <- function(){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

show_env()
# Check enviorment of the function
environment(show_env)
#environment(parenvs)

show_env <- function(){
  a <- 1
  b <- 2
  c <- 3
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

show_env()

# again 
foo <- "take me to your runtime"
show_env <- function(x = foo){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}
show_env()

# Closure
setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}

# Redo
setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

# Ughhh, while this was interesting, this chapter was incredibly boring... 

