@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TSFDGDF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INV_RGP as select from zmm_inv_aging as gg
left outer join  I_ProductText   as pt    on pt.Product     = gg.Material
                                          and pt.Language = $session.system_language


  //
{

  key gg.Material as Material,
  key gg.MaterialDocument,
  key gg.MaterialDocumentItem,
   key gg.MaterialDocumentYear,
  key gg.StorageLocation, 
  key   gg.Plant,
//       gg.Batch,
//    gg.StorageLocation,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
            sum(gg.QuantityInBaseUnit) as QuantityInBaseUnit,
      gg.MaterialBaseUnit,
 //     gg.code,
//      gg.PurchaseOrder,
//      gg.PurchaseOrderItem,
//      max(gg.MaterialDocument) as MaterialDocument ,
//      max(gg.ManufactureDate) as Pos1,     
//      max(gg.PostingDate)     as Pos,
      gg.PostingDate     as Pos,
      gg.CompanyCode,
      gg.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     sum(gg.TotalGoodsMvtAmtInCCCrcy) as TotalGoodsMvtAmtInCCCrcy,
     pt.ProductName,
    
//      gg.SalesOrder           as sales,
//      gg.SalesOrderItem       as Sitem,
//      gg.Customer,
//      gg.Supplier,
//      gg.DebitCreditCode

  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 30
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty30,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'          
              case
             when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 ) <= 30 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt30,
             
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 31
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 60
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty60,
             
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 31
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 60 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt60,
             
              @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 61
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 90
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty90,
             
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 61
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 90 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt90,
             
                 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 91
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 120
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty120,
             
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 91
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 120 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt120,
             
                 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 121
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 150
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty150,
             
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 121
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 150 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt150,
             
                 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 151
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 180
             then  gg.QuantityInBaseUnit
             else null end                                                          as Qty180,
             
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 151
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 180 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt180,
             
             
          @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'   
              case
             when    cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 181
                 and  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 365
             then  gg.QuantityInBaseUnit

            else null end                                                          as Qty365,
            
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when   cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  >= 181
                 and cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 365 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                           as Amt365,
             
            @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             case
             when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 )  <= 366
             then  gg.QuantityInBaseUnit
             else null end                                                          as  QtyYear,
     
             @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
             case
             when  cast( dats_days_between(  gg.PostingDate,  $session.system_date )as abap.int8 ) <= 366 and gg.CompanyCodeCurrency  = 'INR'
             then gg.TotalGoodsMvtAmtInCCCrcy
             else null end                                                          as Amt1Year

}
//where
//      gg.StorageLocation <> ' '
      
//  and gg.Supplier        <> ''
group by
 gg.Material,
//  gg.Batch,
  gg.Plant,
  gg.StorageLocation,
    gg.MaterialDocument,
  gg.MaterialDocumentItem,
  gg.MaterialDocumentYear,
//  gg.QuantityInBaseUnit,
  gg.MaterialBaseUnit,
//  gg.code,
//  gg.PurchaseOrder,
//  gg.PurchaseOrderItem,
//  gg.MaterialDocument,
  gg.CompanyCode,
  gg.CompanyCodeCurrency,
//  gg.TotalGoodsMvtAmtInCCCrcy
  gg.PostingDate,
  pt.ProductName,
  gg.QuantityInBaseUnit,
  gg.TotalGoodsMvtAmtInCCCrcy
//  gg.ManufactureDate,
//  gg.SalesOrder,
//  gg.SalesOrderItem,
//  gg.Customer,
//  gg.Supplier,
//  DebitCreditCode

