@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Material'
@Search.searchable: true
@ObjectModel.dataCategory: #VALUE_HELP
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_SP_MATERIAL
  as select from I_ProductionOrderItem as _PROI
    inner join   I_ProductDescription  as _PD on _PD.Product = _PROI.Product
{
@Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8

  key  _PROI.Product as Material,
  @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key  _PD.ProductDescription,
       _PD.Language

}
