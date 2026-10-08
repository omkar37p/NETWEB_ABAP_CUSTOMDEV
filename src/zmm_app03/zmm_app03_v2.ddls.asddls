@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock 30 Days bucket CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP03_V2
  with parameters
    rptdate : bldat
  as select from I_MaterialStock_2 as m
{
  key Material,
  key Plant,
  key StorageLocation,
  key InventoryStockType,
  key InventorySpecialStockType,
  key MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      MatlStkIncrQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      MatlStkDecrQtyInMatlBaseUnit,
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) as stckage,
      case
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 30
      then 'S1'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 30 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 60
      then 'S2'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 60 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 90
      then 'S3'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 90 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 120
      then 'S4'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 120 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 150
      then 'S5'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 150 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 180
      then 'S6'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 180 and
      dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) <= 365
      then 'S7'
      when dats_days_between( MatlDocLatestPostgDate, $parameters.rptdate ) > 365
      then 'S8'
      else null end                                                    as bucket

}
where
  m.MatlDocLatestPostgDate <= $parameters.rptdate
