library(UsingR)
library(caret)
library(shiny)
## initializing eg modelfit in which the model will stored
data(mtcars)
modelfit <<- NULL

## function to determine the model based on the mtcars data
predictMpg <- function(cyl,hp,wt,am,gear)
{
        if ((wt <= 0) | (wt >= 4.5)) stop("predictMpg function: invalid weight")
        if(is.null(modelfit))  ## only calculate the model when it is not yet known
        {    
                set.seed(12345)
                intrain = createDataPartition(mtcars$mpg, p = 4/5, list = FALSE)
                train = mtcars[intrain,]
                #save modelfit so it can be reused
                modelfit <<- train(train$mpg ~ cyl+hp+wt+am+gear, method="glm", data=train)
        }
        newcar = NULL
        newcar$cyl = cyl
        newcar$hp = hp
        newcar$wt = wt
        newcar$am = am
        newcar$gear = gear
        prediction = predict(modelfit,newcar)
        summary(prediction)
        round(prediction,2)
}


shinyServer
        (
        function(input, output) 
        {
        output$newHist <- renderPlot({
                          hist(mtcars$mpg, xlab='mpg', col='salmon',main='This prediction vs mtcars sample', breaks = 16)
                          pred <- predictMpg(as.numeric(input$cyl),input$hp,input$wt,as.numeric(input$am),as.numeric(input$gear))
                          abline(v = pred, lwd = 4, col = "darkgrey")
                                     })        
        cyl <- renderText({input$cyl})
        hp <- renderText({input$hp})
        wt <- renderText({input$wt})
        am <- renderText({ifelse(input$am == 0, 'Automatic', 'Manual')})
        gear <- renderText({input$gear})
        output$param <- reactive(paste ("Cylinders: ", cyl(), " - Horsepower: ", as.character(hp()),' - Weight: ',as.character(wt()),' - Transmisson: ', ifelse( (am() == 0), 'Automatic', 'Manual'), ' - Gear:', gear())
        )        
                                 ## calculate the prediction
        output$prediction <- renderText({predictMpg(as.numeric(input$cyl),input$hp,input$wt,as.numeric(input$am),as.numeric(input$gear))
                                        })
        }
        )
