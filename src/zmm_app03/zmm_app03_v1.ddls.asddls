@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Aggregate CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP03_V1
  with parameters
    rptdate : bldat
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
  m.MatlDocLatestPostgDate <= $parameters.rptdate
group by
  Material,
  Plant,
  StorageLocation,
  InventoryStockType,
  InventorySpecialStockType,
  MaterialBaseUnit
