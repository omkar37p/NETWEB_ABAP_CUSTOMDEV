@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Ageing Report - Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_MATSTCKAGE_RV
  with parameters
    p_rptdate : bldat
  as select from I_MaterialStock_2                                   as i
    inner join   ZMM_MATSTCKAGE_2( rptdate : $parameters.p_rptdate ) as uns on  uns.Material                  = i.Material
                                                                            and uns.Plant                     = i.Plant
                                                                            and uns.StorageLocation           = i.StorageLocation
                                                                            and uns.InventorySpecialStockType = i.InventorySpecialStockType
                                                                            and uns.InventoryStockType        = '01'


{
  key i.Material,
  key i.Plant,
  key i.StorageLocation,
  key i.InventorySpecialStockType,
  key i.MaterialBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      uns.ovrallqty            as unrstqty
}
