//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Special Stock'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
//define view entity ZMM_APP04_SS
//  as select from    I_MaterialDocumentItem_2 as MDI
// 
//    left outer join I_SalesOrderItem         as SOI on  MDI.Material = SOI.Material
//                                                 and  MDI.SalesOrder = SOI.SalesOrder
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
//      MDI.TotalGoodsMvtAmtInCCCrcy,
//      MDI.CompanyCodeCurrency as Curky,
//      @Semantics.quantity.unitOfMeasure: 'Unit'
//      MDI.QuantityInBaseUnit  as Quantity,
//      MDI.MaterialBaseUnit    as Unit,
//     
//      
//      case
//      when MDI.SalesOrder is not initial
//      then MDI.SalesOrder
//      when MDI.SalesOrder <> SOI.SalesOrder and SOI.SalesOrder is initial
//      then MDI.SalesOrder
//      else SOI.SalesOrder
//      end                     as SalesOrder,    
//      MDI.SalesOrderItem,
//      SOI.SalesOrderItem      as SOItem,
//      @Semantics.amount.currencyCode: 'Curky'
//      cast(
//          cast(MDI.TotalGoodsMvtAmtInCCCrcy as abap.dec(10,2))
//        / cast(MDI.QuantityInBaseUnit      as abap.dec(10,2))
//        as abap.dec(15,2)
//      )                       as PricePerUnit
//
//}
//where
//      MDI.InventorySpecialStockType =  'E'and (MDI.GoodsMovementRefDocType   =  'B'or MDI.GoodsMovementRefDocType   = 'F')   
//  or ( MDI.InventorySpecialStockType = 'E' and (MDI.GoodsMovementRefDocType   = 'B'or MDI.GoodsMovementRefDocType   = 'F') and MDI.InventoryStockType ='02' and MDI.SalesOrderItem  = '000010')
//  or (MDI.InventorySpecialStockType =  'E')
//  
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
//  MDI.SalesOrder,
//  MDI.IsCompletelyDelivered
//
//
//


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Special Stock Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_SS
//  with parameters
//   P_DisplayCurrency : nsdm_display_currency
as select from I_StockQuantityCurrentValue_2(
                    P_DisplayCurrency: 'INR'
               ) as SQCV                       
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
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
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
group by
    SQCV.Product,
    SQCV.Plant,
    SQCV.StorageLocation,
    SQCV.InventorySpecialStockType,
    SQCV.InventoryStockType,
    SQCV.MaterialBaseUnit,
    SQCV.SDDocument,
    SQCV.SDDocumentItem


