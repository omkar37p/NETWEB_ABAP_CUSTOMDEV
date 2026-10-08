@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Ageing Multiple Materials - Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_RV
//  with parameters
//    P_DisplayCurrency : nsdm_display_currency
  as select distinct from I_MaterialStock_2       as i
    left outer join       ZMM_APP04_V1            as unstk      on  unstk.Material                  = i.Material
                                                                and unstk.Plant                     = i.Plant
                                                                and unstk.StorageLocation           = i.StorageLocation
                                                                and unstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and unstk.InventoryStockType        = '01'
                                                                
    left outer join       ZMM_APP04_V1            as qistk      on  qistk.Material                  = i.Material
                                                                and qistk.Plant                     = i.Plant
                                                                and qistk.StorageLocation           = i.StorageLocation
                                                                and qistk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and qistk.InventoryStockType        = '02'
    left outer join       ZMM_APP04_V1            as blstk      on  blstk.Material                  = i.Material
                                                                and blstk.Plant                     = i.Plant
                                                                and blstk.StorageLocation           = i.StorageLocation
                                                                and blstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and blstk.InventoryStockType        = '07'
    left outer join       ZMM_APP04_V1            as trstk      on  trstk.Material                  = i.Material
                                                                and trstk.Plant                     = i.Plant
                                                                and trstk.StorageLocation           = i.StorageLocation
                                                                and trstk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and trstk.InventoryStockType        = '06'
    left outer join       ZMM_APP04_V3            as s8stk      on  s8stk.Material                  = i.Material
                                                                and s8stk.Plant                     = i.Plant
                                                                and s8stk.StorageLocation           = i.StorageLocation
                                                                and s8stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s8stk.bucket                    = 'S8'
    left outer join       ZMM_APP04_V3            as s7stk      on  s7stk.Material                  = i.Material
                                                                and s7stk.Plant                     = i.Plant
                                                                and s7stk.StorageLocation           = i.StorageLocation
                                                                and s7stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s7stk.bucket                    = 'S7'
    left outer join       ZMM_APP04_V3            as s6stk      on  s6stk.Material                  = i.Material
                                                                and s6stk.Plant                     = i.Plant
                                                                and s6stk.StorageLocation           = i.StorageLocation
                                                                and s6stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s6stk.bucket                    = 'S6'
    left outer join       ZMM_APP04_V3            as s5stk      on  s5stk.Material                  = i.Material
                                                                and s5stk.Plant                     = i.Plant
                                                                and s5stk.StorageLocation           = i.StorageLocation
                                                                and s5stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s5stk.bucket                    = 'S5'
    left outer join       ZMM_APP04_V3            as s4stk      on  s4stk.Material                  = i.Material
                                                                and s4stk.Plant                     = i.Plant
                                                                and s4stk.StorageLocation           = i.StorageLocation
                                                                and s4stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s4stk.bucket                    = 'S4'
    left outer join       ZMM_APP04_V3            as s3stk      on  s3stk.Material                  = i.Material
                                                                and s3stk.Plant                     = i.Plant
                                                                and s3stk.StorageLocation           = i.StorageLocation
                                                                and s3stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s3stk.bucket                    = 'S3'
    left outer join       ZMM_APP04_V3            as s2stk      on  s2stk.Material                  = i.Material
                                                                and s2stk.Plant                     = i.Plant
                                                                and s2stk.StorageLocation           = i.StorageLocation
                                                                and s2stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s2stk.bucket                    = 'S2'
    left outer join       ZMM_APP04_V3            as s1stk      on  s1stk.Material                  = i.Material
                                                                and s1stk.Plant                     = i.Plant
                                                                and s1stk.StorageLocation           = i.StorageLocation
                                                                and s1stk.InventorySpecialStockType = i.InventorySpecialStockType
                                                                and s1stk.bucket                    = 'S1'
    left outer join       ZMM_APP04_V4            as dcrstk     on  dcrstk.Material                  = i.Material
                                                                and dcrstk.Plant                     = i.Plant
                                                                and dcrstk.StorageLocation           = i.StorageLocation
                                                                and dcrstk.InventorySpecialStockType = i.InventorySpecialStockType
    left outer join       ZMM_APP04_V5            as incstk     on  incstk.Material                  = i.Material
                                                                and incstk.Plant                     = i.Plant
                                                                and incstk.StorageLocation           = i.StorageLocation
                                                                and incstk.InventorySpecialStockType = i.InventorySpecialStockType
    left outer join       I_ProductValuationBasic as matval     on  matval.Product       = i.Material
                                                                and matval.ValuationArea = i.Plant
  //    left outer join        I_MaterialDocumentItem_2 as matvalmb51  on  matvalmb51.Material       = i.Material
  //                                                              and matvalmb51.Plant = i.Plant
  //                                                              and matvalmb51.StorageLocation = i.StorageLocation
  //                                                              and matvalmb51.InventorySpecialStockType = i.InventorySpecialStockType
  //                                                             and matvalmb51.MaterialBaseUnit = i.MaterialBaseUnit
    left outer join       ZMM_APP04_MA            as matvalmb51 on  matvalmb51.Material                  = i.Material
                                                                and matvalmb51.Plant                     = i.Plant
                                                                and matvalmb51.StorageLocation           = i.StorageLocation
                                                                and matvalmb51.InventorySpecialStockType = i.InventorySpecialStockType
                                                                

