@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Ageing Report - Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP03_RV
  with parameters
    @EndUserText.label: 'Report Date'
    p_rptdate : bldat
  as select distinct from I_MaterialStock_2                               as i
    left outer join       ZMM_APP03_V1( rptdate : $parameters.p_rptdate ) as unstk  on  unstk.Material                  = i.Material
                                                                                    and unstk.Plant                     = i.Plant
                                                                                    and unstk.StorageLocation           = i.StorageLocation
                                                                                    and unstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and unstk.InventoryStockType        = '01'
    left outer join       ZMM_APP03_V1( rptdate : $parameters.p_rptdate ) as qistk  on  qistk.Material                  = i.Material
                                                                                    and qistk.Plant                     = i.Plant
                                                                                    and qistk.StorageLocation           = i.StorageLocation
                                                                                    and qistk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and qistk.InventoryStockType        = '02'
    left outer join       ZMM_APP03_V1( rptdate : $parameters.p_rptdate ) as blstk  on  blstk.Material                  = i.Material
                                                                                    and blstk.Plant                     = i.Plant
                                                                                    and blstk.StorageLocation           = i.StorageLocation
                                                                                    and blstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and blstk.InventoryStockType        = '07'
    left outer join       ZMM_APP03_V1( rptdate : $parameters.p_rptdate ) as trstk  on  trstk.Material                  = i.Material
                                                                                    and trstk.Plant                     = i.Plant
                                                                                    and trstk.StorageLocation           = i.StorageLocation
                                                                                    and trstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and trstk.InventoryStockType        = '06'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s8stk  on  s8stk.Material                  = i.Material
                                                                                    and s8stk.Plant                     = i.Plant
                                                                                    and s8stk.StorageLocation           = i.StorageLocation
                                                                                    and s8stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s8stk.bucket                    = 'S8'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s7stk  on  s7stk.Material                  = i.Material
                                                                                    and s7stk.Plant                     = i.Plant
                                                                                    and s7stk.StorageLocation           = i.StorageLocation
                                                                                    and s7stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s7stk.bucket                    = 'S7'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s6stk  on  s6stk.Material                  = i.Material
                                                                                    and s6stk.Plant                     = i.Plant
                                                                                    and s6stk.StorageLocation           = i.StorageLocation
                                                                                    and s6stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s6stk.bucket                    = 'S6'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s5stk  on  s5stk.Material                  = i.Material
                                                                                    and s5stk.Plant                     = i.Plant
                                                                                    and s5stk.StorageLocation           = i.StorageLocation
                                                                                    and s5stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s5stk.bucket                    = 'S5'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s4stk  on  s4stk.Material                  = i.Material
                                                                                    and s4stk.Plant                     = i.Plant
                                                                                    and s4stk.StorageLocation           = i.StorageLocation
                                                                                    and s4stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s4stk.bucket                    = 'S4'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s3stk  on  s3stk.Material                  = i.Material
                                                                                    and s3stk.Plant                     = i.Plant
                                                                                    and s3stk.StorageLocation           = i.StorageLocation
                                                                                    and s3stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s3stk.bucket                    = 'S3'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s2stk  on  s2stk.Material                  = i.Material
                                                                                    and s2stk.Plant                     = i.Plant
                                                                                    and s2stk.StorageLocation           = i.StorageLocation
                                                                                    and s2stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s2stk.bucket                    = 'S2'
    left outer join       ZMM_APP03_V3( rptdate : $parameters.p_rptdate ) as s1stk  on  s1stk.Material                  = i.Material
                                                                                    and s1stk.Plant                     = i.Plant
                                                                                    and s1stk.StorageLocation           = i.StorageLocation
                                                                                    and s1stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                                    and s1stk.bucket                    = 'S1'
    left outer join       ZMM_APP03_V4( rptdate : $parameters.p_rptdate ) as dcrstk on  dcrstk.Material                  = i.Material
                                                                                    and dcrstk.Plant                     = i.Plant
                                                                                    and dcrstk.StorageLocation           = i.StorageLocation
                                                                                    and dcrstk.InventorySpecialStockType = i.InventorySpecialStockType

{
  key i.Material                  as Material,
  key i.Plant                     as Plant,
  key i.StorageLocation           as Sloc,
  key i.InventorySpecialStockType as Stktyp,
  key i.MaterialBaseUnit          as Unit,
      $parameters.p_rptdate       as Rptdate,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      unstk.totstkqty             as unstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      qistk.totstkqty             as qistkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      blstk.totstkqty             as blstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      trstk.totstkqty             as trstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s1stk.incstkqty             as s1stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s2stk.incstkqty             as s2stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s3stk.incstkqty             as s3stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s4stk.incstkqty             as s4stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s5stk.incstkqty             as s5stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s6stk.incstkqty             as s6stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s7stk.incstkqty             as s7stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s8stk.incstkqty             as s8stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      dcrstk.dcrstkqty            as dcrstkqty
}
