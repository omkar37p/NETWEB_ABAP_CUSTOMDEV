@AbapCatalog.sqlViewName: 'ZMMINVVIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EXT'
@Metadata.ignorePropagatedAnnotations: true
define view ZMM_INV_VIEW as select from  I_MaterialDocumentItem_2 as gg
  //
{

  key gg.Material,
      gg.Batch,
      gg.Plant,
      gg.StorageLocation,
      max(gg.ManufactureDate) as Pos1,
      max(gg.PostingDate)    as Pos,
      gg.CompanyCode,
      gg.SalesOrder           as sales,
      gg.SalesOrderItem       as Sitem,
      gg.Customer,
      gg.Supplier

}
where
      gg.StorageLocation <> ' '
  and gg.Supplier        <> ''
group by
  gg.Material,
  gg.Batch,
  gg.Plant,
  gg.StorageLocation,
  gg.CompanyCode,
  gg.SalesOrder,
  gg.SalesOrderItem,
  gg.Customer,
  gg.Supplier
