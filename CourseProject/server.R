library(shiny); 
source("lib.R")

shinyServer(
  function(input,output){
    output$coinToss <- renderPlot({     
      sample_size <- as.integer(input$sample_size)
      probability <- as.numeric(input$probability)
      ggplotCoinTosses(sample_size, probability)
    })
    output$diceRoll <- renderPlot({     
      sample_size <- as.integer(input$sample_size)
      dice_sides <- as.integer(input$dice_sides)
      ggplotDiceRolls(sample_size, dice_sides)
    })    
  }  
)