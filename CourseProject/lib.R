library(ggplot2)
library(scales)
# function to roll dice and calculate cumulative average roll
tossCoin <- function(n=30,p=0.5) {
  
  # create a vector of index numbers
  index <- c(1:n)
  
  # create a vector of outcomes (H/T are coded using 0/1)
  outcomes <- c(0,1) # sample space
  probabilities <- c(1-p,p)
  
  # create a random sample of n flips
  flips <- sample(outcomes,n,replace=T,prob=probabilities)
  
  # now create a cumulative mean vector
  cum_mean <- cumsum(flips)/(1:n)
  
  # now combine the index, flips and cum_mean vectors
  # into a data frame and return it
  return(data.frame(index,flips,cum_mean))
}
ggplotCoinTosses <- function(n,p) {
  # visualize how cumulative average converges on p  
  # roll the dice n times and calculate means
  trial1 <- tossCoin(n,p)
  max_y <- ceiling(max(trial1$cum_mean))
  if (max_y < .75) max_y = .75 
  min_y <- floor(min(trial1$cum_mean))
  if (min_y > .4) min_y = .4
  
  # calculate last mean and standard error
  last_mean <- round(trial1$cum_mean[n],9)
  
  # plot the results together
  plot1 <- ggplot(trial1, aes(x=index,y=cum_mean)) +
    geom_line(colour = "blue") +
    geom_abline(intercept=0.5,slope=0, color = 'red', size=1) +      
    geom_abline(intercept=p,slope=0, color = 'darkorange', size=1) +
    theme(plot.title = element_text(size=rel(1.5)),
          panel.background = element_rect()) +
    labs(x = "n (number of tosses)", 
         y = "Cumulative Average") +
    scale_y_continuous(limits = c(min_y, max_y)) +
    scale_x_continuous(trans = "log10",
                       breaks = trans_breaks("log10",function(x) 10^x),
                       labels = trans_format("log10",math_format(10^.x))) +
    annotate("text",
             label=paste("Cumulative mean =", last_mean,
                         "\nEV =",  p,
                         "\nSample size =", n), 
             y=(max_y - .20), 
             x=10^(log10(n)/2), colour="darkgreen") +
    annotate("text",
           label=paste("P(Heads) with Fair Coin = 0.50"), 
           y=(max_y - .80), 
           x=10^(log10(n)/2), colour="red") +
    annotate("text",
           label=paste("P(Heads) with Biased Coin = ", p), 
           y=(max_y - .875), 
           x=10^(log10(n)/2), colour="darkorange")  
  return(plot1)
}
# function to roll dice and calculate cumulative average roll
rollDice <- function(n=30,dice_sides) {
  
  # create a vector of index numbers
  index <- c(1:n)
  
  # create two vectors (one for each die) with rolls between 1 and 6
  outcomes <- 1:dice_sides # sample space
  die1 <- sample(outcomes,n,replace=T)
  die2 <- sample(outcomes,n,replace=T)
  total_dice <- die1 + die2
  
  # now create a cumulative mean vector
  cum_mean <- cumsum(total_dice)/(1:n)
  
  # now combine the index, die1, die2, total_dice, and cum_mean vectors
  # into a data frame and return it
  return(data.frame(index,die1,die2,total_dice,cum_mean))
}
ggplotDiceRolls <- function(n=30,dice_sides=6) {
  # visualize how cumulative average converges on 7
  
  # roll the dice n times and calculate means
  trial1 <- rollDice(n,dice_sides)
  expected_value <- (2 * sum(1:dice_sides)/dice_sides)
  max_y <- ceiling(max(trial1$cum_mean))
  if (max_y < expected_value + 3) max_y = expected_value + 3
  min_y <- floor(min(trial1$cum_mean))
  if (min_y > 6) min_y = 6
  
  # calculate last mean and standard error
  last_mean <- round(trial1$cum_mean[n],9)
  
  # plot the results together
  p <- ggplot(trial1, aes(x=index,y=cum_mean)) +
    geom_line(colour = "blue") +
    geom_abline(intercept=expected_value,slope=0, color = 'orange', size=1) + 
    theme(plot.title = element_text(size=rel(1.5)),
          panel.background = element_rect()) +
    labs(x = "n (number of rolls)", 
         y = "Cumulative Average") +
    scale_y_continuous(limits = c(min_y, max_y)) +
    scale_x_continuous(trans = "log10",
                       breaks = trans_breaks("log10",function(x) 10^x),
                       labels = trans_format("log10",math_format(10^.x))) +
    annotate("text",
             label=paste(paste("Two ",dice_sides,"-sided Dice",sep=''),
                         "\nCumulative mean =", last_mean,
                         "\nEV =", expected_value,
                         "\nSample size =", n), 
             y=(min_y + 1.5), 
             x=10^(log10(n)/2), colour="darkgreen")
  return(p)
}