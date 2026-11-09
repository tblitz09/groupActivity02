# Replace mydata and outcome with your own names

# Clean up workspace
rm(list = ls()) # clear variables from previous work.
graphics.off() # clear out all old plots
cat("\014") # clear the console

library(tidyverse)
library(rpart)
library(rpart.plot)

# Read the CSV file, or paste the tibble from your group's slide
mydata <- read_csv("data/groupN_something.csv")
head(mydata)       # what do the first rows look like?
summary(mydata)    # what is the range of each variable?

# Step 1: what is the baseline to beat?
table(mydata$outcome)  # edit outcome to match your variable name

# Step 2: grow the tree
# (use method = "anova" for a numeric outcome)
fit <- rpart(outcome ~ ., data = mydata, method = "class")

# Step 3: draw it, and read it aloud
rpart.plot(fit)
rpart.rules(fit, cover = TRUE)
fit$variable.importance

# Step 4: predict for new cases (column names must match your data)
predict(fit, newdata = new_cases, type = "class")  # category
predict(fit, newdata = new_cases, type = "prob")   # probabilities

# Step 5: an honest test with rows that the tree has never seen
set.seed(301)
# 75% of the rows for training
train_rows <- sample(nrow(mydata), round(0.75 * nrow(mydata)))
train <- mydata[train_rows, ]
test  <- mydata[-train_rows, ]

fit <- rpart(outcome ~ ., data = train, method = "class")
predicted <- predict(fit, newdata = test, type = "class")
table(actual = test$outcome, predicted)   # the confusion matrix
mean(predicted == test$outcome)           # the accuracy

# Step 6: is the tree too big?
printcp(fit)     # compare the size of the tree (nsplit) with xerror
plotcp(fit)      # a picture of the same table
pruned <- prune(fit, cp = 0.05)
rpart.plot(pruned)