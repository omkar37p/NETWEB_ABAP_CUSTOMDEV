@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PurchaseOrderETA Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PurchaseorderETA_PV
 provider contract transactional_query as projection on ZMM_PurchaseorderETA_RE
{
    key PONo,
    key POLineItem,
    key SONo,
    
    ETADate1,
    Remark1,
   CustomerCode1,
   CustomerName1,
////    //SONo,
    Material,
    Baseunit,
    ProductDesc,
    TaxCode,
    PODoctype,
    PODocdate,
    BranchName1,
    SOdate1,
    EDD1,
    @Semantics.quantity.unitOfMeasure: 'Baseunit'
    OrderQTY,
    @Semantics.quantity.unitOfMeasure: 'Baseunit' 
    QtytobeDelivered,
    Supplier,
    Branchname,
    SOdate,
    Edd,
    Customercode,
    Customername,
    SONo1,
    //CustomField1,
    ETADate,
    Remarks,
    @Semantics.user.createdBy: true
    CreatedBy,
    PO
    
    
    
    
}
