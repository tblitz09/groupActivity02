library(rpart)
library(rpart.plot)
checkpoint <- read.csv('data/group2_zombie_checkpoint.csv')
checkpoint$status <- factor(checkpoint$status, levels = c('human', 'zombie'))
# Rows are actual classes, columns are predicted classes.
loss <- matrix(c(0, 10, 1, 0), nrow = 2,
               dimnames = list(actual = levels(checkpoint$status),
                               predicted = levels(checkpoint$status)))
fit <- rpart(status ~ ., data = checkpoint, method = 'class')
fit_costly <- rpart(status ~ ., data = checkpoint, method = 'class',
                    parms = list(loss = loss))
confusion <- function(model, data) {
  table(actual = data$status,
        predicted = factor(predict(model, data, type = 'class'),
                           levels = levels(checkpoint$status)))
}
full_default <- confusion(fit, checkpoint)
full_costly <- confusion(fit_costly, checkpoint)
# Same split as the supplied graph.R. Both models use training rows only.
set.seed(301)
train_rows <- sample(nrow(checkpoint), round(0.75 * nrow(checkpoint)))
train <- checkpoint[train_rows, ]
test <- checkpoint[-train_rows, ]
fit_train <- rpart(status ~ ., data = train, method = 'class')
fit_train_costly <- rpart(status ~ ., data = train, method = 'class',
                          parms = list(loss = loss))
test_default <- confusion(fit_train, test)
test_costly <- confusion(fit_train_costly, test)
stopifnot(identical(as.vector(full_default), c(66L,2L,3L,19L)),
          identical(as.vector(full_costly), c(54L,0L,15L,21L)),
          identical(as.vector(test_default), c(18L,2L,0L,2L)),
          identical(test_default, test_costly))
plot_tree <- function(model, title = '') {
  rpart.plot(model, type = 2, extra = 0, under = FALSE,
             fallen.leaves = TRUE, faclen = 0, varlen = 0,
             roundint = FALSE, digits = 4, tweak = 1.15,
             box.palette = c('#dce8f0', '#f2ddd8'),
             shadow.col = 0, branch.col = '#64748b',
             split.col = '#18364b', main = title)
}
