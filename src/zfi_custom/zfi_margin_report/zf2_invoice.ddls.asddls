@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Normal F2 Invoice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZF2_INVOICE
  as select from    I_BillingDocument      as _BOH
    inner join      I_BillingDocumentItem  as _BOI on _BOI.BillingDocument = _BOH.BillingDocument
    left outer join I_DeliveryDocumentItem as _DOI on  _DOI.DeliveryDocument     = _BOI.ReferenceSDDocument
                                                   and _DOI.DeliveryDocumentItem = _BOI.ReferenceSDDocumentItem
    left outer join I_DeliveryDocument     as _DOH on _DOH.DeliveryDocument = _DOI.DeliveryDocument
    left outer join I_SalesOrderItem       as _SOI on  _SOI.SalesOrder     = _BOI.SalesDocument
                                                   and _SOI.SalesOrderItem = _BOI.SalesDocumentItem
    left outer join I_SalesOrder           as _SOH on _SOH.SalesOrder = _SOI.SalesOrder
{
  key _BOI.BillingDocument,
  key _BOI.BillingDocumentItem,
  key _DOI.DeliveryDocument,
  key _DOI.DeliveryDocumentItem,
  key _SOI.SalesOrder,
  key _SOI.SalesOrderItem,
      _BOI.ReferenceSDDocument,
      _BOI.ReferenceSDDocumentItem,
      _BOI.SalesEmployee,
      _BOI.ResponsibleEmployee,
      _BOH.BillingDocumentDate,
      _BOH.PayerParty,
      _BOI.Product,
      _BOI.BillingDocumentItemText,
      _BOI.ProfitCenter,
      _BOH.BillingDocumentType,
      _SOI.CreationDate,
      _BOH.BillingDocumentIsCancelled,
      cast(_BOI.BillingQuantity as abap.dec( 9, 3 ) ) as BillingQuantity,
      cast(_BOI.NetAmount as abap.dec( 15, 2 )) as Netamount,
      case
            when _BOI.TransactionCurrency = 'USD' then 'INR'
            else _BOI.TransactionCurrency end as TransactionCurrency,
//      _BOI.TransactionCurrency     ,
      _BOH.AccountingExchangeRate  ,
      case
           when _BOI.TransactionCurrency = 'INR'
                   then cast(_BOI.NetAmount as abap.dec( 15, 2 ))
           when _BOH.BillingDocumentDate >= '20240401' and _BOH.BillingDocumentDate <= '20250526'
                   then cast(cast(_BOI.NetAmount as abap.dec( 15, 2 )) * cast(_BOH.AccountingExchangeRate * 100 as abap.dec( 15, 2 )) as abap.dec( 15, 2 ))
           when _BOH.BillingDocumentDate >= '20250527'
                   then cast(_BOI.NetAmount as abap.dec( 15,2 )) * cast(_BOH.AccountingExchangeRate as abap.dec( 15,2 ))
           else null end           as NetAmountINR


}
where
      _BOH.BillingDocumentType        = 'F2'
  and _BOH.BillingDocumentIsCancelled is initial;
