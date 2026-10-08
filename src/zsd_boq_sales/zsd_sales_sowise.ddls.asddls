@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'All Sales Order SO Number Wise Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }
define view entity ZSD_SALES_SOWISE with parameters SalesONumber : abap.char( 10 )                                  //To Get all Sales Order Number based on input SO Number
as select from I_SalesOrder as SO
{
    key SO.SalesOrder
} where SO.SalesOrder = lpad( $parameters.SalesONumber, 10, '0')
