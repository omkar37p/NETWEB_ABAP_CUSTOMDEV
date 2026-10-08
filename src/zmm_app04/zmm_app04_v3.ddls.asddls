@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stk Inc Agg-Prd/Plnt/SLoc/Styp/Spl/Bckt'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_V3
  as select from ZMM_APP04_V2 as m
{
  key Material,
  key Plant,
  key StorageLocation,
      //  key InventoryStockType,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
  key bucket,
//      m.SDDocument,
      m.MatlDocLatestPostgDate,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlStkIncrQtyInMatlBaseUnit ) as incstkqty

}
where
  //m.MatlDocLatestPostgDate <= $parameters.rptdate  and
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
  bucket,
//  m.SDDocument,
  m.MatlDocLatestPostgDate
