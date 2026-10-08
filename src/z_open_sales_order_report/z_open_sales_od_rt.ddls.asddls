@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_OPEN_SALES_OD_RT 
as select from I_SalesOrderItem             as SOI
left outer join I_SalesOrder                as SO             on SO.SalesOrder = SOI.SalesOrder
                                                     
left outer join I_SalesOrderScheduleLine    as SOSL    on SOSL.SalesOrder = SOI.SalesOrder
                                                       and SOSL.SalesOrderItem = SOI.SalesOrderItem
left outer join I_SalesDocumentItem         as SDI     on SDI.SalesDocument = SOI.SalesOrder
                                                       and SDI.SalesDocumentItem = SOI.SalesOrderItem
                                                       and SDI.Material = SOI.Material                                                    

{
key SOSL.SalesOrder                     as SalesDocument,
key SOSL.SalesOrderItem                 as SalesDocumentItem,
key SOI.Material                        as Material,
    SOI.SalesOrderItemText              as Materialdesc,
    SOSL.BaseUnit                       as BASEUNIT,
    @Semantics.quantity.unitOfMeasure:'BASEUNIT'
    SOSL.ConfdOrderQtyByMatlAvailCheck  as orderqty,
    @Semantics.quantity.unitOfMeasure:'BASEUNIT'
    SOSL.DeliveredQtyInOrderQtyUnit     as PartiallyCompletedQuantity,
    @Semantics.quantity.unitOfMeasure:'BASEUNIT'
    SOSL.OpenConfdDelivQtyInOrdQtyUnit  as OpeNforDeliveryQuantity,
    SDI.SoldToParty                     as SoldToParty,
    SDI.PurchaseOrderByCustomer         as CustomerReference,
    SO.SalesOrderDate                   as Documentdate,
    SDI.SalesDocumentType               as SalesDocumentType
    
}
