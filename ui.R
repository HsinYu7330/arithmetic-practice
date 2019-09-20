library(shiny)
library(shinyjs)
jsResetCode <- "shinyjs.reset = function() {history.go(0)}" # Define the js method that resets the page

shinyUI(fluidPage(
  useShinyjs(),                                       
  extendShinyjs(text = jsResetCode),
  
  
  # Application title
  titlePanel("Calculator Practice"),
    
  sidebarLayout(
    sidebarPanel(
      numericInput("numbers",
                  h3("How many numbers in your practice"),
                  value = 3),
      sliderInput('number_range', 
                  h3("Numbers' range"), min = 0, max = 100, value = c(1, 50)),
      checkboxGroupInput("operator", 
                         h3('What operational symbols in your practice'), 
                         choices = list("+" = "+", "-" = "-", "*" = "*", "/" = "/"), 
                         selected = '+')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3('Question:'),
      h2(verbatimTextOutput("formula")),
      numericInput('answers', 
                   h3('Your answer:'), 
                   value = 0),
      verbatimTextOutput("messages")
      # actionButton('next_quest', 'Next')
    )
  )
))