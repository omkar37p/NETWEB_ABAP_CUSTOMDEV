@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Sales Report RV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata: { allowExtensions: true }
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }
define view entity ZSD_BOQ_REPORT with parameters                                                                       //For Projecting Report to Screen 
@EndUserText: { label: 'Enter From Date' }  
FromDate : erdat,
@EndUserText: { label: 'Enter To Date' } 
ToDate : erdat,
@EndUserText: { label: 'Sales Order Number' }
//@Consumption.valueHelpDefinition: [ { entity: { name: 'ZPBOQ_VH_SO', element: 'SalesOrder' } }]
@Consumption: { defaultValue: 'N/A' }                    
SalesONumber : vbeln_va
as select from ZSD_BOQ_FUNCTION( FromDate: $parameters.FromDate , ToDate: $parameters.ToDate , SalesONumber : $parameters.SalesONumber )
{
  key SalesOrderNumber,
  key SalesOrderItem,
//  key ScheduleLine,           //No Need
  key ItemLevel01,
  key ItemLevel02,
  key ItemLevel03,
      SalesOrderStatus,
      CustomerName,
      SalesDate,
      DeliveryDate,
//      ScheduleCategory,       //No Need
      FGNumber,
      FGName,
      FGBaseQty,
      FGQty,
//      ScheduleQuantity,       //No Need
      SFGVariant,
      SFGNumber,
      SFGName,
      SFGBaseQty,
      SFGQty,
      KITBOQVariant,
      KITBOQ,
      KITBOQName,
      KITBOQQty,
      SalesHead,
      SalesPerson,
      BranchName,
      BillStatus
}
