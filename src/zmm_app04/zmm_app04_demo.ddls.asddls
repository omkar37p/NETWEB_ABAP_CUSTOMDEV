@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Special Stock Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_DEMO
//  with parameters
//   P_DisplayCurrency : nsdm_display_currency
as select from I_StockQuantityCurrentValue_2(
                    P_DisplayCurrency: 'INR'
               ) as SQCV    
left outer join I_MaterialDocumentItem_2 as MDI on  SQCV.Product = MDI.Material
                                                 and SQCV.Plant   = MDI.Plant
                                                 and SQCV.StorageLocation = MDI.StorageLocation
                                                 and SQCV.InventorySpecialStockType = MDI.InventorySpecialStockType
                                                 and SQCV.SDDocument = MDI.SalesOrder
                                                 and SQCV.SDDocumentItem = MDI.SalesOrderItem                  
{
    /* Keys */
    key SQCV.Product,
    key SQCV.Plant,
    key SQCV.StorageLocation,
//    key SQCV.Batch,
    key SQCV.InventorySpecialStockType,

    /* Stock info */
    SQCV.InventoryStockType,
    SQCV.MaterialBaseUnit,
    SQCV.SDDocument,
    SQCV.SDDocumentItem,
//    V2.MatlDocLatestPostgDate,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//    cast(
//    sum(
//        case
//            when SQCV.InventorySpecialStockType = 'E'
//             and SQCV.ValuationAreaType         = '1'
//             and SQCV.InventoryStockType = '01'
//            then cast( SQCV.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(23,3) )
//
//            when SQCV.InventorySpecialStockType = 'E'
//             and SQCV.ValuationAreaType         = '1'
//             and SQCV.InventoryStockType = '02'
//            then cast( SQCV.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(23,3) )
//
//            else cast( 0 as abap.dec(23,3) )
//        end
//    ) as abap.dec(23,3)
//) as Quantity,  
   cast(
    sum(
        case
            // SQCV.InventorySpecialStockType = 'E'
           when  ( SQCV.ValuationAreaType         = '1')
                //or SQCV.ValuationAreaType         = '3'
             and (
                    SQCV.InventoryStockType = '01'
                 or SQCV.InventoryStockType = '02'
                 or SQCV.InventoryStockType = '07'
                 or SQCV.InventoryStockType = '06'
                 )
            then cast(
                    SQCV.MatlWrhsStkQtyInMatlBaseUnit
                    as abap.dec(23,3)
                 )
            else cast( 0 as abap.dec(23,3) )
        end
    ) as abap.dec(23,3)
) as Quantity, 
    
    /* Display currency */
//    $parameters.P_DisplayCurrency as NSDM_Display_Currency,
      cast( 'INR' as abap.cuky ) as NSDM_Display_Currency,

    /* Display amount */
    @Semantics.amount.currencyCode: 'NSDM_Display_Currency'
    cast(
    sum(
        case
             //SQCV.InventorySpecialStockType = 'E'
           when  ( SQCV.ValuationAreaType         = '1'
                or SQCV.ValuationAreaType         = '3' )
             and (
                    SQCV.InventoryStockType = '01'
                 or SQCV.InventoryStockType = '02'
                 or SQCV.InventoryStockType = '07'
                 or SQCV.InventoryStockType = '06'
                 )
            then cast(
                    SQCV.StockValueInDisplayCurrency
                    as abap.dec(23,2)
                 )
            else cast( 0 as abap.dec(23,2) )
        end
    ) as abap.dec(23,2)
) as StockValueInDisplayCurrency
}

where 
    SQCV.MatlWrhsStkQtyInMatlBaseUnit <> 0 and SQCV.InventoryStockType <> '08'
    //SQCV.InventorySpecialStockType = 'E' and ( SQCV.InventoryStockType = '01' or SQCV.InventoryStockType = '02') 
   // and ( SQCV.ValuationAreaType = '1' )  and ( SQCV.StockValueInDisplayCurrency <> 0 or SQCV.StockValueInDisplayCurrency = 0 )
   //and not  ( SQCV.InventorySpecialStockType = 'E' and (SQCV.InventoryStockType = '02')and SQCV.MatlWrhsStkQtyInMatlBaseUnit = 0  and SQCV.ValuationAreaType = '1' and SQCV.StockValueInDisplayCurrency = 0  and SQCV.MatlWrhsStkQtyInMatlBaseUnit is not null)
//    and ( SQCV.InventoryStockType = '02' and SQCV.ValuationAreaType = '1' and SQCV.MatlWrhsStkQtyInMatlBaseUnit is not null and SQCV.StockValueInDisplayCurrency = 0)
group by
    SQCV.Product,
    SQCV.Plant,
    SQCV.StorageLocation,
    SQCV.InventorySpecialStockType,
    SQCV.InventoryStockType,
    SQCV.MaterialBaseUnit,
    SQCV.SDDocument,
    SQCV.SDDocumentItem
