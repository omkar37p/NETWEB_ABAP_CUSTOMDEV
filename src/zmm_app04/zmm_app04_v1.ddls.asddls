@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Aggregate-Prod/Plnt/SLoc/Styp/Spcl'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_V1
  as select from I_MaterialStock_2 as m
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventoryStockType,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as totstkqty

}
where
  m.MatlDocLatestPostgDate <= $session.system_date
group by
  Material,
  Plant,
  StorageLocation,
  InventoryStockType,
  InventorySpecialStockType,
  MaterialBaseUnit
