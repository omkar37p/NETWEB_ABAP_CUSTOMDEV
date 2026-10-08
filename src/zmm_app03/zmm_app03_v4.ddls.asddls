@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Bucket Aggregate CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP03_V4
  with parameters
    rptdate : bldat
  as select from ZMM_APP03_V2( rptdate : $parameters.rptdate ) as m
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventorySpecialStockType,
  key MaterialBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlStkDecrQtyInMatlBaseUnit ) as dcrstkqty

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
  MaterialBaseUnit
