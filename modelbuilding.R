## load libs
library(caret)
## building the model

data(mtcars)
intrain = createDataPartition(mtcars$mpg, p = 4/5, list = FALSE)
train = mtcars[intrain,]
test = mtcars[-intrain,]
modelfit <- train(train$mpg ~ cyl+hp+wt+am+gear, method="glm", data=train)
prediction =predict(modelfit,input)

# calculate the RMSE on training and test
TrainRMSE = sqrt(sum(modelfit$fitted- train$mpg)^2)
TestRMSE = sqrt(sum(predict(modelfit, newdata = test) - test$mpg)^2)


modelfit= train(train$mpg ~ cyl+hp+wt+am+gear, method="glm", data=train)
input = NULL
input$cyl = 4 #nbr of cylinders (4, 6 or 8)
input$hp = 130 # Gross horsepower
input$wt = 3.000 #Weight (lb/1000)
input$am = 1 #Transmission (0 = automatic, 1 = manual)
input$gear = 4 #Number of forward gears ( 3,4 or 5)


# result = cbind(prediction, test[,1])
# 
# mse = sqrt(sum((prediction-test[,1])^2)/11)
# 
# mse / mean(mtcars$mpg)
# 
# prediction2 =predict(modelfit,train[,c(2,4,6,9,10)])
# 
# result2 = cbind(prediction2, train[,1])
# 
# mse2 = sqrt(sum((prediction2-train[,1])^2)/11)
# 
# mse2 / mean(mtcars$mpg)
