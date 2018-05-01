packages <- c('useful', 'coefplot', 
              'xgboost', 'here')
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