//    V2.MatlDocLatestPostgDate










































//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Special Stock'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//
//define view entity ZMM_APP04_DEMO
//  as select from    I_MaterialDocumentItem_2 as MDI
//  
//
//    left outer join I_SalesOrderItem         as SOI on  MDI.Material = SOI.Material
//                                                 and  MDI.SpecialStockIdfgSalesOrder = SOI.SalesOrder
//                                                  and MDI.SalesOrderItem = SOI.SalesOrderItem
//                                                    and MDI.Plant    = SOI.Plant
//                                                    
//{
//  key MDI.MaterialDocument,
//  key MDI.MaterialDocumentItem,
//      MDI.InventorySpecialStockType,
//      MDI.Material,
//      MDI.StorageLocation,
//      MDI.Plant,
//      MDI.Batch,
//      @Semantics.amount.currencyCode: 'Curky'
//      cast(
//      case
//      when MDI.SalesOrder <> '' and MDI.IsCompletelyDelivered = 'X'
//      then MDI.TotalGoodsMvtAmtInCCCrcy
//      else
//      MDI2.TotalGoodsMvtAmtInCCCrcy
//      end
//      as abap.dec(15,2)
//      )                       as TotalGoodsMvtAmtInCCCrcy,
//      
//      MDI.TotalGoodsMvtAmtInCCCrcy,
//      MDI.CompanyCodeCurrency as Curky,
//      @Semantics.quantity.unitOfMeasure: 'Unit'
//      MDI.QuantityInBaseUnit  as Quantity,
//      MDI.MaterialBaseUnit    as Unit,
//      
//      case
//      when SOI.Material is not initial
//      then SOI.SalesOrder
//      else MDI.SalesOrder
//      end                     as SalesOrder,
//      case
//      when MDI.SpecialStockIdfgSalesOrder is not initial
//      then MDI.SpecialStockIdfgSalesOrder
//      when MDI.SpecialStockIdfgSalesOrder <> SOI.SalesOrder and SOI.SalesOrder is initial
//      then MDI.SpecialStockIdfgSalesOrder
//      else SOI.SalesOrder
//      end                     as SalesOrder,    
//      MDI.SpecialStockIdfgSalesOrder,
//      MDI.SpecialStockIdfgSalesOrderItem,
//      SOI.SalesOrderItem,
//      @Semantics.amount.currencyCode: 'Curky'
//      cast(
//          cast(MDI.TotalGoodsMvtAmtInCCCrcy as abap.dec(10,2))
//        / cast(MDI.QuantityInBaseUnit      as abap.dec(10,2))
//        as abap.dec(15,2)
//      )                       as PricePerUnit
//       cast(
//      case
//       when MDI.SalesOrder <> ''
//            and MDI.TotalGoodsMvtAmtInCCCrcy <> 0
//         then
//           cast( MDI.TotalGoodsMvtAmtInCCCrcy as abap.dec(10,2) )
//           / cast( MDI.QuantityInBaseUnit     as abap.dec(10,2) )
//
//       when MDI2.SalesOrder = ''
//            and MDI2.QuantityInBaseUnit <> 0
//         then
//           cast( MDI2.TotalGoodsMvtAmtInCCCrcy as abap.dec(10,2) )
//           / cast( MDI2.QuantityInBaseUnit     as abap.dec(10,2) )
//
//       else 0
//      end
//      as abap.dec(15,2)
//      )                       as PricePerUnit
// 
//}
//where
//      MDI.InventorySpecialStockType =  'E'and (MDI.GoodsMovementRefDocType   =  'B'or MDI.GoodsMovementRefDocType   = 'F')
//  or ( MDI.InventorySpecialStockType = 'E' and (MDI.GoodsMovementRefDocType   = 'B'or MDI.GoodsMovementRefDocType   = 'F') and MDI.InventoryStockType ='02' and MDI.SalesOrderItem  = '000010')
//  or (MDI.InventorySpecialStockType =  'E')
// and (MDI.InventorySpecialStockType = 'E' and MDI.GoodsMovementRefDocType = 'F' and MDI.InventoryStockType ='02' and MDI.SpecialStockIdfgSalesOrder <> '' and MDI.TotalGoodsMvtAmtInCCCrcy <> 0)
//  or ( MDI.InventorySpecialStockType = 'E' and MDI.GoodsMovementRefDocType = 'L' and MDI.InventoryStockType ='01' and MDI.MaterialDocumentItem  = '0002')
//or( MDI.InventorySpecialStockType =  'E' )
// or ( MDI.SalesOrder = '' and MDI.InventorySpecialStockType =  'E' and MDI.GoodsMovementRefDocType   =  'F' )
//   
//  and MDI.TotalGoodsMvtAmtInCCCrcy  <> 0
//group by
//  MDI.MaterialDocument,
//  MDI.MaterialDocumentItem,
//  MDI.InventorySpecialStockType,
//  MDI.Material,
//  MDI.StorageLocation,
//  MDI.Plant,
//  MDI.Batch,
//  MDI.TotalGoodsMvtAmtInCCCrcy,
//  MDI.CompanyCodeCurrency,
//  MDI.QuantityInBaseUnit,
//  MDI.MaterialBaseUnit,
//  SOI.SalesOrder,
//  MDI.SalesOrderItem,
//  SOI.SalesOrderItem,
//  SOI.Material,
//  MDI.SpecialStockIdfgSalesOrder,
//  MDI.SpecialStockIdfgSalesOrderItem,
//  MDI2.TotalGoodsMvtAmtInCCCrcy,
//  MDI2.QuantityInBaseUnit,
//  MDI2.SalesOrder,
//  MDI.IsCompletelyDelivered
  
  

