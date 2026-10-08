@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales to direct Billing Invoice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDIRECT_BILLING
  as select from I_BillingDocument     as _BOH
    inner join   I_BillingDocumentItem as _BOI on _BOI.BillingDocument = _BOH.BillingDocument
    inner join   I_SalesOrderItem      as _SOI on  _SOI.SalesOrder     = _BOI.ReferenceSDDocument
                                               and _SOI.SalesOrderItem = _BOI.ReferenceSDDocumentItem
    inner join   I_SalesOrder          as _SOH on _SOH.SalesOrder = _SOI.SalesOrder

{
  key _BOI.BillingDocument,
  key _BOI.BillingDocumentItem,
      _SOI.SalesOrder,
      _SOI.SalesOrderItem,
      _SOI.CreationDate,
      _BOI.Product
}
