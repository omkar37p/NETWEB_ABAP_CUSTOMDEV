@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invenory Aging Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_INV_RV as select from 
ZMM_INV_VIEW as md


inner join I_PurchaseOrderItemAPI01 as poi  on
//                                                   poi.PurchaseOrder = md.PurchaseOrder
//                                            and poi.PurchaseOrderItem = md.PurchaseOrderItem
                                            poi.Material     = md.Material
                                         //   and poi.Plant        = md.Plant
                                        //    and poi.BaseUnit     = md.MaterialBaseUnit
                                       //   and poi.StorageLocation  = md.StorageLocation
left outer join  I_ProductText   as pt    on pt.Product     = md.Material
                                          and pt.Language = $session.system_language

{
//   key md.MaterialDocument  as MaterialDocument,
//    key md.Material     as Material,
    key poi.Plant        as plant
//     poi.CompanyCode  as CompanyCode,
//     poi.MaterialGroup  as MaterialGroup,
//     pt.ProductName     as MaterialDescription,
////     md.MaterialDocument  as MaterialDocument,
////     md.Post      as MaterialPostingDate,
//     md.MaterialBaseUnit as UOM,
//     @Semantics.quantity.unitOfMeasure: 'uom'
//     md.QuantityInBaseUnit as TotalQuantity,
//     md.CompanyCodeCurrency as currency,
//     @Semantics.amount.currencyCode: 'currency'
//     md.TotalGoodsMvtAmtInCCCrcy   as AMTcompanycodecurrency,
//     
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when  cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 30
//             then  md.QuantityInBaseUnit
//             else null end                                                          as Qty30,
//     
//              @Semantics.amount.currencyCode: 'currency'
//             case
//             when  cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 ) <= 30 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                          as Amt30,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when    cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 31
//                 and  cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 60
//             then  md.QuantityInBaseUnit
//             else null end                                                          as Qty60,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 31
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 60 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                          as Amt60,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when cast(dats_days_between(  md.Pos, $session.system_date)as abap.int8 )  >= 61
//             and cast(dats_days_between( md.Pos, $session.system_date)as abap.int8 )    <= 90
//             then md.QuantityInBaseUnit
//             else null end                                                          as Qty90,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 61
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 90 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                           as Amt90,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when cast(dats_days_between(  md.Pos, $session.system_date)as abap.int8 )  >= 91
//             and cast(dats_days_between( md.Pos, $session.system_date)as abap.int8 )    <= 120
//             then md.QuantityInBaseUnit
//             else null end                                                          as Qty120,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 91
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 120 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                           as Amt120,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when cast(dats_days_between(  md.Pos, $session.system_date)as abap.int8 )  >= 121
//             and cast(dats_days_between( md.Pos, $session.system_date)as abap.int8 )    <= 150
//             then md.QuantityInBaseUnit
//             else null end                                                          as Qty150,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 121
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 150 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                           as Amt150,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when cast(dats_days_between(  md.Pos, $session.system_date)as abap.int8 )  >= 151
//             and cast(dats_days_between( md.Pos, $session.system_date)as abap.int8 )    <= 180
//             then md.QuantityInBaseUnit
//             else null end                                                          as Qty180,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 151
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 180 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                           as Amt180,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when cast(dats_days_between(  md.Pos, $session.system_date)as abap.int8 )  >= 181
//             and cast(dats_days_between( md.Pos, $session.system_date)as abap.int8 )    <= 365
//             then md.QuantityInBaseUnit
//             else null end                                                          as Qty365,
//             
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when   cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  >= 181
//                 and cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 365 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                           as Amt365,
//             
//             @Semantics.quantity.unitOfMeasure: 'uom'
//             case
//             when  cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 )  <= 366
//             then  md.QuantityInBaseUnit
//             else null end                                                          as  QtyYear,
//     
//             @Semantics.amount.currencyCode: 'currency'
//             case
//             when  cast( dats_days_between(  md.Pos,  $session.system_date )as abap.int8 ) <= 366 and md.CompanyCodeCurrency  = 'INR'
//             then md.TotalGoodsMvtAmtInCCCrcy
//             else null end                                                          as Amt1Year
//    
}
