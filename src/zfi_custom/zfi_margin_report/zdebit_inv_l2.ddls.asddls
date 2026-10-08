@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Debit Invoice Process L2 Custom View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDEBIT_INV_L2 as select from    I_BillingDocument      as _BOH
    inner join      I_BillingDocumentItem  as _BOI on _BOI.BillingDocument = _BOH.BillingDocument
    left outer join I_DebitMemoRequestItem as _DEBI on _DEBI.DebitMemoRequest = _BOI.SalesDocument
                    and _DEBI.DebitMemoRequestItem = _BOI.SalesDocumentItem
    left outer join I_DebitMemoRequest as _DEBH on _DEBH.DebitMemoRequest = _DEBI.DebitMemoRequest
{
    key _BOI.BillingDocument,
    key _BOI.BillingDocumentItem,
    _BOH.BillingDocumentType,
      _BOH.BillingDocumentDate,
      _BOH.PayerParty as customer ,
      _BOI.Product,
      _BOI.BillingDocumentItemText                    as ItemDescription,
      _BOI.ProfitCenter,
      _BOI.ReferenceSDDocument,
      _BOI.ReferenceSDDocumentItem,
      _DEBI.ReferenceSDDocument as DebittRefNo,
      _DEBI.ReferenceSDDocumentItem as DebitRefItem,
      cast(_BOI.BillingQuantity as abap.dec( 9, 3 ) ) as BillingQuantity,
      cast(_BOI.NetAmount as abap.dec( 15, 2 ))       as NetAmount,
      _BOI.TransactionCurrency,
      _BOH.AccountingExchangeRate                     as ExchangeRate,
      case
           when _BOI.TransactionCurrency = 'INR'
                   then cast(_BOI.NetAmount as abap.dec( 15, 2 ))
           when _BOH.BillingDocumentDate >= '20240401' and _BOH.BillingDocumentDate <= '20250526'
                   then cast(cast(_BOI.NetAmount as abap.dec( 15, 2 )) * cast(_BOH.AccountingExchangeRate * 100 as abap.dec( 15, 2 )) as abap.dec( 15, 2 ))
           when _BOH.BillingDocumentDate >= '20250527'
                   then cast(_BOI.NetAmount as abap.dec( 15,2 )) * cast(_BOH.AccountingExchangeRate as abap.dec( 15,2 ))
           else null end                              as NetAmountINR
            

}
where _BOH.BillingDocumentType = 'L2' and
      _BOH.BillingDocumentIsCancelled is initial;
