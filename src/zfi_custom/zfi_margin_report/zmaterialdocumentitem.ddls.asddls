@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Document Item View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIALDOCUMENTITEM
  as select from I_MaterialDocumentItem_2 as _Migo
    left outer join I_AccountingDocumentJournal( P_Language:'E' ) as _joi on   _Migo.MaterialDocumentYear = _joi.FiscalYear 
                                                    and   _Migo.MaterialDocument  = _joi.ReferenceDocument 
                                                    and   _Migo.MaterialDocumentItem = substring(_joi.ReferenceDocumentItem,3,4)
                                                    and   _joi.Ledger = '0L'
                                                    and   _joi.GLAccountType = 'P'
//                                                    and   _joi.ReversalReferenceDocument is initial  
{
  key _Migo.MaterialDocumentYear,
  key _Migo.MaterialDocument,
  key _Migo.MaterialDocumentItem,
      _Migo.Plant,
      _Migo.GoodsMovementType,
      _Migo.DebitCreditCode,
      cast(_Migo.TotalGoodsMvtAmtInCCCrcy as abap.dec( 13, 2 )) as TotalGoodsMvtAmtInCCCrcy,
      _Migo.CompanyCodeCurrency,
      _Migo.DeliveryDocument,
      _Migo.DeliveryDocumentItem,
      cast(_joi.DebitAmountInCoCodeCrcy as abap.dec( 13, 2 )) as DebitAmountInCoCodeCrcy,
      _joi.IsReversed,
      _joi.IsReversal,
      _joi.ReversalReferenceDocument,
      _joi.ReversalReferenceDocumentCntxt,
      _joi.ReferenceDocument,
      _joi.ReferenceDocumentItem,
      _joi.ReferenceDocumentContext
}
where _joi.ReversalReferenceDocument is initial;
