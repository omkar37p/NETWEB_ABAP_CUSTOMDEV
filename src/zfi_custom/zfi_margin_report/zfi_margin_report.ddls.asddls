@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overall Consolidated Margin Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_MARGIN_REPORT
  as select from ZINVOICE_F2_VIEW
{
  key BillingDocument,
  key BillingDocumentItem,
  key DeliveryDocument,
  key DeliveryDocumentItem,
  key SalesOrder,
  key SalesOrderItem,
  key CustomerCode,
      SalesEmployee,
      SalesEmployeeName,
      ResponsibleEmployee,
      ResponsibleEmployeeName,
      BillingDocumentDate,
      customer,
      Product,
      ItemDescription,
      ProfitCenter,
      BillingDocumentType,
      BPCustomerFullName,
      SalesOrderDate,
      cogs,
      BillingQuantity,
//      TotalTaxAmountINR,
      cast(NetAmount as abap.dec( 15, 2 )) as NetAmount,
      Currency,
      cast(coalesce(NetAmount,0) - coalesce(cogs,0) as abap.dec(15,2) ) as NetPrfAmount ,     
      CreditDcType,
      CreditQty,
      CreditNetAmount,
      SalesDocu,
      Salesdate
}
