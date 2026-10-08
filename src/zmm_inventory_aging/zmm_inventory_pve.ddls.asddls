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
define view entity ZMM_INVENTORY_PVE as select from ZMM_INVENTORY_RE
{
 
  key MaterialDocument,
  key MaterialDocumentItem,
   key MaterialDocumentYear,
   StorageLocation, 
   Plant,
   Material as Material,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
QuantityInBaseUnit,
MaterialBaseUnit,
//@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//TransitQuantity,
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
QtyAbove365,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
AmountAbove365
}