//   left outer join ZMM_APP04_SS 
//                          ( P_DisplayCurrency: $parameters.P_DisplayCurrency ) as ss 
//                                                               on  ss.Product                  = matvalmb51.Material
//                                                               and ss.Plant                    = matvalmb51.Plant
//                                                           //  and ss.StorageLocation          = matvalmb51.StorageLocation
//                                                               and ss.InventorySpecialStockType = matvalmb51.InventorySpecialStockType
//                                                               and ss.SDDocument               = matvalmb51.SDDocument
//                                                               and ss.SDDocumentItem           = matvalmb51.SDDocumentItem


    inner join            I_ProductDescription_2  as matdesc    on  matdesc.Product  = i.Material
                                                                and matdesc.Language = $session.system_language
    inner join            I_Plant                 as plnt       on plnt.Plant = i.Plant
    inner join            I_CompanyCode           as ccode      on ccode.CompanyCode = i.CompanyCode
    inner join            I_Product               as prd        on prd.Product = i.Material
    left outer join       I_ProductGroupText_2    as prdgrp     on  prdgrp.Language     = $session.system_language
                                                                and prdgrp.ProductGroup = prd.ProductGroup


{
  key i.Material                                              as Material,
  key i.Plant                                                 as Plant,
  key i.StorageLocation                                       as Sloc,
  key i.CompanyCode                                           as CompanyCode,
  key i.InventorySpecialStockType                             as Stktyp,
  key i.MaterialBaseUnit                                      as Unit,
      //  key i.SDDocument                                            as SalesDocument,
      matdesc.ProductDescription                              as matdesc,
      prd.ProductGroup                                        as matgrp,
      prdgrp.ProductGroupName                                 as mgrptxt,
      plnt.PlantName                                          as plntname,
      ccode.CompanyCodeName                                   as ccname,
      @Semantics.amount.currencyCode: 'Curky'
      matval.StandardPrice                                    as stdprice,
      //      @Semantics.amount.currencyCode: 'Curky'
      //      matvalmb51.TotalGoodsMvtAmtInCCCrcy                         as stdpricemb51,
      @Semantics.amount.currencyCode: 'Curky'
      matval.MovingAveragePrice                               as mvgprice,
      matval.Currency                                         as curky,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      matvalmb51.specialStockQuantity                         as spstockqty,
////      matvalmb51.SDDocument                                   as sddocument,
////      @Semantics.amount.currencyCode: 'Curky'
////      ss.TotalGoodsMvtAmtInCCCrcy                             as totalgmvtamt,
////      matvalmb51.SDDocument                                   as salesorder,
////      matvalmb51.SDDocumentItem                               as salesorderitem,
////      ss.PricePerUnit                                         as priceperunit,
//      @Semantics.quantity.unitOfMeasure: 'Unit'
//      ss.Quantity                                               as ssquantity,
//      ss.NSDM_Display_Currency as nsdm_display_currency,
//      @Semantics.amount.currencyCode: 'NSDM_Display_Currency'
//      ss.StockValueInDisplayCurrency                      as ssstockvalue,
//      ss.SDDocument                                       as sddocument,
//      ss.SDDocumentItem                                   as sditem,
      
      @Semantics.quantity.unitOfMeasure: 'Unit'
      cast(
        case
          when i.InventorySpecialStockType = 'E'
            then matvalmb51.specialStockQuantity
          else
            unstk.totstkqty
        end
        as abap.dec(15,3)
      )                                                       as unstkqty,

      @Semantics.quantity.unitOfMeasure: 'Unit'
      qistk.totstkqty                                         as qistkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      blstk.totstkqty                                         as blstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      trstk.totstkqty                                         as trstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      ( unstk.totstkqty + qistk.totstkqty + blstk.totstkqty ) as ohstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s1stk.incstkqty                                         as s1stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s2stk.incstkqty                                         as s2stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s3stk.incstkqty                                         as s3stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s4stk.incstkqty                                         as s4stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s5stk.incstkqty                                         as s5stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s6stk.incstkqty                                         as s6stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s7stk.incstkqty                                         as s7stkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      //      s8stk.incstkqty                                         as s8stkqty,
      cast(
      case
      when i.InventorySpecialStockType = 'E'
      then matvalmb51.specialStockQuantity
      else
      unstk.totstkqty
      end
      as abap.dec(15,3)
      )                                                       as s8stkqty,

      @Semantics.quantity.unitOfMeasure: 'Unit'
      dcrstk.dcrstkqty                                        as dcrstkqty,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      incstk.incstkqty                                        as incstkqty
      //      @Semantics.quantity.unitOfMeasure: 'Unit'
      //      case
      //      when s8stk.incstkqty > 0 and ( s8stk.incstkqty > dcrstk.dcrstkqty )
      //      then ( s8stk.incstkqty - dcrstk.dcrstkqty )
      //      else  '0'
      //      end as s8qty

}

