@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROOT VIEW'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity Z_SP_TRACKING 
as select from I_MaterialDocumentItem_2 as MD

//Z_SP_TRACKING_main_com            as DELIVERY
//left outer join I_MaterialDocumentItem_2         as MD on MD.Material = DELIVERY.Material
//                                                       and MD.SalesOrder =DELIVERY.salesOrder
//                                                       and MD.DeliveryDocument= DELIVERY.DeliveryDocument
//                                                       and MD.SalesOrderItem =DELIVERY.ReferenceSDDocumentItem
//inner join I_ManufacturingOrder       as MAIN  on  MAIN.ManufacturingOrder = MD1.OrderID
//                                                  and MAIN.ManufacturingOrderType = 'YBM1'
//                                                  
//inner join I_MaterialDocumentItem_2       as MD  on  MAIN.ManufacturingOrder = MD1.OrderID
//                                                  and MD.GoodsMovementType = '261'
//                                                 and MD.GoodsMovementType = '101' 
//                                                 and MD.GoodsMovementType = '531'
                                                                                                    
                                                  
inner  join I_ManufacturingOrder           as MO      on MO.ManufacturingOrder = MD.OrderID
left outer join I_SalesOrderItem                     as SOI     on MO.SalesOrderItem = SOI.OriginSDDocumentItem
                                                           and MO.SalesOrder = SOI.OriginSDDocument
                                                           and MO.Material = SOI.Product 
left outer join I_SalesOrder                         as SO      on SO.SalesOrder = MO.SalesOrder
left outer join I_Customer                      as CUS     on SO.SoldToParty = CUS.Customer
//inner join Z_SP_TRACKING_main_com               as MAIN   // on MAIN.ProductionID = MD.OrderID
//                                                           on MAIN.Salesorder = MD.SalesOrder
                                                   
inner join I_ProductDescription                 as PROD    on PROD.Product = MD.Material
inner join I_SerialNumberMaterialDoc_2           as SIRI    on SIRI.Material = MD.Material
                                                            and SIRI.MaterialDocument = MD.MaterialDocument
                                                            and SIRI.MaterialDocumentItem = MD.MaterialDocumentItem
// left outer join Z_SP_TRACKING_main_com            as DELIVERY   on DELIVERY.salesOrder = MO.SalesOrder
//                                                          //  and DELIVERY.ReferenceSDDocumentItem = MO.SalesOrderItem 
//                                                            and DELIVERY.DeliveryDocument = MO.DeliveryDocument                                                         

left outer join zsp_tb    as TABLE             on    TABLE.material   =   SIRI.Material 
                                          and   TABLE.serialnumber = SIRI.SerialNumber                                             
// left outer join YY1_SERIALNUMBEROUTBOUNDDE            as YYSO on YYSO.SalesOrder = SO.SalesOrder 
 left outer join I_ProductionOrderItem          as PROI   //  on PROI.Product = MD.Material 
                                                            on PROI.ProductionOrder = MD.OrderID                                                  
{
//  key MD.MaterialDocument as MaterialDocument,
//  key MD.OrderID          as FinalProductionorder,
  key MD.OrderID                  as Productionorder,
  key MD.MaterialDocument         as materialdocument,
  key case  
      when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '101' ) then '1' 
      when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '261' ) then '1'
      when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '101' ) then '2'
      when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '261' ) then '2'
       
      when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '101' ) then '3' 
      when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '261' or MD.GoodsMovementType = '531' ) then '3' 
      end as level_1,
  key MD.Material                 as Material,
  
   key   PROI.Product                as MainMaterial,
      
      MO.ManufacturingOrderType   as ManufacturingOrderType,
      MD.GoodsMovementType        as GoodsMovementType,
     
      PROD.ProductDescription     as MaterialDesc,
      MO.SalesOrder               as SalesOrder,
      MO.SalesOrder               as SDSalesOrder,
      MO.SalesOrderItem           as SalesOrderitem,
      SOI.Material                as salesordermaterial,
      
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      SOI.OrderQuantity  as SOQty,
      
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      MD.QuantityInEntryUnit      as ComponentQty,
      
      SOI.OrderQuantityUnit  as OrderQuantityUnit,
      
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      MD.QuantityInBaseUnit           as ProductionQty,
      
      CUS.Customer                as CustomerCode,
      CUS.CustomerName            as CustomerName,
      SO.SoldToParty              as CustomerNumber,
      SO.PurchaseOrderByCustomer  as CustomPOReference,
      SO.YY1_StandardWarrantyi1_SDH as StandardWarranty,
      MD.StorageLocation          as StorageLocation,
      SIRI.Equipment              as Equipment,
      SIRI.SerialNumber           as SerialNumber,
      TABLE.pws_bdld              as pws_bdld,
      TABLE.cse_bdld              as cse_bdld,
      TABLE.mbd_bdld               as mbd_bdld,
      TABLE.heatsink_bdld          as heatsink_bdld,
      TABLE.ipmi                   as ipmi,
      TABLE.macaddress             as macaddress,
      MD.DeliveryDocument          as DeliveryNo
      
      
}
where (MD.GoodsMovementType <> '321')
