@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Normal Invoice Process only F2 view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZINVOICE_F2_VIEW
  as select from    ZF2_INVOICE        as _BOI
    left outer join I_Customer               as _cusname on _cusname.Customer = _BOI.PayerParty
    left outer join I_PersonWorkAgreement_1  as _SeName  on _SeName.PersonWorkAgreement = _BOI.SalesEmployee
    left outer join I_PersonWorkAgreement_1  as _ReName  on _ReName.PersonWorkAgreement = _BOI.ResponsibleEmployee
  /// This logic act as Credit note
    left outer join ZCREDIT_INV_G2           as _Credit  on  _Credit.CreditRefNo   = _BOI.BillingDocument
                                                         and _Credit.CreditRefItem = _BOI.BillingDocumentItem

  /// This logic act us Return order with credit memo
    left outer join ZRETURN_INV              as _Return  on  _Return.ReferenceSDDocument     = _BOI.BillingDocument
                                                         and _Return.ReferenceSDDocumentItem = _BOI.BillingDocumentItem

  /// This logic act us Debit note releated information
    left outer join ZDEBIT_INV_L2            as _Debit   on  _Debit.DebittRefNo  = _BOI.BillingDocument
                                                         and _Debit.DebitRefItem = _BOI.BillingDocumentItem
    // this logic act us cogs amount
    left outer join ZMATERIALDOCUMENTITEM as _Migo on _Migo.DeliveryDocument = _BOI.DeliveryDocument
                                                    and _Migo.DeliveryDocumentItem = _BOI.DeliveryDocumentItem
                                                    
    // this logic act us direct sales to billing invoice without delivery
    left outer join ZDIRECT_BILLING as _direct on  _direct.BillingDocument  = _BOI.BillingDocument 
                                                    and _direct.BillingDocumentItem = _BOI.BillingDocumentItem
{
  key _BOI.BillingDocument,
  key _BOI.BillingDocumentItem,
  key _BOI.DeliveryDocument,
  key _BOI.DeliveryDocumentItem,
  key _BOI.SalesOrder,
  key _BOI.SalesOrderItem,
  key _cusname.Customer                                                      as CustomerCode,
      _BOI.SalesEmployee,
      _SeName.PersonFullName                                                 as SalesEmployeeName,
      _BOI.ResponsibleEmployee,
      _ReName.PersonFullName                                                 as ResponsibleEmployeeName,
      _BOI.BillingDocumentDate,
      _BOI.PayerParty                                                        as customer,
      _BOI.Product,
      _BOI.BillingDocumentItemText                                           as ItemDescription,
      _BOI.ProfitCenter,
      _BOI.BillingDocumentType,
      _cusname.BPCustomerFullName,
      _BOI.CreationDate                                                      as SalesOrderDate,
      _BOI.TransactionCurrency                                               as Currency,

      case
          when _Return.ReturnCogs is not initial then (cast(_Migo.DebitAmountInCoCodeCrcy as abap.dec( 15, 2 )) - _Return.ReturnCogs  )
          else cast(_Migo.DebitAmountInCoCodeCrcy as abap.dec( 15, 2 )) end as cogs,          

      //      cast(_Migo.TotalGoodsMvtAmtInCCCrcy as abap.dec( 15, 2 )) as cogs,
      _BOI.BillingQuantity                        as BillingQuantity,
      
      case
      when _Credit.BillingDocumentType = 'G2' and _Debit.BillingDocumentType = 'L2' then
                        cast(cast( cast(_BOI.NetAmountINR as abap.dec( 15, 2 )) - _Credit.NetAmountINR as abap.dec( 15, 2 ) ) + _Debit.NetAmountINR as abap.dec( 15, 2 ) )
      when _Credit.BillingDocumentType = 'G2' then cast( cast(_BOI.NetAmountINR as abap.dec( 15, 2 )) - _Credit.NetAmountINR as abap.dec( 15, 2 ) )
      when  _Debit.BillingDocumentType = 'L2' then cast( cast(_BOI.NetAmountINR as abap.dec( 15, 2 )) + _Debit.NetAmountINR as abap.dec( 15, 2 ) )
      when _Return.SalesDocumentItemCategory = 'RENV' then ( cast(_BOI.NetAmountINR as abap.dec( 15, 2 )) - _Return.NetAmountINR )
      else cast(_BOI.NetAmountINR as abap.dec( 15, 2 )) end                     as NetAmount,

      //      cast(_BOI.NetAmount - _Migo.TotalGoodsMvtAmtInCCCrcy as abap.dec( 15, 2 )) as NetPrfAmount,
      _Credit.BillingDocumentType                                            as CreditDcType,
      _Credit.BillingQuantity                                                as CreditQty,
      _Credit.NetAmountINR                                                      as CreditNetAmount,
      _Return.SalesDocumentItemCategory,
      _Return.BillingQuantity                                                as ReturnQty,
      _Return.ReturnCogs,
      _Return.NetAmountINR                                                      as ReturnNetAmount,
      cast(_Migo.DebitAmountInCoCodeCrcy as abap.dec( 15, 2 )) as testamount,
      _Migo.ReferenceDocument,
      _Migo.ReferenceDocumentItem,
      _direct.SalesOrder as SalesDocu,
      _direct.CreationDate as Salesdate
      
}
where
  _BOI.BillingDocumentType = 'F2'  and
  _BOI.BillingDocumentIsCancelled is initial; 
