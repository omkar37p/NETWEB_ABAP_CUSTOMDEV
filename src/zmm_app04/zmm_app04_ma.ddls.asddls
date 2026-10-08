@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_MA
  as select from I_MaterialStock_2 as materialstock
{
  key materialstock.Material,
  key materialstock.Plant,
  key materialstock.StorageLocation,
//  key materialstock.Batch,
      materialstock.InventorySpecialStockType,
//      materialstock.InventoryStockType,
      materialstock.SDDocument,
      materialstock.SDDocumentItem,
//      materialstock.Batch,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      sum (materialstock.MatlWrhsStkQtyInMatlBaseUnit) as specialStockQuantity,
      materialstock.MaterialBaseUnit as Unit
}
where materialstock.MatlWrhsStkQtyInMatlBaseUnit <> 0 
and materialstock.InventorySpecialStockType = 'E'

group by
      materialstock.Material,
      materialstock.Plant,
      materialstock.StorageLocation,
//      materialstock.Batch,
      materialstock.InventorySpecialStockType,
//      materialstock.InventoryStockType,
      materialstock.SDDocument,
      materialstock.SDDocumentItem,
//      materialstock.Batch,
//      materialstock.MatlWrhsStkQtyInMatlBaseUnit,
      materialstock.MaterialBaseUnit
      
      
having
     sum( materialstock.MatlWrhsStkQtyInMatlBaseUnit ) <> 0      
