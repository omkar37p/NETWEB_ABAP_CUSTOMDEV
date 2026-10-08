@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }
define view entity ZSD_SALES_RV with parameters SalesONumber : abap.char( 10 )                                          //Input Parameter Sales Order 
as select from I_SalesOrderCube( P_ExchangeRateType:'M' , P_DisplayCurrency:'USD'  )    as SOC                          //Sales Header Details
inner join I_SalesOrderItemCube( P_ExchangeRateType:'M', P_DisplayCurrency:'USD' )      as SOCI on SOCI.SalesOrder = SOC.SalesOrder //Sales Item Details
                                                                                                and SOCI.SalesOrderType = SOC.SalesOrderType
left outer join I_SalesOrder                as SO   on SO.SalesOrder = SOC.SalesOrder                                   //Sales Header Details
left outer join I_SalesOrderItem            as SOI  on SOI.SalesOrder = SOCI.SalesOrder                                 //Sales Item Details
                                                        and SOI.SalesOrderItem = SOCI.SalesOrderItem
left outer join I_Product                   as P    on P.Product = SOCI.Product                                         //To Get Material Type
left outer join I_ProductDescription        as PD   on PD.Product = SOCI.Product                                        //To Get Material Description
                                                        and PD.Language = 'E'                           
//left outer join I_SalesOrderScheduleLine    as SOSL on SOSL.SalesOrder = SOC.SalesOrder   //No Need                              //To Get Schedule Lines of Sales Order
//                                                        and SOSL.SalesOrderItem = SOCI.SalesOrderItem
//                                                        and SOSL.IsRequestedDelivSchedLine = 'X'
left outer join I_SalesOrderPartner         as SOP  on SOP.SalesOrder = SOC.SalesOrder                                  //To Get Sales Person
                                                        and SOP.PartnerFunction = 'ZM'            
left outer join I_SalesOrderPartner         as SOP2 on SOP2.SalesOrder = SOC.SalesOrder                                 //To Get Sold-to-Party
                                                        and SOP2.PartnerFunction = 'AG'         
left outer join I_SalesOrderPartner         as SOP3 on SOP3.SalesOrder = SOC.SalesOrder                                 //To Get Sales Head
                                                        and SOP3.PartnerFunction = 'VE'                                 
left outer join I_OrderRelatedBillingStatusT as SOS on SOS.OrderRelatedBillingStatus = SOCI.OverallSDProcessStatus and SOS.Language = 'E'       //To Get Sales Status
left outer join I_OrderRelatedBillingStatusT as SOS2 on SOS2.OrderRelatedBillingStatus = SOC.OverallOrdReltdBillgStatus and SOS2.Language = 'E' //To Get Billing Status
{
key SOC.SalesOrder                      as SalesOrderNumber,
key SOCI.SalesOrderItem                 as SalesOrderItem,
//key SOSL.ScheduleLine                   as ScheduleLine,      //No Need
    SOS.OrderRelatedBillingStatusDesc   as SOStatus,
    SOC.SalesOrderDate                  as SODate,
//    SOSL.RequestedDeliveryDate          as DeliveryDate,      //No Need
//    SOI.CommittedDeliveryDate           as DeliveryDate,      ""Logic changed to header cds
    SO.RequestedDeliveryDate            as DeliveryDate,
    SOCI.Product                        as FGNo,
    P.ProductType                       as FGType,
    PD.ProductDescription               as FGDescription,
    SOCI.Plant                          as Plant,
    SOCI.OrderQuantityUnit              as SOUnit,
//    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
//    SOSL.OpenReqdDelivQtyInOrdQtyUnit   as OpenQuantity,      //No Need
//    SOSL.ScheduleLineCategory           as ScheduleCategory,  //No Need
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    SOCI.OrderQuantity                  as OrderQuantity,
    SOP.FullName                        as SalesPerson,
    SOP2.FullName                       as CustomerName, 
    SOP3.FullName                       as SalesHead,
    SO.YY1_SalesArea_SDH                as BranchName,
    SOS2.OrderRelatedBillingStatusDesc  as BillStatus
} where SOC.SalesOrder = lpad( $parameters.SalesONumber, 10, '0' )                                                  //Sales Order Details based on Input SO Number
