@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Single Sales Order Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOQ_RV as select from I_SalesOrderCube( P_ExchangeRateType:'M' , P_DisplayCurrency:'USD'  ) as SOC
inner join I_SalesOrderItemCube( P_ExchangeRateType:'M', P_DisplayCurrency:'USD' ) as SOCI on SOCI.SalesOrder = SOC.SalesOrder
                                                                                                and SOCI.SalesOrderType = SOC.SalesOrderType
left outer join I_SalesOrderScheduleLine as SOSL on SOSL.SalesOrder = SOCI.SalesOrder and SOSL.SalesOrderItem = SOCI.SalesOrderItem
left outer join I_SalesOrder as SO on SO.SalesOrder = SOC.SalesOrder
left outer join I_SalesOrderItem as SOI on SOI.SalesOrder = SOCI.SalesOrder and SOI.SalesOrderItem = SOCI.SalesOrderItem
left outer join I_SalesOrderPartner as SOP on SOP.SalesOrder = SOC.SalesOrder and SOP.PartnerFunction = 'ZM'            //To Get Sales Head
left outer join I_SalesOrderPartner as SOP2 on SOP2.SalesOrder = SOC.SalesOrder and SOP2.PartnerFunction = 'AG'         //To Get Sold-to-Party
left outer join I_OrderRelatedBillingStatusT as SOS on SOS.OrderRelatedBillingStatus = SOCI.OverallSDProcessStatus and SOS.Language = 'E'
left outer join I_OrderRelatedBillingStatusT as SOS2 on SOS2.OrderRelatedBillingStatus = SOC.OverallOrdReltdBillgStatus and SOS2.Language = 'E'
left outer join I_ProductDescription as PD on PD.Product = SOCI.Product and PD.Language = 'E'                           //To Get FG Description
left outer join I_MaterialBOMLink as MBL on MBL.Material = SOCI.Product and MBL.Plant = SOCI.Plant                      //To Get BOM of FG Material
left outer join I_BillOfMaterialItemBasic as BOMI on BOMI.BillOfMaterial = MBL.BillOfMaterial                           //To Get SFG of FG Material
                                                     and BOMI.BillOfMaterialCategory = MBL.BillOfMaterialCategory
left outer join I_ProductDescription as PD2 on PD2.Product = BOMI.BillOfMaterialComponent and PD.Language = 'E'         //To Get SFG Description                                             
left outer join I_MaterialBOMLink as MBL2 on MBL2.Material = BOMI.BillOfMaterialComponent and MBL2.Plant = SOCI.Plant   //To Get BOM of SFG Material
left outer join I_BillOfMaterialItemBasic as BOMI2 on BOMI2.BillOfMaterial = MBL2.BillOfMaterial                        //To Get RAW of SFG Material
                                                     and BOMI2.BillOfMaterialCategory = MBL2.BillOfMaterialCategory    
left outer join I_ProductDescription as PD3 on PD3.Product = BOMI2.BillOfMaterialComponent and PD.Language = 'E'        //To Get RAW Material Decription                                                                                                                       
{
key SOC.SalesOrder as SalesOrder,
key SOCI.SalesOrderItem as SalesOrderItem,
key SOSL.ScheduleLine  as ScheduleLine,
    SOS.OrderRelatedBillingStatusDesc as SOStatus,
    SOP2.FullName as CustomerName,
    SOC.SalesOrderDate as SODate,
    SOSL.DeliveryDate as DeliveryDate,
    SOCI.Product as FGNo,
    PD.ProductDescription as FGDescription,
    BOMI.BillOfMaterialComponent as SFGNo,
    PD2.ProductDescription as SFGDescription,
    SOSL.OrderQuantityUnit as SOUnit,
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    SOSL.ScheduleLineOrderQuantity as OrderQuantity,
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    SOCI.OrderQuantity as TotalOrderQuantity,
    BOMI2.BillOfMaterialComponent as KITBOQ,
    PD3.ProductDescription as KITBOQName,
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    cast(SOCI.OrderQuantity as abap.dec( 15, 3 ) ) * cast(BOMI2.BillOfMaterialItemQuantity as abap.dec( 15, 3 ) ) as BOQQty,
    SOP.FullName as SalesHead,
    SO.YY1_SalesArea_SDH as BranchName,
    SOS2.OrderRelatedBillingStatusDesc as BillStatus,            //Temporary given after confirmation need to change
    BOMI.BillOfMaterialComponent as SFGNo1    
}

group by SOC.SalesOrder , SOCI.SalesOrderItem , SOSL.ScheduleLine , SOS.OrderRelatedBillingStatusDesc , SOP2.FullName , SOC.SalesOrderDate, SOSL.DeliveryDate,SOCI.Product,PD.ProductDescription,
BOMI.BillOfMaterialComponent,PD2.ProductDescription,SOSL.OrderQuantityUnit,SOSL.ScheduleLineOrderQuantity,SOCI.OrderQuantity,BOMI2.BillOfMaterialComponent,PD3.ProductDescription,SOCI.OrderQuantity,
BOMI2.BillOfMaterialItemQuantity,SOP.FullName,SO.YY1_SalesArea_SDH,SOS2.OrderRelatedBillingStatusDesc,BOMI.BillOfMaterialComponent
