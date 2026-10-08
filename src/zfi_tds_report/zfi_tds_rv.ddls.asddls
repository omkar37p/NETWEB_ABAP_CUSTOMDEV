@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_TDS_RV as select from I_JournalEntry                     as JOE
        inner join I_JournalEntryItem   as JOI      on JOI.AccountingDocument = JOE.AccountingDocument
                                                   and JOI.CompanyCode = JOE.CompanyCode
                                                   and JOI.FiscalYear = JOE.FiscalYear
                                                   and JOI.SourceLedger = '0L' 
                                                   and JOI.Ledger = '0L'
        left outer join I_Supplier      as  SUP     on SUP.Supplier = JOI.Supplier 
                                                   and SUP.Customer = JOI.Customer
        left outer join I_GLAccountText as  GLT     on GLT.GLAccount = JOI.GLAccount 
                                                   and GLT.Language = 'E'  
        left outer join I_Withholdingtaxitem as WHT on WHT.AccountingDocument = JOI.AccountingDocument
                                                   and WHT.CompanyCode = JOI.CompanyCode
                                                   and WHT.FiscalYear  = JOI.FiscalYear 
//        left outer join zfi_app01_whty as txc  on txc.taxcode = JOI.TaxCode                                           
     //   left outer join  I_wIthholdingtaxtypetext as dec on dec.WithholdingTaxType = wht.WithholdingTaxType                                                                                                                        
{
   
   key JOI.SourceLedger,
   key JOI.CompanyCode,
   key JOI.FiscalYear,
   key JOI.AccountingDocument,
   key JOI.LedgerGLLineItem,
   key JOI.Ledger,   
  JOE.Branch,                                   
  JOI.GLAccount,
  JOI.DocumentDate,
  JOI.PostingDate,
  JOI.AccountingDocumentType,
  JOI.Supplier,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  WHT.WhldgTaxBaseAmtInTransacCrcy,
  WHT.WithholdingTaxType,
    case
   when 
  WHT.WithholdingTaxType   =  '1H'  
  then' 194H- Brokerage and commission(inv)'
  when WHT.WithholdingTaxType = '3I'  
  then '194I - Rent - Plant & Mach. (inv)'
  when WHT.WithholdingTaxType = '4Q' 
  then  '194Q- Purchase of Goods'
  when WHT.WithholdingTaxType = 'CB'
  then  '194C - contractors - Others (inv)'
   when WHT.WithholdingTaxType = 'I0'
   then   '194I'
  when WHT.WithholdingTaxType = 'I1'  
  then '194IA'
  when WHT.WithholdingTaxType = 'J0'
  then   '194J'
  when WHT.WithholdingTaxType = 'J3'
  then   '194J -2% other than Professional service'
  when WHT.WithholdingTaxType = 'J7'  
  then '194J - Prof/Technical services (inv)'
  when WHT.WithholdingTaxType = 'J8'
  then   '194J -2% other than Professional service'
  when WHT.WithholdingTaxType = 'Y6'
  then   '206C – Tax Collected at Source Invoice'
     
  when WHT.WithholdingTaxType = '3H'  
  then '194H- Brokerage and commission(pmt)'
  when WHT.WithholdingTaxType = '4I'
  then   '194I - Rent - P&M / L & B (pmt)'
  when WHT.WithholdingTaxType = '5Q'
  then   '194Q- Purchase of Goods'
  when WHT.WithholdingTaxType = 'AP'
  then    ' 194 - Other Dividend  (pmt)'
   when WHT.WithholdingTaxType = 'AQ'  
   then  '194A - Intt othr thn on securities (pmt)'
   when WHT.WithholdingTaxType =  'C5' 
   then  '194C'
   when WHT.WithholdingTaxType = 'C7'
   then  '194C - contractors -Indivi/HUF(pmt)'
   when WHT.WithholdingTaxType = 'I5'
   then   '194I'
   when WHT.WithholdingTaxType = 'I6'
   then   '194IA'
   when WHT.WithholdingTaxType = 'J4'
   then   '194J -2% oth than Professional services'
  when WHT.WithholdingTaxType = 'J5' 
  then '194J'
when WHT.WithholdingTaxType = 'J9'
then  '194J -2% other than Professional service'
 when WHT.WithholdingTaxType = 'JA'
 then   '194J - Prof/Technical services (Pmt)'
 else null end as description,
 
  JOE.DocumentReferenceID,
  JOI.TransactionCurrency,
  JOI.IsReversed,
  JOI.IsReversal,
  SUP.SupplierFullName,
  SUP.TaxNumber3,
  JOI.TaxCode,
  SUP.BusinessPartnerPanNumber,
  GLT.GLAccountLongName,
  WHT.WithholdingTaxPercent,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  JOI.AmountInTransactionCurrency
}
