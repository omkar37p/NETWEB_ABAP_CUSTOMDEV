@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Bucket Aggregate CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP03_V3
  with parameters
    rptdate : bldat
  as select from ZMM_APP03_V2( rptdate : $parameters.rptdate ) as m
{
  key Material,
  key Plant,
  key StorageLocation,
      //  key InventoryStockType,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
  key bucket,
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
  //  InventoryStockType,
  InventorySpecialStockType,
  MaterialBaseUnit,
  bucket
