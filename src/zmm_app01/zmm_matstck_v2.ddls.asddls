@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Overall Stock Qty'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATSTCK_V2
  as select from ZMM_MATSTCKAGE_1
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventorySpecialStockType,
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as ovrallqty
}
where
  InventoryStockType <> '06'
group by
  Material,
  Plant,
  StorageLocation,
  InventorySpecialStockType,
  MaterialBaseUnit
