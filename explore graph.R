library(caret)
data(mtcars)


featurePlot(x=mtcars,
            y = mtcars$mpg,
            plot="pairs")

