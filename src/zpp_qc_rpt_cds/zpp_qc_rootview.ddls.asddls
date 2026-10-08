@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_QC_ROOTVIEW 
as select from  I_MaterialDocumentItem_2 as MD

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
inner join I_SalesOrder                         as SO      on SO.SalesOrder = MO.SalesOrder
inner join I_Customer                      as CUS     on SO.SoldToParty = CUS.Customer
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
{
//  key MD.MaterialDocument as MaterialDocument,
  key MD.ManufacturingOrder          as FinalProductionorder,
  key MD.OrderID                  as Productionorder,
  key case  
      when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '101' ) then '1' 
      when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '261' ) then '1'
      when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '101' ) then '2'
      when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '261' ) then '2'
       
      when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '101' ) then '3' 
      when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '261' or MD.GoodsMovementType = '531' ) then '3' 
      end as level_1,
  key MD.Material                 as Material,
      MO.ManufacturingOrderType   as ManufacturingOrderType,
      MD.GoodsMovementType        as GoodsMovementType,
     
      PROD.ProductDescription     as MaterialDesc,
      MO.SalesOrder               as SalesOrder,
      MO.SalesOrder               as SDSalesOrder,
      MO.SalesOrderItem           as SalesOrderitem,
      
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
      MD.StorageLocation          as StorageLocation,
      SIRI.Equipment              as Equipment,
      SIRI.SerialNumber           as SerialNumber,
      TABLE.remarks               as Remarks,
      MD.DeliveryDocument          as DeliveryNo
      
      
}
//where (MD.GoodsMovementType <> '321')
