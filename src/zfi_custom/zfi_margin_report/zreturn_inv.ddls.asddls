@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Return Order Invoice Process Custom View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZRETURN_INV
  as select from    I_BillingDocument      as _BOH
    inner join      I_BillingDocumentItem  as _BOI   on _BOI.BillingDocument = _BOH.BillingDocument
    left outer join I_CustomerReturnItem   as _CusRI on  _CusRI.CustomerReturn     = _BOI.SalesDocument
                                                     and _CusRI.CustomerReturnItem = _BOI.SalesDocumentItem
    left outer join I_CustomerReturn       as _CusRH on _CusRH.CustomerReturn = _CusRI.CustomerReturn
    left outer join I_DeliveryDocumentItem as _DOI   on  _DOI.ReferenceSDDocument     = _CusRI.CustomerReturn
                                                     and _DOI.ReferenceSDDocumentItem = _CusRI.CustomerReturnItem
    left outer join I_MaterialDocumentItem_2 as _Migo on _Migo.DeliveryDocument = _DOI.DeliveryDocument
                                            and _Migo.DeliveryDocumentItem = _DOI.DeliveryDocumentItem                                                     
{
  key _BOI.BillingDocument,
  key _BOI.BillingDocumentItem,
  key _DOI.DeliveryDocument,
  key _DOI.DeliveryDocumentItem,
      _CusRI.CustomerReturn,
      _CusRI.CustomerReturnItem,
      _BOI.SalesDocumentItemCategory,
      _BOI.SalesEmployee,
      _BOI.ResponsibleEmployee,
      _BOH.BillingDocumentDate,
      _BOH.PayerParty                                 as customer,
      _BOI.Product,
      _BOI.BillingDocumentItemText                    as ItemDescription,
      _BOI.ProfitCenter,
      _BOH.BillingDocumentType,
      _CusRI.ReferenceSDDocument,
      _CusRI.ReferenceSDDocumentItem,
      _Migo.MaterialDocument,
      _Migo.MaterialDocumentItem,
      _Migo.MaterialDocumentYear,
      cast(_Migo.TotalGoodsMvtAmtInCCCrcy as abap.dec( 15, 2 )) as ReturnCogs,
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
  _BOI.SalesDocumentItemCategory = 'RENV';
