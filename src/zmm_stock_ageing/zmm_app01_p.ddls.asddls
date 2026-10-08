@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Agg - Prod/Plnt/SLoc/Spcl/Bucket'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_APP01_P as select from ZMM_APP01_RV as SS
left outer join I_MaterialStock_2 as MS on  SS.Product = MS.Material
                                and SS.Plant = MS.Plant
                                and SS.StorageLocation = MS.StorageLocation
                                and SS.InventorySpecialStockType = MS.InventorySpecialStockType
//define root view entity ZMM_APP01_P with parameters  P_ReportDate : abap.dats  as select from I_MaterialStock_2 as MS 
//
//left outer join ZMM_APP01_RV as SS               on  SS.Product = MS.Material
//                                                 and SS.Plant = MS.Plant
//                                                 and SS.StorageLocation = MS.StorageLocation
//                                                 and SS.InventorySpecialStockType = MS.InventorySpecialStockType

left outer join I_Plant                 as plnt       on plnt.Plant = MS.Plant
left outer join I_CompanyCode           as ccode      on ccode.CompanyCode = MS.CompanyCode
left outer join I_ProductDescription_2  as matdesc    on  matdesc.Product  = MS.Material
                                                      and matdesc.Language = $session.system_language
left outer join I_StorageLocation       as sloc       on sloc.Plant = MS.Plant
                                                      and sloc.StorageLocation = MS.StorageLocation
left outer join I_InventorySpecialStockTypeT as spclstock   on spclstock.InventorySpecialStockType = MS.InventorySpecialStockType
                                                           and spclstock.Language = $session.system_language                                                                                                                       
left outer join ZMM_APP01_OVERDUE as overdue on overdue.Product = MS.Material
                                    and overdue.Plant = MS.Plant
                                    and overdue.StorageLocation = MS.StorageLocation
                                    and overdue.InventorySpecialStockType = MS.InventorySpecialStockType 


