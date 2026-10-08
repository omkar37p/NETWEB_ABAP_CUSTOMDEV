
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Final CDS For Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

 define root view entity ZPP_QC_PROJECTIONVIEW
  provider contract transactional_query
  as projection on ZPP_QC_ROOTVIEW
{
    key FinalProductionorder,
    key Productionorder,
    key level_1,
    key Material,

    GoodsMovementType,
    MaterialDesc,
    SalesOrder,
    SDSalesOrder,
    OrderQuantityUnit,

    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    ProductionQty,

    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    SOQty,

    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    ComponentQty,

    CustomerCode,
    CustomerName,
    CustomerNumber,
    CustomPOReference,
    StorageLocation,
    Equipment,
    SerialNumber
}
    