//  
//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Special Stock'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//define view entity ZMM_APP04_DEMO
//  as select from    I_MaterialDocumentItem_2 as MDI
//                                                    
//{
//  key MDI.MaterialDocument,
//  key MDI.MaterialDocumentItem,
//      MDI.InventorySpecialStockType,
//      MDI.Material,
//      MDI.StorageLocation,
//      MDI.Plant,
//      MDI.Batch,
//      @Semantics.amount.currencyCode: 'Curky'
//      MDI.TotalGoodsMvtAmtInCCCrcy,
//      MDI.CompanyCodeCurrency as Curky,
//      @Semantics.quantity.unitOfMeasure: 'Unit'
//      MDI.QuantityInBaseUnit  as Quantity,
//      MDI.MaterialBaseUnit    as Unit,  
//      MDI.SpecialStockIdfgSalesOrderItem,
//      MDI.SpecialStockIdfgSalesOrder,
//      MDI.GoodsMovementRefDocType,
//      MDI.InventoryStockType,
//      @Semantics.amount.currencyCode: 'Curky'
//      cast(
//          cast(MDI.TotalGoodsMvtAmtInCCCrcy as abap.dec(10,2))
//        / cast(MDI.QuantityInBaseUnit      as abap.dec(10,2))
//        as abap.dec(15,2)
//      )                       as PricePerUnit
// 
//}
//
//where
////      MDI.InventorySpecialStockType =  'E'and (MDI.GoodsMovementRefDocType   =  'B'or MDI.GoodsMovementRefDocType   = 'F')  
////  or ( MDI.InventorySpecialStockType = 'E' and (MDI.GoodsMovementRefDocType   = 'B'or MDI.GoodsMovementRefDocType   = 'F') and MDI.InventoryStockType ='02' and MDI.SpecialStockIdfgSalesOrderItem  = '000010')
//   ( MDI.InventorySpecialStockType =  'E' and MDI.GoodsMovementRefDocType   =  'B' and MDI.SpecialStockIdfgSalesOrderItem  = '000010')
//   or  ( MDI.InventorySpecialStockType =  'E' and (MDI.GoodsMovementRefDocType   =  'B' or MDI.GoodsMovementRefDocType   = 'F') and MDI.SpecialStockIdfgSalesOrderItem  = '000010')
////  or (MDI.InventorySpecialStockType = 'E' and (MDI.GoodsMovementRefDocType = 'B' and MDI.IsCompletelyDelivered =  'X' ) and MDI.TotalGoodsMvtAmtInCCCrcy <> 0 and MDI.SalesOrderItem = '000010')
//  
//  and MDI.TotalGoodsMvtAmtInCCCrcy  <> 0
//  
//  
//group by
//  MDI.MaterialDocument,
//  MDI.MaterialDocumentItem,
//  MDI.InventorySpecialStockType,
//  MDI.Material,
//  MDI.StorageLocation,
//  MDI.Plant,
//  MDI.Batch,
//  MDI.TotalGoodsMvtAmtInCCCrcy,
//  MDI.CompanyCodeCurrency,
//  MDI.QuantityInBaseUnit,
//  MDI.MaterialBaseUnit,
////  SOI.SalesOrder,
//  MDI.SpecialStockIdfgSalesOrderItem,
//  MDI.SpecialStockIdfgSalesOrder,
////  SOI.SalesOrderItem,
////  SOI.Material,
//  MDI.SalesOrder,
//  MDI.IsCompletelyDelivered,
//  MDI.GoodsMovementRefDocType,
//  MDI.InventoryStockType
 
  
