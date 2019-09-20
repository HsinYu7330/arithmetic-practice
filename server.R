library(shiny)
jsResetCode <- "shinyjs.reset = function() {history.go(0)}" # Define the js method that resets the page


shinyServer(function(input, output) {
  
  
  nextQuest <- reactive({FALSE})
  
  random_num <- reactive({
    min_num <- input$number_range[1]
    max_num <- input$number_range[2]
    random_num = sample(min_num:max_num, input$numbers)
    random_num
  })
  
  operators <- reactive({
    operators <- sample(input$operator, input$numbers-1, replace = TRUE)
    operators
  })
  
  eventReactive(nextQuest, {
    random_num <- random_num()
    operators <- operators()
    nextQuest <- FALSE
  })
  
  output$formula <- renderPrint({
    random_num <- random_num()
    operators <- operators()
    paste0(c(rbind(random_num, c(operators, '='))), collapse='', sep=' ')
  })
  
  
  output$messages <- renderPrint({
    
    random_num <- random_num()
    operators <- operators()
    formulas <- paste0(c(rbind(random_num, c(operators, '='))), collapse='', sep=' ')
    formulas <- substr(formulas, 1, nchar(formulas)-2) # remove '='
    formulas
    if(eval(parse(text = formulas)) == input$answers){
      nextQuest <- TRUE
      'Congratulations'
      js$reset()
      
    }else{
      'Oh! Opps'
    }
    
    
  })
  
  
  
})