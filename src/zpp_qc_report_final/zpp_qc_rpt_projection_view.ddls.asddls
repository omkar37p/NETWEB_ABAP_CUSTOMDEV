@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED

}
define  root view entity ZPP_QC_RPT_PROJECTION_VIEW 
provider contract transactional_query
as projection on ZPP_QC_RPT_ROOTVIEW
{
   key        ProductionOrder,
  key        level_1,
  key        InspectionLot,
  key        material1,
  key        SerialNumber1,
  key        CharacteristicAttributeCode1,

  key        GoodsMovementType,
  key        Material,
  key        MaterialDocument, 
//  KEY    InspectionSpecification,
//      InspectionSpecificationText, 
//  InspectionSpecificationText  as LONGTEXT,
            SalesOrder,
            
             MaterialDesc,
             
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
             InspectionSpecification as MIC,
             InspectionSpecificationText ,
             InspectionCodeText as MIC_RESULT,
             InspectionResultText as Inspection_Desc,
             StandardWarranty,
             StorageLocation,
             Equipment,
             SerialNumber,
             IPMIUSERPASSWORD,

             KEYS,
             VERSION,
             OS,
            remarks  
}
