@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Date'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZMM_APP04_D as select from ZMM_APP04_SS as SS
left outer join I_MaterialStock_2 as MS on  SS.Product = MS.Material
                                and SS.Plant = MS.Plant
                                and SS.StorageLocation = MS.StorageLocation
                                and SS.InventorySpecialStockType = MS.InventorySpecialStockType
//                               and SS.SDDocumentItem = MS.SDDocumentItem
{
    key SS. Product,
    SS.Plant,
    SS.StorageLocation,
    SS.InventorySpecialStockType,
    SS.InventoryStockType,
    SS.MaterialBaseUnit,
    SS.SDDocument,
    SS.SDDocumentItem,
    SS.Quantity,
    SS.NSDM_Display_Currency,
    SS.StockValueInDisplayCurrency,
   max( MS.MatlDocLatestPostgDate ) as MatlDocLatestPostgDate,
   
      case
      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 30
      then SS.Quantity
      else null
      end as Quantity_30,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 30
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_30,
      
      case      
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 30 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 60
      then SS.Quantity
      else null
      end as Quantity_60,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 30 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 60
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_60,
      
      case
      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) > 60 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 90
      then SS.Quantity
      else null
      end as Quantity_90,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 60 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 90
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_90,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 90 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 120
      then SS.Quantity
      else null
      end as Quantity_120,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 90 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 120
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_120,
      
      case
      when dats_days_between(max(MS.MatlDocLatestPostgDate), $session.system_date ) > 120 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 150
      then SS.Quantity
      else null
      end as Quantity_150,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 120 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 150
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_150,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 150 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 180
      then SS.Quantity
      else null
      end as Quantity_180,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 150 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 180
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_180,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 180 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 365
      then SS.Quantity
      else null
      end as Quantity_365,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 180 and
      dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) <= 365
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_365,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 365
      then SS.Quantity
      else null
      end as Quantity_bucket,
      
      case
      when dats_days_between( max(MS.MatlDocLatestPostgDate), $session.system_date ) > 365
      then SS.StockValueInDisplayCurrency
      else null
      end as Value_bucket
}
group by
    SS. Product,
    SS.Plant,
    SS.StorageLocation,
    SS.InventorySpecialStockType,
    SS.InventoryStockType,
    SS.MaterialBaseUnit,
    SS.SDDocument,
    SS.SDDocumentItem,
    SS.Quantity,
    SS.NSDM_Display_Currency,
    SS.StockValueInDisplayCurrency
//    MS.MatlDocLatestPostgDate


