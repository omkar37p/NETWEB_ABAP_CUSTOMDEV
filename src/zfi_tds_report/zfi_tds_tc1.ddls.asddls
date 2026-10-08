@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_TDS_TC1 as select from zfi_app02_wtp
{
    key taxcode as Taxcode,
    KEY SUID   AS SUID,
      description as Description,
      lastchangedat as lastchangedat 
}
