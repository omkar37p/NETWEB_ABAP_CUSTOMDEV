@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Margin Analysis Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_MARGIN_REPORT_RV
  as select from    ZFI_MARGIN_REPORT                                                                                                         
{
key BillingDocument,
key BillingDocumentItem,
key DeliveryDocument,
key DeliveryDocumentItem,
key SalesOrder,
key SalesOrderItem,
key CustomerCode,
BillingDocumentType,
SalesEmployee,
SalesEmployeeName,
ResponsibleEmployee,
ResponsibleEmployeeName,
BillingDocumentDate,
customer,
Product,
ItemDescription,
ProfitCenter,
BPCustomerFullName,
SalesOrderDate,
cogs,
BillingQuantity,
Currency,
NetAmount,
NetPrfAmount,
//cast(TotalTaxAmountINR as abap.dec( 15, 2 )) as TotalTaxAmountINR,
case when NetPrfAmount is not initial and NetAmount is not initial then
 cast(( NetPrfAmount / NetAmount ) * 100 as abap.dec( 15, 2 )) else null end  as ProfitMargin

}
