@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock Age Calculation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATSTCKAGE_1
  as select from I_MaterialStock_2
{
  key Material,
  key Plant,
  key StorageLocation,
  key Batch,
  key Supplier,
  key SDDocument,
  key SDDocumentItem,
  key WBSElementInternalID,
  key Customer,
  key SpecialStockIdfgStockOwner,
  key InventoryStockType,
  key InventorySpecialStockType,
  key FiscalYearVariant,
  key MatlDocLatestPostgDate,
  key MaterialBaseUnit,
  key CostEstimate,
  key ResourceID,
      CompanyCode,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlWrhsStkQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlCnsmpnQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlStkIncrQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
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
      else null end                                                     as bucket,

      /* Associations */
      _CompanyCode,
      _CurrentInvtryPrice,
      _Customer,
      _InventoryPriceByPeriodEndDate,
      _InventorySpecialStockType,
      _InventoryStockType,
      _InvtryPrcBasicByPeriodEndDate,
      _Material,
      _Plant,
      _ResourceBasic,
      _SpclStkIdfgWBSElmntBasicData,
      _SpecialStockIdfgStockOwner,
      _StorageLocation,
      _Supplier,
      _UnitOfMeasure
}
