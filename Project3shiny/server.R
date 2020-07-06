library(shiny)
library(dplyr)
library(datasets)

data <- mtcars
data$am <- factor(data$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {
    
    # For printig the whole data set with selected variables
    output$SelectedData <- renderTable({
        if (length(input$SelectedVar) == 0) return(data)
        data %>% select(!!!c("mpg",input$SelectedVar))
    }, rownames = TRUE)
    
    # Creating a formula for lm function
    Formula <- renderText({
        data <- data %>% select(!!!input$SelectedVar)
        formula <- "mpg ~ "
        selected <- paste(names(data), collapse = " + ")
        paste(formula, selected)
    })
    
    # We'll show the formula in UI
    output$RegressionFormula <- reactive({
        Formula()
    })
    
    # Fit a linear regression with a given formula
    fit <- reactive({
        lm(as.formula(Formula()), data = data)
    })
    
    # Print summary of the model
    output$fitSummary <- renderPrint({
        if(length(input$SelectedVar) > 0){
            summary(fit())
        }else{
            "No variables selected for a model"
        }
    })
    
    # Print residual plot
    output$residPlot <- renderPlot({
        if(length(input$SelectedVar) > 0){
            par(mfrow = c(2, 2))
            plot(fit())
        }
    })
    
})
