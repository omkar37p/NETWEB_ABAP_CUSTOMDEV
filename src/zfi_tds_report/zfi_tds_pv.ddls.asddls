@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZFI_TDS_PV as select from ZFI_TDS_RV
{

key SourceLedger,
key CompanyCode,
key FiscalYear,
key AccountingDocument,
key LedgerGLLineItem,
key Ledger,
Branch,
GLAccount,
DocumentDate,
PostingDate,
AccountingDocumentType,
Supplier,
@Semantics.amount.currencyCode: 'TransactionCurrency'
WhldgTaxBaseAmtInTransacCrcy,
WithholdingTaxType,
description,
DocumentReferenceID,
TransactionCurrency,
IsReversed,
IsReversal,
SupplierFullName,
TaxNumber3,
BusinessPartnerPanNumber,
GLAccountLongName,
WithholdingTaxPercent,
@Semantics.amount.currencyCode: 'TransactionCurrency'
AmountInTransactionCurrency

}
