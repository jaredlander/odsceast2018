packages <- c('here', 'coefplot', 'useful', 
              'glmnet', 'ggplot2', 'magrittr')
purrr::walk(packages, library, character.only=TRUE)

dir('data')
lots <- readr::read_csv(
    here('data', 'manhattan_Train.csv'))

View(lots)
names(lots)
valueFormula <- TotalValue ~ FireService + 
    ZoneDist1 + ZoneDist2 + Class + LandUse + 
    OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + 
    GarageArea + FactryArea + NumBldgs + 
    NumFloors + UnitsRes + UnitsTotal + 
    LotFront + LotDepth + BldgFront + 
    BldgDepth + LotType + Landmark + BuiltFAR +
    Built + HistoricDistrict - 1

valueFormula
class(valueFormula)

value1 <- lm(valueFormula, data=lots)

coefplot(value1, sort='magnitude')
summary(value1)

lotsX <- build.x(valueFormula, data=lots,
                 contrasts=FALSE, 
                 sparse=TRUE)
dim(lotsX)
class(lotsX)
lotsY <- build.y(valueFormula, data=lots)
head(lotsY)
class(lotsY)

value2 <- glmnet(x=lotsX, y=lotsY,
                 family='gaussian')
value2$lambda

plot(value2)
coefpath(value2)

coef(value2)
range(value2$lambda)
coefplot(value2, sort='magnitude', lambda=500)
coefplot(value2, sort='magnitude', lambda=2000000)
coefplot(value2, sort='magnitude', lambda=100000)

library(animation)
cv.ani(k=10)


value3 <- cv.glmnet(x=lotsX, y=lotsY,
                    family='gaussian', 
                    nfolds=5)
plot(value3)
value3$lambda.min
value3$lambda.1se
coefpath(value3)
coefplot(value3, sort='magnitude', 
         lambda='lambda.min')
coefplot(value3, sort='magnitude', 
         lambda='lambda.1se')
coefplot(value3, sort='magnitude', 
         lambda='lambda.1se', plot=FALSE)
value3$cvsd

value4 <- cv.glmnet(x=lotsX, y=lotsY,
                    family='gaussian',
                    nfolds=5,
                    alpha=0)
plot(value4)
coefpath(value4)

coefplot(value4, sort='magnitude', 
         lambda='lambda.1se')

value5 <- cv.glmnet(x=lotsX, y=lotsY,
                    family='gaussian',
                    nfolds=5,
                    alpha=0.5)
coefpath(value5)

lots_new <- readRDS(
    here('data', 'manhattan_Test.rds'))

lotsX_new <- build.x(valueFormula, data=lots_new,
                     contrasts=FALSE, sparse=TRUE)
value3Preds <- predict(value3, newx=lotsX_new,
                       s='lambda.1se')
head(value3Preds)
