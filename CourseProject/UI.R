library(shiny)
shinyUI(
  pageWithSidebar(
    headerPanel('Law of Large Numbers Simulations'),
    sidebarPanel(
        sliderInput('sample_size','Sample size:',value=1000,min=100,max=10000,step=100),
        sliderInput('probability','Probability of heads:',value=0.50,min=0.40,max=0.60,step=0.01),
        selectInput('dice_sides', 'Number of sides on dice:', 
                    choices=c('6-sided  (cube)'         = 6,
                              '12-sided (dodecahedron)' = 12,
                              '20-sided (icosahedron)'  = 20), 
                    selected = 6, multiple = FALSE, selectize = FALSE, width = NULL),
        h4('Instructions / Notes'),        
        tags$ol(
          tags$li("Adjust sample size to change the number of dice rolls and coin tosses."), 
          tags$li("Adjust the probability of heads to make the coin fair or biased."), 
          tags$li("A standard die is a six-sided cube; 12- and 20-sided dice are used in games like Dungeons & Dragons.")
        )
    ),
    mainPanel(
      p('The Law of Large Numbers states that in an experiment like rolling dice or tossing a coin, 
         the sample mean converges on the expected value (EV) as the sample
          size increases.  These simulations demonstrate this phenomenon.'),
      p('In the coin toss plot, the blue line (cumulative mean)
          converges on the orange line (EV) as the sample size increases, although it may oscillate around the
          EV line quite a bit before it converges.'),
      p('In the dice roll plot, the cumulative mean converges on
          an EV line whose y-intercept value depends on the number of sides on the dice.'),
      tabsetPanel(
        tabPanel('Coin Toss', 
                 plotOutput("coinToss")),
        tabPanel('Dice Roll', 
                 plotOutput("diceRoll"))
      )      
    )
  )  
)