@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Transit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_STOCK_TRANSIT as select from I_MaterialDocumentItem_2 as ST


{ 
  key ST.Material,
  key ST.Plant,
  key ST.StorageLocation,
  key ST.GoodsMovementType,
  ST.MaterialDocument,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
   sum(ST.QuantityInBaseUnit)  as QuantityInBaseUnit,
 
       ST.MaterialBaseUnit,
       ST.InventorySpecialStockType,
       ST.Supplier,
       ST.DebitCreditCode,
       ST.OrderID
             
}
//where (ST.InventorySpecialStockType <> ' ' or ST.StorageLocation  = ' ' )

group by
 ST.Material,
 ST.Plant,
 ST.MaterialDocument,
 ST.StorageLocation,
 ST.GoodsMovementType,
 ST.QuantityInBaseUnit,
 ST.MaterialBaseUnit,
 ST.InventorySpecialStockType,
 ST.Supplier,
 ST.DebitCreditCode, 
 ST.OrderID
 