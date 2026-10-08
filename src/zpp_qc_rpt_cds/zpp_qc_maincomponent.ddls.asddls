@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Main component'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_QC_MAINCOMPONENT 
as select from I_DeliveryDocumentItem as B
left outer join I_SalesOrderItem                     as SOI     on B.ReferenceSDDocumentItem = SOI.OriginSDDocumentItem
                                                           and B.ReferenceSDDocument = SOI.OriginSDDocument
                                                           and B.Material = SOI.Product 
left outer join I_MaterialDocumentItem_2 as MD on  B.DeliveryDocument = MD.DeliveryDocument
                                       and B.ReferenceSDDocument =MD.SalesOrder
                                       and B.ReferenceSDDocumentItem = MD.SalesOrderItem
inner join I_SalesOrder                         as SO      on SO.SalesOrder = B.ReferenceSDDocument
inner join I_Customer                      as CUS     on SO.SoldToParty = CUS.Customer
inner join I_ProductDescription                 as PROD    on PROD.Product = B.Material                             
inner join  I_SerialNumberDeliveryDocument      as SIRI   on SIRI.DeliveryDocument =B.DeliveryDocument
left outer join zsp_tb    as TABLE             on    TABLE.material   =   SIRI.Material 
                                          and   TABLE.serialnumber = SIRI.SerialNumber
{
  
   
   key B.ReferenceSDDocument        as salesOrder,
   key B.Material                   as Material,
   MD.OrderID                as ProductionID,
   B.DeliveryDocument       as DeliveryDocument,
   B.ReferenceSDDocumentItem,
   PROD.ProductDescription,
   
     @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      B.ActualDeliveredQtyInBaseUnit  as SOQty,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      MD.QuantityInEntryUnit      as ComponentQty,
       @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      MD.QuantityInBaseUnit           as ProductionQty,
      CUS.Customer                as CustomerCode,
      CUS.CustomerName            as CustomerName,
      SO.SoldToParty              as CustomerNumber,
      SO.PurchaseOrderByCustomer  as CustomPOReference,
      SOI.OrderQuantityUnit  as OrderQuantityUnit,
       SIRI.Equipment              as Equipment,
       SIRI.SerialNumber           as SerialNumber,
        TABLE.remarks               as Remarks
}

    
