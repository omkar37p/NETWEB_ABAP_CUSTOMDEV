@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_AGING_REPORT as select from I_StockQuantityCurrentValue_2  ( P_DisplayCurrency: 'INR' )  as SC
left outer join I_ProductText       as pt on  pt.Product  = SC.Product
                                          and pt.Language = $session.system_language
left outer join I_StorageLocation   as SL on  SL.Plant = SC.Plant
                                         and  SL.StorageLocation = SC.StorageLocation                                              

{
 
 key SC.Product,
 key SC.Plant,
 key SC.StorageLocation,
 key SC.InventorySpecialStockType,
 SC.MaterialBaseUnit,
 SC.InventoryStockType,
 pt.ProductName as MaterialDescription,
 SL.StorageLocationName,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 //sum(SC.MatlWrhsStkQtyInMatlBaseUnit) as quantity,
 SC.MatlWrhsStkQtyInMatlBaseUnit as quantity,
 SC.Currency,
 @Semantics.amount.currencyCode: 'Currency'
// sum(SC.StockValueInCCCrcy)        as TotalGoodsMvtAmtInCCCrcy
 SC.StockValueInCCCrcy        as TotalGoodsMvtAmtInCCCrcy
   
}
where SC.ValuationAreaType = '1'
//and SC.InventoryStockType = '1'
//and SC.InventoryStockType = '2'
//and SC.InventoryStockType = '6'
//and SC.InventoryStockType = '7'
// group by
// 
// SC.Product,
// SC.Plant,
// SC.StorageLocation,
// SC.InventorySpecialStockType,
// SC.MaterialBaseUnit,
// SC.InventoryStockType,
// pt.ProductName,
// SL.StorageLocationName,
// SC.ValuationAreaType,
// SC.MatlWrhsStkQtyInMatlBaseUnit,
// SC.Currency,
// SC.StockValueInCCCrcy
