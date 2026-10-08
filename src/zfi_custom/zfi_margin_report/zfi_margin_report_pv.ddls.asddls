@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Margin Analysis Report P View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZFI_MARGIN_REPORT_PV 
provider contract transactional_query
as projection on ZFI_MARGIN_REPORT_RV
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
//TotalTaxAmountINR,
ProfitMargin
}
