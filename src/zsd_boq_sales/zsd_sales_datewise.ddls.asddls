@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'All Sales Order Date Wise Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }
define view entity ZSD_SALES_DATEWISE with parameters FromDate : abap.dats, ToDate : abap.dats                          //To Get all Sales Order Number based on Input Date Range
as select from I_SalesOrder as SO
{
key SO.SalesOrder
} where SO.SalesOrderDate between $parameters.FromDate and $parameters.ToDate  