//left outer join ZMM_APP01_OVRDU_P( P_ReportDate: $parameters.P_ReportDate ) as overdue on overdue.Product = MS.Material
//                                                                                   and overdue.Plant = MS.Plant
//                                                                                   and overdue.StorageLocation = MS.StorageLocation
//                                                                                   and overdue.InventorySpecialStockType = MS.InventorySpecialStockType                                                    
{
    key SS. Product,
    key SS.Plant,
    key SS.StorageLocation,
    key SS.InventorySpecialStockType,
    key SS.InventoryStockType,   
    key SS.SDDocument,
    plnt.PlantName as PlantName,
    ccode.CompanyCode as CompanyCode,
    matdesc.ProductDescription as ProductDescription,
    sloc.StorageLocationName as StorageLocationName,
    spclstock.InventorySpecialStockTypeName as InventorySpecialStockTypeName,
    SS.MaterialBaseUnit,
    SS.SDDocumentItem,
    SS.Quantity,
    SS.NSDM_Display_Currency,
    SS.StockValueInDisplayCurrency,
   max( MS.MatlDocLatestPostgDate ) as MatlDocLatestPostgDate,
   overdue.MatlDocLatestPostgDate as ReportingDate,
//   coalesce( overdue.Overdue_Days, 0 ) as Overdue_Days,
     overdue.Overdue_Days,
//    cast( coalesce(overdue.Overdue_Days,0) as abap.int4 ) as Overdue_Days,
               
case
    when overdue.Overdue_Days between 0 and 30
    then SS.Quantity
    else null
end as Quantity_30,

case
    when overdue.Overdue_Days between 0 and 30
    then SS.StockValueInDisplayCurrency
    else null
end as Value_30,

case
    when overdue.Overdue_Days between 31 and 60
    then SS.Quantity
    else null
end as Quantity_60,

case
    when overdue.Overdue_Days between 31 and 60
    then SS.StockValueInDisplayCurrency
    else null
end as Value_60,

case
    when overdue.Overdue_Days between 61 and 90
    then SS.Quantity
    else null
end as Quantity_90,

case
    when overdue.Overdue_Days between 61 and 90
    then SS.StockValueInDisplayCurrency
    else null
end as Value_90,

case
    when overdue.Overdue_Days between 91 and 120
    then SS.Quantity
    else null
end as Quantity_120,

case
    when overdue.Overdue_Days between 91 and 120
    then SS.StockValueInDisplayCurrency
    else null
end as Value_120,

case
    when overdue.Overdue_Days between 121 and 150
    then SS.Quantity
    else null
end as Quantity_150,

case
    when overdue.Overdue_Days between 121 and 150
    then SS.StockValueInDisplayCurrency
    else null
end as Value_150,

case
    when overdue.Overdue_Days between 151 and 180
    then SS.Quantity
    else null
end as Quantity_180,

case
    when overdue.Overdue_Days between 151 and 180
    then SS.StockValueInDisplayCurrency
    else null
end as Value_180,

case
    when overdue.Overdue_Days between 181 and 365
    then SS.Quantity
    else null
end as Quantity_365,

case
    when overdue.Overdue_Days between 181 and 365
    then SS.StockValueInDisplayCurrency
    else null
end as Value_365,

case
    when overdue.Overdue_Days > 365
    then SS.Quantity
    else null
end as Quantity_bucket,

case
    when overdue.Overdue_Days > 365
    then SS.StockValueInDisplayCurrency
    else null
end as Value_bucket
//,

//case
//    when overdue.Overdue_Days between 0 and 100 then 1   -- Red
//    when overdue.Overdue_Days between 101 and 200 then 2-- Orange
//    when overdue.Overdue_Days between 201 and 365 then 3 -- Green
//    else 0
//     end as Criticality


//case 
//    when overdue.Overdue_Days >= 0 
//         and overdue.Overdue_Days <= 100
//        then 1 // Red
// 
//    when overdue.Overdue_Days >= 101 
//         and overdue.Overdue_Days <= 200
//        then 2 // Orange
// 
//    when overdue.Overdue_Days >= 201 
//         and overdue.Overdue_Days <= 365
//        then 3 // Green
// 
//    else null
//end as CRITICALITY
   
//      case
//      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 30
//      then SS.Quantity
//      else null
//      end as Quantity_30,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 30
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_30,
//      
//      case      
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 30 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 60
//      then SS.Quantity
//      else null
//      end as Quantity_60,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 30 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 60
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_60,
//      
//      case
//      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) > 60 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 90
//      then SS.Quantity
//      else null
//      end as Quantity_90,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 60 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 90
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_90,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 90 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 120
//      then SS.Quantity
//      else null
//      end as Quantity_120,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 90 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 120
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_120,
//      
//      case
//      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) > 120 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 150
//      then SS.Quantity
//      else null
//      end as Quantity_150,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 120 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 150
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_150,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 150 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 180
//      then SS.Quantity
//      else null
//      end as Quantity_180,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 150 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 180
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_180,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 180 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 365
//      then SS.Quantity
//      else null
//      end as Quantity_365,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 180 and
//      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 365
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_365,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 365
//      then SS.Quantity
//      else null
//      end as Quantity_bucket,
//      
//      case
//      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 365
//      then SS.StockValueInDisplayCurrency
//      else null
//      end as Value_bucket
} //where overdue.MatlDocLatestPostgDate <= MS.MatlDocLatestPostgDate
group by
    SS. Product,
    SS.Plant,
    SS.StorageLocation,
    SS.InventorySpecialStockType,
    SS.InventoryStockType,
    SS.MaterialBaseUnit,
    SS.SDDocument,
    plnt.PlantName,
    ccode.CompanyCode,
    matdesc.ProductDescription,
    sloc.StorageLocationName,
    spclstock.InventorySpecialStockTypeName,
    SS.SDDocumentItem,
    SS.Quantity,
    SS.NSDM_Display_Currency,
    SS.StockValueInDisplayCurrency,
    overdue.Overdue_Days,
    overdue.MatlDocLatestPostgDate 
