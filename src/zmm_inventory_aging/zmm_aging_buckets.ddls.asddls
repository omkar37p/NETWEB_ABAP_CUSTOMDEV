@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aging Buckets'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_AGING_BUCKETS as select from I_MaterialDocumentItem_2 as BU
left outer join ZMM_AGING_REPORT as MT on MT.Plant = BU.Plant
                                              and MT.Product = BU.Material
                                              and MT.StorageLocation = BU.StorageLocation
{
    key BU.Material,
    MT.MaterialBaseUnit,
    MT.Currency,
    BU.PostingDate,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(MT.quantity) as quantity,
    @Semantics.amount.currencyCode: 'Currency'
   sum(MT.TotalGoodsMvtAmtInCCCrcy) as TotalGoodsMvtAmtInCCCrcy,
    
    
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when  cast( dats_days_between(  BU.PostingDate,  $session.system_date )as abap.int8 )  <= 30
      then  MT.quantity
      else null end                                 as Qty30,
      @Semantics.amount.currencyCode: 'Currency'
      case
      when  cast( dats_days_between(  BU.PostingDate,  $session.system_date )as abap.int8 ) <= 30 and MT.Currency  = 'INR'
      then MT.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt30,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when    cast( dats_days_between(  BU.PostingDate,  $session.system_date )as abap.int8 )  >= 31
          and  cast( dats_days_between(   BU.PostingDate,  $session.system_date )as abap.int8 )  <= 60
      then MT.quantity
      else null end                                 as Qty60,

      @Semantics.amount.currencyCode: 'Currency'
      case
      when   cast( dats_days_between(  BU.PostingDate,  $session.system_date )as abap.int8 )  >= 31
          and cast( dats_days_between( BU.PostingDate,  $session.system_date )as abap.int8 )  <= 60 and MT.Currency  = 'INR'
      then MT.TotalGoodsMvtAmtInCCCrcy
      else null end                                 as Amt60
}

group by 
    BU.Material,
    MT.MaterialBaseUnit,
    MT.Currency,
    BU.PostingDate,
    MT.quantity,
    MT.TotalGoodsMvtAmtInCCCrcy
