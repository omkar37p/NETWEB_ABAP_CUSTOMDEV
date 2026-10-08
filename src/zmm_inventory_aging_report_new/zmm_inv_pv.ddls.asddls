@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invenory Aging Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZMM_INV_PV as select from ZMM_INV_RV
{
//key MaterialDocument,
//key Material,
key plant
//CompanyCode,
//MaterialGroup,
//MaterialDescription,
////MaterialDocument,
////MaterialPostingDate,
//UOM,
//@Semantics.quantity.unitOfMeasure: 'uom'
//TotalQuantity,
//currency,
//@Semantics.amount.currencyCode: 'currency'
//AMTcompanycodecurrency,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty30,
//@Semantics.amount.currencyCode: 'currency'
//Amt30,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty60,
//@Semantics.amount.currencyCode: 'currency'
//Amt60,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty90,
//@Semantics.amount.currencyCode: 'currency'
//Amt90,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty120,
//@Semantics.amount.currencyCode: 'currency'
//Amt120,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty150,
//@Semantics.amount.currencyCode: 'currency'
//Amt150,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty180,
//@Semantics.amount.currencyCode: 'currency'
//Amt180,
//@Semantics.quantity.unitOfMeasure: 'uom'
//Qty365,
//@Semantics.amount.currencyCode: 'currency'
//Amt365,
//@Semantics.quantity.unitOfMeasure: 'uom'
//QtyYear,
//@Semantics.amount.currencyCode: 'currency'
//Amt1Year  
}
