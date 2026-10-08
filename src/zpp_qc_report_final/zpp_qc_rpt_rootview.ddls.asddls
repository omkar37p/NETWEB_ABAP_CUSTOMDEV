@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_QC_RPT_ROOTVIEW 
 as select from  I_MaterialDocumentItem_2    as MD
  inner join      I_ManufacturingOrder        as MNF      on MNF.ManufacturingOrder = MD.OrderID
                                                           
  left outer join      I_InspectionLot             as INC      on  INC.ManufacturingOrder = MD.OrderID
                                                         and INC.GoodsMovementType  = MD.GoodsMovementType
                        
  
    left outer join      I_InspLotUsageDecision      as ILD      on ILD.InspectionLot = INC.InspectionLot
 
    left outer join I_SalesOrder                as SO       on SO.SalesOrder = MNF.SalesOrder
  
    left outer join I_SalesOrderItem            as SOI      on  MNF.SalesOrderItem = SOI.OriginSDDocumentItem
                                                            and MNF.SalesOrder     = SOI.OriginSDDocument
                                                            and MNF.Material       = SOI.Product
    inner join      I_Customer                  as CUS      on SO.SoldToParty = CUS.Customer
    inner join      I_ProductDescription        as PROD     on PROD.Product = MD.Material
    inner join      I_SerialNumberMaterialDoc_2 as SIRI     on  SIRI.Material             = MD.Material
                                                            and SIRI.MaterialDocument     = MD.MaterialDocument
                                                      //      and SIRI.MaterialDocumentItem = MD.MaterialDocumentItem
    left outer join      zsp_tb                      as Table    on  Table.material     = SIRI.Material
                                                            and Table.serialnumber = SIRI.SerialNumber
//  association [0..*] to ZPP_QC_MICITEMS as MICItems on MICItems.InspectionLot = INC.InspectionLot
    left outer join      ZPP_QC_MIC_RESULTS             as MICItems on MICItems.InspectionLot = INC.InspectionLot
   
{
        
  key   MD.OrderID                              as ProductionOrder,
  key   case
        when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '101' ) then '1'
        when( substring(MD.OrderID, 6, 1) = '1' and MD.GoodsMovementType = '261' ) then '1'
        when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '101' ) then '2'
        when( substring(MD.OrderID, 6, 1) = '3' and MD.GoodsMovementType = '261' ) then '2'

        when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '101' ) then '3'
        when( substring(MD.OrderID, 6, 1) = '6' and MD.GoodsMovementType = '261' or MD.GoodsMovementType = '531' ) then '3'
        end                                     as level_1,
  key   INC.InspectionLot,
  key   Table.material                          as material1,
  key   Table.serialnumber                      as SerialNumber1,
  key   MICItems.CharacteristicAttributeCode    as CharacteristicAttributeCode1,
  key   MD.GoodsMovementType,
  key  MD.Material,
  key MD.MaterialDocument,
//  key   INS.InspectionSpecification,
//   INS.InspectionSpecificationText  as LONGTEXT,
        MNF.SalesOrder,
        INC.ManufacturingOrder, 
      

        MNF.ManufacturingOrderType,
       
        PROD.ProductDescription                 as MaterialDesc,

        MNF.SalesOrder                          as SDSalesOrder,

        MNF.SalesOrderItem,
        @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
        SOI.OrderQuantity                       as SOQty,
        @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
        MD.QuantityInEntryUnit                  as ComponentQty,
        SOI.OrderQuantityUnit,
        @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
        MD.QuantityInBaseUnit                   as ProductionQty,
        CUS.Customer                            as CustomerCode,
        CUS.CustomerName                        as CustomerName,
        SO.SoldToParty                          as CustomerNumber,
        SO.PurchaseOrderByCustomer              as CustomPOReference,
        SO.YY1_StandardWarrantyi1_SDH           as StandardWarranty,
        MD.StorageLocation                      as StorageLocation,
        SIRI.Equipment,
        SIRI.SerialNumber,


        
        MICItems.CharacteristicAttributeCodeGrp as InspectionSpecification,
        MICItems.CharacteristicAttributeCode    as InspectionSpecificationText,
//        INS.InspectionSpecificationText  as LONGTEXT,
        
      
        MICItems.InspectionCodeText,
        MICItems.InspectionResultText,
        ILD.YY1_IPMIUSERPASSWORD_USD            as IPMIUSERPASSWORD,
        ILD.YY1_KEY_USD                         as KEYS,
        ILD.YY1_VERSION_USD                     as VERSION,
        ILD.YY1_WINDOWS_USD                     as OS,
        Table.remarks



}
where
  (
    MD.GoodsMovementType <> '321'
    //    and(MD.GoodsMovementType <> '261' or MNF.ManufacturingOrderType <> 'YBM1')

  )
  
