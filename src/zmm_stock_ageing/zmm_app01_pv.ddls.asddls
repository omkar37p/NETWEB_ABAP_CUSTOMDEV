@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Agg - Prodt/Plnt/SLoc/Spcl/Bucket'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZMM_APP01_PV 

  provider contract transactional_query
  as projection on ZMM_APP01_P
//  with parameters
//    P_ReportDate : abap.dats 
//  as select from ZMM_APP01_P(P_ReportDate:$parameters.P_ReportDate )  
{
    key Product,
    key Plant,
    key StorageLocation,
    key InventorySpecialStockType,
    key InventoryStockType,
    key SDDocument,
    PlantName,
    CompanyCode,
    ProductDescription,
    StorageLocationName,
    InventorySpecialStockTypeName,
    MaterialBaseUnit,
    SDDocumentItem,
////    @Aggregation.default: #SUM
//    @Aggregation.exception: #LAST
    Quantity,
    NSDM_Display_Currency,
//    @Aggregation.default: #SUM
//    @Aggregation.exception: #LAST
    StockValueInDisplayCurrency,
    MatlDocLatestPostgDate,
    Quantity_30,
    Value_30,
    Quantity_60,
    Value_60,
    Quantity_90,
    Value_90,
    Quantity_120,
    Value_120,
    Quantity_150,
    Value_150,
    Quantity_180,
    Value_180,
    Quantity_365,
    Value_365,
    Quantity_bucket,
    Value_bucket,
    @EndUserText.label: 'Overdue_Days'
    Overdue_Days
//    ,
//    @UI.hidden: true    
//    CRITICALITY
}
