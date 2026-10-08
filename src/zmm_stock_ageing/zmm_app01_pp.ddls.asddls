@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overdue days'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
//define view entity ZMM_APP01_PP with parameters @Environment.systemField: #SYSTEM_DATE P_ReportDate : sydate as select from ZMM_APP01_P(P_ReportDate:$parameters.P_ReportDate)
  define view entity ZMM_APP01_PP as select from ZMM_APP01_P
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
//    @Aggregation.default: #SUM
//    @Aggregation.exception: #LAST
    Quantity,
    NSDM_Display_Currency,
//    @Aggregation.default: #SUM
//    @Aggregation.exception: #LAST
    StockValueInDisplayCurrency,
    MatlDocLatestPostgDate,
    ReportingDate,
    Overdue_Days,
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
    case 
      when Overdue_Days >= 0 
         and Overdue_Days <= 90
        then 3 // Green
 
      when Overdue_Days >= 91 
         and Overdue_Days <= 180
        then 2 // Orange
 
      when Overdue_Days >= 181 
         and Overdue_Days <= 365
        then 1 // Red
 
      else 0 // Grey
     end as CRITICALITY
     }
     
     
//    case
//        when Overdue_Days >= 0 
//          and  Overdue_Days <= 90
//            then 30 // Green
//
//        when Overdue_Days >= 91 
//           and Overdue_Days <= 180
//            then 50 // Orange
//
//        when Overdue_Days >= 181 
//        and  Overdue_Days <= 365
//            then 70 // Red
//
//        else 100
//       end as Progress,
//cast(100 as abap.int4)                      as Total
//}
