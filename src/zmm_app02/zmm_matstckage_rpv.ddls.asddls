@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Ageing Report - Root Projetion'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_MATSTCKAGE_RPV
  provider contract transactional_query
  as projection on ZMM_MATSTCKAGE_RV
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventoryStockType,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      ovrallqty
}
