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
define view entity ZMM_INV_PGV as select from ZMM_INV_RGP
{


key Material,
key StorageLocation,
key MaterialDocument,
  key MaterialDocumentItem,
   KEY MaterialDocumentYear,
key Plant,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
QuantityInBaseUnit,
MaterialBaseUnit,
//MaterialDocument,
Pos,
CompanyCode,
CompanyCodeCurrency,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
TotalGoodsMvtAmtInCCCrcy,
ProductName,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty30,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt30,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty60,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt60,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty90,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt90,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty120,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt120,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty150,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt150,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty180,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt180,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
Qty365,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt365,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
QtyYear,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
Amt1Year 
}
