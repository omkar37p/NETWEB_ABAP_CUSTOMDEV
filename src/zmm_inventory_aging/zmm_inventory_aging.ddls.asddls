@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TEST PROCESS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_INVENTORY_AGING as select from I_MaterialDocumentItem_2 as GG


{ 
  key GG.MaterialDocument,
  key GG.MaterialDocumentItem,
  key GG.MaterialDocumentYear,

      GG.Plant,
      GG.Material as Material,
      GG.Batch,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when GG.DebitCreditCode = 'H'// and GG.GoodsMovementType <> '641'
      then
      -1 * GG.QuantityInBaseUnit
      else
      GG.QuantityInBaseUnit
      end as QuantityInBaseUnit,

      GG.StorageLocation, 

      GG.GoodsMovementType,
      GG.MaterialBaseUnit,
      GG.PurchaseOrder,
      GG.PurchaseOrderItem,
//      GG.MaterialDocument,
      GG.ManufactureDate ,
      GG.PostingDate  ,
//      gg.PostingDate  ,
      GG.CompanyCode,
      GG.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case when GG.DebitCreditCode = 'H'
      then
      -1 * GG.TotalGoodsMvtAmtInCCCrcy
      else
      GG.TotalGoodsMvtAmtInCCCrcy
      end as TotalGoodsMvtAmtInCCCrcy,
//      GG.TotalGoodsMvtAmtInCCCrcy,
      GG.SalesOrder        ,
      GG.SalesOrderItem    ,
      GG.Customer,
      GG.Supplier,
      GG.DebitCreditCode,
      GG.InventorySpecialStockType

}
where (GG.InventorySpecialStockType <> ' ' or GG.StorageLocation  <> ' ' )//or ( GG.StorageLocation  <> ' ' and GG.Supplier is initial)

