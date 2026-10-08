@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bucket'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_BUK 
as select from I_MaterialStock_2 as Stock
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
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) as stckage,
      case
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 30
      then 'S1'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 30 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 60
      then 'S2'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 60 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 90
      then 'S3'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 90 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 120
      then 'S4'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 120 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 150
      then 'S5'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 150 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 180
      then 'S6'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 180 and
      dats_days_between( MatlDocLatestPostgDate, $session.system_date ) <= 365
      then 'S7'
      when dats_days_between( MatlDocLatestPostgDate, $session.system_date ) > 365
      then 'S8'
      else null end                                                     as bucket

}
where
  Stock.MatlDocLatestPostgDate <= $session.system_date
