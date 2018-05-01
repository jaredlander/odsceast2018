packages <- c('useful', 'coefplot', 
              'xgboost', 'here',
              'magrittr')
purrr::walk(packages, library, character.only=TRUE)

manTrain <- readRDS(
    here('data', 'manhattan_Train.rds'))

manVal <- readRDS(
    here('data', 'manhattan_Validate.rds'))

manTest <- readRDS(
    here('data', 'manhattan_Test.rds'))

histFormula <- HistoricDistrict ~ FireService + 
    ZoneDist1 + ZoneDist2 + Class + LandUse + 
    OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + 
    GarageArea + FactryArea + NumBldgs + 
    NumFloors + UnitsRes + UnitsTotal + 
    LotFront + LotDepth + BldgFront + 
    BldgDepth + LotType + Landmark + BuiltFAR +
    Built + TotalValue - 1

manX_Train <- build.x(histFormula, data=manTrain,
                      contrasts=FALSE,
                      sparse=TRUE)
manY_Train <- build.y(histFormula, data=manTrain) %>% 
    as.integer() - 1

manX_Val <- build.x(histFormula, data=manVal,
                    contrasts=FALSE,
                    sparse=TRUE)
manY_Val <- build.y(histFormula, data=manVal) %>% 
    as.integer() - 1

manX_Test <- build.x(histFormula, data=manTest,
                    contrasts=FALSE,
                    sparse=TRUE)
manY_Test <- build.y(histFormula, data=manTest) %>% 
    as.integer() - 1

xgTrain <- xgb.DMatrix(data=manX_Train,
                       label=manY_Train)
xgTrain

xgVal <- xgb.DMatrix(data=manX_Val,
                     label=manY_Val)

xg1 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    booster='gbtree',
    eval_metric='logloss',
    nrounds=1
)
