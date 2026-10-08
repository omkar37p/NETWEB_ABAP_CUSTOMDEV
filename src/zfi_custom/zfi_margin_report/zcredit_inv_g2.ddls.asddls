@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Credit Invoice Process G2 Custom view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCREDIT_INV_G2
  as select from    I_BillingDocument       as _BOH
    inner join      I_BillingDocumentItem   as _BOI  on _BOI.BillingDocument = _BOH.BillingDocument
    left outer join I_CreditMemoRequestItem as _CREI on  _CREI.CreditMemoRequest     = _BOI.SalesDocument
                                                     and _CREI.CreditMemoRequestItem = _BOI.SalesDocumentItem
    left outer join I_CreditMemoRequest     as _CREH on _CREH.CreditMemoRequest = _CREI.CreditMemoRequest
{
  key _BOI.BillingDocument,
  key _BOI.BillingDocumentItem,
      _BOH.BillingDocumentType,
      _BOH.BillingDocumentDate,
      _BOH.PayerParty                                 as customer,
      _BOI.Product,
      _BOI.BillingDocumentItemText                    as ItemDescription,
      _BOI.ProfitCenter,
      _BOI.ReferenceSDDocument,
      _BOI.ReferenceSDDocumentItem,
      _CREI.ReferenceSDDocument                       as CreditRefNo,
      _CREI.ReferenceSDDocumentItem                   as CreditRefItem,
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
where
      _BOH.BillingDocumentType        = 'G2'
  and _BOH.BillingDocumentIsCancelled is initial;
