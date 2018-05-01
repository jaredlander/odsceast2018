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
    Built + HistoricDistrict