//where ( unstk.totstkqty + qistk.totstkqty + blstk.totstkqty ) <> 0

group by
  matdesc.ProductDescription,
  prd.ProductGroup,
  prdgrp.ProductGroupName,
  plnt.PlantName,
  ccode.CompanyCodeName,
  i.Material,
  i.Plant,
  i.StorageLocation,
  i.CompanyCode,
  i.InventorySpecialStockType,
  i.MaterialBaseUnit,
  matval.StandardPrice,
  matval.MovingAveragePrice,
  matval.Currency,
  matvalmb51.specialStockQuantity,
////  matvalmb51.SDDocument,
////  matvalmb51.SDDocumentItem,
//  matvalmb51.Batch,
////  ss.TotalGoodsMvtAmtInCCCrcy,
////  ss.SalesOrder,
////  ss.PricePerUnit,
//  ss.SDDocument,
//  ss.SDDocumentItem,
//  ss.Quantity,
//  ss.NSDM_Display_Currency,
//  ss.StockValueInDisplayCurrency, 
  unstk.totstkqty,
  qistk.totstkqty,
  blstk.totstkqty,
  trstk.totstkqty,
  s1stk.incstkqty,
  s2stk.incstkqty,
  s3stk.incstkqty,
  s4stk.incstkqty,
  s5stk.incstkqty,
  s6stk.incstkqty,
  s7stk.incstkqty,
  s8stk.incstkqty,
  dcrstk.dcrstkqty,
  incstk.incstkqty
