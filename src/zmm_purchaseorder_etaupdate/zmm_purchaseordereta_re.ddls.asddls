@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'purchaseorderETA Root view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PurchaseorderETA_RE 
as select from I_PurchaseOrderItemAPI01 as POI
inner join I_PurchaseOrderAPI01          as PO   on PO.PurchaseOrder = POI.PurchaseOrder 
                                                    and (PO.PurchaseOrderType = 'NB'or PO.PurchaseOrderType = 'ZT')
                                                    //and PO.PurchaseOrderType = 'ZT'
//left outer join  I_SalesOrderItem        as SOI  on SOI.SalesOrder = POI.YY1_SalesOrder1_PDI
 //                                                and SOI.Material = POI.Material
                                                 //and SOI.Plant = POI.Plant
                                                // and SOI.StorageLocation = POI.StorageLocation
                                                // and SOI.MaterialGroup = POI.MaterialGroup
left outer join I_MaterialDocumentItem_2 as MDI  on MDI.PurchaseOrder = POI.PurchaseOrder 
                                                  and MDI.Material = POI.Material
                                                 and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
                                                 and MDI.Supplier = PO.Supplier
                                                 and MDI.ReversedMaterialDocument <> ' '
                                                 
//left outer  join  I_SalesDocumentItem    as SDI  on SDI.SalesDocument = POI.YY1_SalesOrder1_PDI                                                       
left outer  join ZCDS_ETAtab             as ETA  on ETA.pono = POI.PurchaseOrder
                                                 and ETA.PoLine = POI.PurchaseOrderItem
left outer join I_Customer               as CUS  on CUS.Customer = PO.Supplier
                                                // and CUS.
left outer join I_Supplier               as SUP  on SUP.Supplier = PO.Supplier 
                                                       
{
    key POI.PurchaseOrder            as   PONo,
    key POI.PurchaseOrderItem        as   POLineItem,
    key POI.YY1_SalesOrder1_PDI      as   SONo,    
        POI.YY1_ETADate_PDI          as   ETADate1,
        POI.YY1_Remarks_PDI          as   Remark1,
       POI.YY1_CustomerCode_PDI      as   CustomerCode1,
       POI.YY1_CustomerName1_PDI     as   CustomerName1,
       POI.Material                  as   Material,
       POI.BaseUnit                  as  Baseunit,
       POI.YY1_ProductFulldescri2_PDI as ProductDesc,
       POI.TaxCode                    as TaxCode,
       PO.PurchaseOrderType           as PODoctype,
       PO.PurchaseOrderDate           as PODocdate,
       POI.YY1_BranchName_PDI         as BranchName1,
       POI.YY1_SODate_PDI             as SOdate1,
       POI.YY1_EDD_PDI                as EDD1,
       
       @Semantics.quantity.unitOfMeasure: 'Baseunit'
       POI.OrderQuantity             as   OrderQTY,
       @Semantics.quantity.unitOfMeasure: 'Baseunit'
       MDI.QuantityInEntryUnit       as   QtytobeDelivered,
       concat(concat(SUP.Supplier,'-'),SUP.SupplierName)    as   Supplier,
       
       case 
       when POI.YY1_BranchName_PDI is initial then ETA.Branchname
       else POI.YY1_BranchName_PDI
       end                            as Branchname,
       
       case 
       when POI.YY1_SODate_PDI  is initial then ETA.Sodate
       else POI.YY1_SODate_PDI
       end                            as SOdate,
       
       case
       when POI.YY1_EDD_PDI is initial then ETA.Edd
       else POI.YY1_EDD_PDI
       end                           as Edd,
       
       case 
       when POI.YY1_CustomerCode_PDI is initial then ETA.CustomerCode
       else POI.YY1_CustomerCode_PDI 
       end                             as Customercode,
       
       case when POI.YY1_CustomerName1_PDI is initial then ETA.CustomerName
       else POI.YY1_CustomerName1_PDI
       end                             as Customername,
       
       case when POI.YY1_SalesOrder1_PDI is initial then ETA.Sono1
       else POI.YY1_SalesOrder1_PDI
       end                               as  SONo1,                         
       //ETA.CustomerCode                as  Customercode,
       //ETA.CustomerName                as  Customername,
       //CUS.Customer                  as   CustomerCode,
       //CUS.CustomerName              as   CustomerName,
      // ETA.ETADate                   as ETADate,
      // ETA.Remarks                   as Remarks,
     case  
    when POI.YY1_Remarks_PDI is initial then ETA.Remarks
    else POI.YY1_Remarks_PDI
end as Remarks,
 case 
 when POI.YY1_ETADate_PDI is initial then ETA.ETADate
 else POI.YY1_ETADate_PDI
 end as ETADate,
       @Semantics.user.createdBy: true
       ETA.Createdby                 as CreatedBy,
       ETA.PO                        as PO
     

      
        
}
