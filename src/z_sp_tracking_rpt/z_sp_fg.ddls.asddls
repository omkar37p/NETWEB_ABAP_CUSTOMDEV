@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROOT VIEW'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity Z_SP_FG
// as select from I_ManufacturingOrder as MO  
 as select distinct from I_ManufacturingOrder as MO
// as select from I_MaterialDocumentItem_2    as MD 
// on MD.OrderID =   MO.ManufacturingOrder 
//                                               and  MD.ManufacturingOrderItem = MO.ManufacturingOrderItem 
//                                             and  MD.GoodsMovementType = '101'and MD.GoodsMovementType = '261'
                                             
 
// left outer  join  I_MfgOrderForExtraction   as MFG    on MFG.ManufacturingOrder = MD.OrderID
//////                                                and MD.Plant   = MFG.PlanningPlant
//                                                     and MFG.ManufacturingOrderType = 'YBM1'
//right outer join  I_ManufacturingOrder           as MO      on MO.ManufacturingOrder = MD.OrderID
//                                                      and MO.ManufacturingOrderItem = MD.ManufacturingOrderItem
//                                                      and MO.ManufacturingOrderType ='YBM1'

//inner  join  I_MaterialDocumentItem_2  as MD1    on MD1.OrderID = MD.OrderID
//                                                     and MD1.GoodsMovementType = '101'and MD.GoodsMovementType = '261'
//                                                
inner join I_SerialNumberMaterialDoc_2    as SN  on SN.Material = MO.Material
//                                                      and SN.MaterialDocument = MO.MaterialDocument
left outer  join I_SerialNumberManufacturingOrd as SNF on SNF.SerialNumber = SN.SerialNumber

//left outer join I_SalesOrderItem                     as SOI     on MO.SalesOrderItem = SOI.OriginSDDocumentItem
//                                                           and MO.SalesOrder = SOI.OriginSDDocument
//                                                           and MO.Material = SOI.Product 
//inner join I_SalesOrder                         as SO      on SO.SalesOrder = MO.SalesOrder
//inner join I_Customer                      as CUS     on SO.SoldToParty = CUS.Customer
////inner join Z_SP_TRACKING_main_com               as MAIN   // on MAIN.ProductionID = MD.OrderID
////                                                           on MAIN.Salesorder = MD.SalesOrder
//                                                   
//inner join I_ProductDescription                 as PROD    on PROD.Product = MD.Material
//inner join I_SerialNumberMaterialDoc_2           as SIRI    on SIRI.Material = MD.Material
//                                                            and SIRI.MaterialDocument = MD.MaterialDocument
//                                                            and SIRI.MaterialDocumentItem = MD.MaterialDocumentItem
// left outer join Z_SP_TRACKING_main_com            as DELIVERY   on DELIVERY.salesOrder = MO.SalesOrder
//                                                          //  and DELIVERY.ReferenceSDDocumentItem = MO.SalesOrderItem 
//left outer  join  I_MfgOrderForExtraction as MFG1 on                                             
                                             
{
   key MO.ManufacturingOrder as Finalproduct,
   key SNF.ManufacturingOrder as ProductionOrder,
   SN.MaterialDocument,
//   MD.GoodsMovementType,
   SN.SerialNumber,
      MO.Material,
//      MD.MaterialDocument,
//      MD.GoodsMovementType
   MO.SalesOrder               as SalesOrder
}

where  MO.ManufacturingOrderType ='YBM1'
//where  MD.GoodsMovementType =  '261'
//or MD.GoodsMovementType = '261'
//group by MO.ManufacturingOrder,MD.Material,MD.MaterialDocument
