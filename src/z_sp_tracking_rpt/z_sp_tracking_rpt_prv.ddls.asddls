@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Final CDS For Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
}
define root view entity Z_SP_TRACKING_RPT_PRV 
provider contract transactional_query
as projection on Z_SP_TRACKING
{
  //  key FinalProductionorder,
 // @ObjectModel.text.element: [ 'salesordermaterial' ]
    key Productionorder,
    key materialdocument,
    key level_1,
  //  @ObjectModel.text.element: [ 'Productionorder' ]
   
    key Material,
    
     @Consumption.valueHelpDefinition: [{    
        entity: {
            name: 'Z_SP_MATERIAL',
            element: 'Material'
        }   ,
        
         additionalBinding: [{
             element: 'MaterialDesc',
             usage: #FILTER
         }]
     
    }]
    @Search.fuzzinessThreshold: 0.9
    key MainMaterial,
 //   MainMaterial,
    GoodsMovementType,
    MaterialDesc,
    SalesOrder,
    SDSalesOrder,
    OrderQuantityUnit,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    ProductionQty,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    SOQty,
    SalesOrderitem,
    salesordermaterial,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    ComponentQty,
    CustomerCode,
    CustomerName,
    CustomerNumber,
    CustomPOReference,
    StandardWarranty,
    StorageLocation,
    Equipment,
    SerialNumber,
    pws_bdld,
    cse_bdld,
    mbd_bdld,
    heatsink_bdld,
    ipmi,
    macaddress,
    DeliveryNo
    
}
