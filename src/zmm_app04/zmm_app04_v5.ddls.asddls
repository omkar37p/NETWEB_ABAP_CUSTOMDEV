@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Incr Agg- Prd/Plnt/SLoc/Spl/Bucket'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_V5
  as select from ZMM_APP04_V2 as m
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlStkIncrQtyInMatlBaseUnit ) as incstkqty

}
where
     InventoryStockType = '01'
  or InventoryStockType = '02'
  or InventoryStockType = '07'
group by
  Material,
  Plant,
  StorageLocation,
  InventorySpecialStockType,
  MaterialBaseUnit
