@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_INVENTORY_RE
  as select from    ZMM_INVENTORY_AGING as gg

    left outer join ZMM_STOCK_TRANSIT   as ST on  ST.Material          = gg.Material
                                              and ST.Plant             = gg.Plant
                                              and ST.StorageLocation   = gg.StorageLocation
                                              and ST.MaterialDocument  = gg.MaterialDocument
                                              and ST.GoodsMovementType = '641'
                                              and ST.Supplier          = ''
                                              and ST.OrderID           = ''
                                             
    left outer join ZMM_STOCK_TRANSIT   as SC on  SC.Material          = gg.Material
                                              and SC.Plant             = gg.Plant
                                              and SC.StorageLocation   = gg.StorageLocation
                                              and SC.MaterialDocument  = gg.MaterialDocument
                                              and SC.GoodsMovementType = '101'
                                              and SC.Supplier          = gg.Supplier
                                              and ST.OrderID           = ''
//
//left outer join ZMM_STOCK_TRANSIT   as SP on  SP.Material          = gg.Material
//                                              and SP.Plant             = gg.Plant
//                                              and SP.StorageLocation   = gg.StorageLocation
//                                              and SP.MaterialDocument  = gg.MaterialDocument
//                                              and SP.GoodsMovementType = '642'
//                                             and SP.Supplier          = ''
//                                             and SP.OrderID           = ''
//                                             
//    left outer join ZMM_STOCK_TRANSIT   as SR on  SR.Material          = gg.Material
//                                              and SR.Plant             = gg.Plant
//                                              and SR.StorageLocation   = gg.StorageLocation
//                                              and SR.MaterialDocument  = gg.MaterialDocument
//                                              and SR.GoodsMovementType = '102'
//                                              and SR.Supplier          = ''
//                                              and SR.OrderID           = ''                                              


    left outer join I_ProductText       as pt on  pt.Product  = gg.Material
                                              and pt.Language = $session.system_language



{


  key gg.MaterialDocument,
  key gg.MaterialDocumentItem,
  key gg.MaterialDocumentYear,
      gg.StorageLocation,
      gg.InventorySpecialStockType,
      gg.GoodsMovementType,
      gg.Plant,
      gg.Material                                   as Material,
      
      
          @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     cast (coalesce( ST.QuantityInBaseUnit, 0 ) - coalesce( SC.QuantityInBaseUnit, 0 )  as abap.dec( 15, 3 )) as TransitQuantity,
  //   - coalesce( SP.QuantityInBaseUnit, 0 ) + coalesce( SR.QuantityInBaseUnit, 0 )
//  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//  SP.QuantityInBaseUnit as st642,  
//  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//  SR.QuantityInBaseUnit as st102,
//  
//  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//  ST.QuantityInBaseUnit as st641,  
//  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//  SC.QuantityInBaseUnit as st101,
  gg.Supplier,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(gg.QuantityInBaseUnit)                    as QuantityInBaseUnit,
      gg.MaterialBaseUnit,
      gg.PostingDate                                as Pos,
      gg.CompanyCode,
      gg.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(gg.TotalGoodsMvtAmtInCCCrcy)              as TotalGoodsMvtAmtInCCCrcy,
      pt.ProductName,
  
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 30
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty30,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 ) <= 30 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt30,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 31
          and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 60
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty60,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 31
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 60 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt60,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 61
          and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 90
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty90,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 61
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 90 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt90,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 91
          and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 120
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty120,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 91
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 120 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt120,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 121
          and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 150
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty150,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 121
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 150 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt150,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 151
          and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 180
      then  gg.QuantityInBaseUnit
      else null end                                 as Qty180,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 151
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 180 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt180,


      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 181
         and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 365
      then  gg.QuantityInBaseUnit

      else null end                                 as Qty365,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 181
          and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 365 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt365,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 366
      then  gg.QuantityInBaseUnit
      else null end                                 as QtyAbove365,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 ) >= 366 and gg.CompanyCodeCurrency  = 'INR'
      then gg.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as AmountAbove365


}
//where
//      gg.StorageLocation <> ' '

//  and gg.Supplier        <> ''
group by
  gg.Material,
  //  gg.Batch,
  gg.Plant,
  gg.StorageLocation,
  gg.InventorySpecialStockType,
  gg.GoodsMovementType,

  //  ST.StorageLocation,

  gg.MaterialDocument,
  gg.MaterialDocumentItem,
  gg.MaterialDocumentYear,

  //  gg.QuantityInBaseUnit,
  gg.MaterialBaseUnit,
  gg.Supplier,
  //  gg.PurchaseOrder,
  //  gg.PurchaseOrderItem,
  //  gg.MaterialDocument,
  gg.CompanyCode,
  gg.CompanyCodeCurrency,
  //  gg.TotalGoodsMvtAmtInCCCrcy
  gg.PostingDate,
  pt.ProductName,
  gg.QuantityInBaseUnit,
  gg.TotalGoodsMvtAmtInCCCrcy,
  ST. MaterialBaseUnit,
  ST.QuantityInBaseUnit,
  SC.QuantityInBaseUnit
//  SP.QuantityInBaseUnit,
//  SR.QuantityInBaseUnit

