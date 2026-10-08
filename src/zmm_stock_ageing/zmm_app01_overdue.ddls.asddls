@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overdue_Days'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP01_OVERDUE
  as select from ZMM_APP01_RV as SSS
  left outer join I_MaterialStock_2 as MS
    on SSS.Product = MS.Material
   and SSS.Plant = MS.Plant
   and SSS.StorageLocation = MS.StorageLocation
   and SSS.InventorySpecialStockType = MS.InventorySpecialStockType
{
    key SSS.Product,
    key SSS.Plant,
    key SSS.StorageLocation,
    key SSS.InventorySpecialStockType,
    key SSS.InventoryStockType,
    key SSS.SDDocument,

    SSS.Quantity,
    SSS.StockValueInDisplayCurrency,

    max( MS.MatlDocLatestPostgDate ) as MatlDocLatestPostgDate,
    
    dats_days_between(
        max( MS.MatlDocLatestPostgDate ),
        $session.system_date
    ) as Overdue_Days      
}
group by
    SSS.Product,
    SSS.Plant,
    SSS.StorageLocation,
    SSS.InventorySpecialStockType,
    SSS.InventoryStockType,
    SSS.SDDocument,
    SSS.Quantity,
    SSS.StockValueInDisplayCurrency
