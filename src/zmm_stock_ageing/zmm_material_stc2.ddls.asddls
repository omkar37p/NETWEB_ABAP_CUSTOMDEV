@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Entity 2 View'
@Metadata.ignorePropagatedAnnotations: true

//define view entity ZMM_MATERIAL_STC2 as select from I_MaterialDocumentItem_2
//{
//    key Material,
////    key MaterialDocument,
////    key PostingDate,
//    key Plant,
//    key StorageLocation,
////    InventorySpecialStockType,
////    InventoryStockType,
////    SalesOrder,
////    SalesOrderItem,
//    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//    sum(
//        case 
//            when DebitCreditCode = 'H' 
//                then - QuantityInBaseUnit
//            else QuantityInBaseUnit
//        end
//    ) as Quantity,
////    sum( 
////     case
////       when DebitCreditCode = 'H' 
////         then QuantityInBaseUnit * -1 
////       else QuantityInBaseUnit 
////     end 
////      ) as Quantity,
////     QuantityInBaseUnit as Quantity
//
//     MaterialBaseUnit
// 
//}
// where IsAutomaticallyCreated = '' // and ReversedMaterialDocument = ''
//
//group by
//    Material,
////    MaterialDocument,
////    PostingDate,
//    Plant,
//    StorageLocation,
//    MaterialBaseUnit
    
    


define view entity ZMM_MATERIAL_STC2 
  with parameters p_date : abap.dats
as select from I_MaterialDocumentItem_2
{
    key Material,
    key PostingDate,
    key Plant,
    key StorageLocation,
    InventorySpecialStockType,
    InventoryStockType,
    SalesOrder,
    SalesOrderItem,

    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(
        case 
            when DebitCreditCode = 'H' 
                then - QuantityInBaseUnit
            else QuantityInBaseUnit
        end
    ) as Quantity,

    MaterialBaseUnit,
    CompanyCodeCurrency
}
//where ReversedMaterialDocument = '' 
  where IsAutomaticallyCreated = ''
  and PostingDate <= $parameters.p_date   // ✅ dynamic date
group by
    Material,
    Plant,
    StorageLocation,
    InventorySpecialStockType,
    InventoryStockType,
    SalesOrder,
    SalesOrderItem,
    MaterialBaseUnit,
    CompanyCodeCurrency,
    PostingDate

