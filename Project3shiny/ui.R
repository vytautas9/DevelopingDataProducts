library(shiny)

shinyUI(
    navbarPage("First shiny app",
               tabPanel("Models",
                        fluidPage(
                            
                            titlePanel("Regression models on \"mtcars\" dataset"),
                            
                            # Sidebar with a multiple selection input
                            sidebarLayout(
                                sidebarPanel(
                                    # Multiple selection input for variables
                                    varSelectInput("SelectedVar", "Variable:", mtcars[, -1], 
                                                   multiple = TRUE, selectize = FALSE)
                                ),
                                
                                # Show a formula for linear regression from selected variables
                                mainPanel(
                                    h4("Formula for linear regression from selected variables:"),
                                    textOutput("RegressionFormula"),
                                    h4("Summary of the fitted model"),
                                    verbatimTextOutput("fitSummary"),
                                    h4("Residual plots:"),
                                    plotOutput("residPlot")
                                )
                            )
                        )#fluidPage
               ),#tabPanel
               
               tabPanel("Selected Data",
                        fluidPage(
                            titlePanel("Data frame of selected data"),
                            tableOutput("SelectedData")
                        )
               ),#tabPanel
               
               tabPanel("Documentation of the data",
                        fluidPage(
                            titlePanel("Documentation of \"mtcars\" dataset"),
                            
                            h2("Motor Trend Car Road Tests"),
                            hr(),
                            h3("Description"),
                            helpText("The data was extracted from the 1974 Motor Trend US magazine,",
                                     " and comprises fuel consumption and 10 aspects of automobile design and performance",
                                     " for 32 automobiles (1973–74 models)."),
                            h3("Format"),
                            p("A data frame with 32 observations on 11 variables."),
                            
                            HTML("
                                <p>[, 1] mpg Miles/(US) gallon</p>
                                <p>[, 2] cyl Number of cylinders</p>
                                <p>[, 3] disp Displacement (cu.in.)</p>
                                <p>[, 4] hp Gross horsepower</p>
                                <p>[, 5] drat Rear axle ratio</p>
                                <p>[, 6] wt Weight (1000 lbs)</p>
                                <p>[, 7] qsec 1/4 mile time</p>
                                <p>[, 8] vs Engine (0 = V-shaped, 1 = straight)</p>
                                <p>[, 9] am Transmission (0 = automatic, 1 = manual)</p>
                                <p>[,10] gear Number of forward gears</p>
                                <p>[,11] carb Number of carburetors</p>
                                 ")
                        )#fluidPage
               )#tabPanel
    )#navbarPage
)#ShinyUI