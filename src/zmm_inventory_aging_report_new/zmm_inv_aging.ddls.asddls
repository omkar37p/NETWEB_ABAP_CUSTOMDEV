@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TEST'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view entity zmm_inv_aging as select from I_MaterialDocumentItem_2 as GG
{

  key GG.Material,
  key GG.MaterialDocument,
  key GG.MaterialDocumentItem,
  key GG.MaterialDocumentYear, 
  key    GG.StorageLocation, 
   key   GG.Plant,
       GG.Batch,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when GG.DebitCreditCode = 'H'
      then
      -1 * GG.QuantityInBaseUnit
      else
       GG.QuantityInBaseUnit
       end as QuantityInBaseUnit,
      GG.MaterialBaseUnit,
      GG.PurchaseOrder,
      GG.PurchaseOrderItem,
//      GG.MaterialDocument,
      GG.ManufactureDate ,
      GG.PostingDate  ,
//      gg.PostingDate  ,
      GG.CompanyCode,
//      GG.DebitCreditCode as code,
      GG.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      GG.TotalGoodsMvtAmtInCCCrcy,
      GG.SalesOrder        ,
      GG.SalesOrderItem    ,
      GG.Customer,
      GG.Supplier,
     GG.DebitCreditCode
}
where GG.StorageLocation <> ''
