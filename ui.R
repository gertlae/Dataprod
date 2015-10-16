library(shiny)
shinyUI(fluidPage(
titlePanel(h1("Miles per gallon predictor", align = "center")),
tags$hr(),
sidebarLayout(
        sidebarPanel(
                h3("Input panel"),
                radioButtons(inputId ="cyl", label ="Nbr of cylinders", choices = c(4,6,8)),
                sliderInput(inputId = "hp", label ='Horsepower', value = 190, min = 60, max = 330),
                numericInput(inputId = "wt" , min = 2, max = 4, label ="Weight in (lb/1000)", value = 3, step = .1),
                selectInput(inputId = "am" ,  label = 'Transmission', choice = c("Automatic" = 0, "Manual" = 1)),
                radioButtons(inputId ="gear", label ="Number of forward gears", choices = c(3,4,5)),
                submitButton("Update"),
                helpText("Input key parameters of your car in this panel. Enter the parameters and hit update")
                ),
        mainPanel(h2('The predicted miles per gallon amount to', align = "center"),
                h2(strong(em(textOutput("prediction"))), align = "center"),
                plotOutput('newHist'),
                h4('Parameter values used in calculation'),
                h4(textOutput("param", inline = T)),
                helpText("This panel displays the predicted miles per gallon for a car based on a glm model derived from the mtcars data using 
                         number of cylinders, horsepower , weight , transmission and number of forward gears. 
                         The histogram compares the prediction versus the mtcars sample data. 
                         Parameter values used to calculate the prediction are displayed for your reference.")
                
                )
        )        
))
