@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Special Stock Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_APP04_SST
  with parameters
    P_DisplayCurrency : nsdm_display_currency
as select from I_StockQuantityCurrentValue_2(
                    P_DisplayCurrency: $parameters.P_DisplayCurrency
               ) as SQCV
{
    /* Keys */
    key SQCV.Product,
    key SQCV.Plant,
    key SQCV.StorageLocation,
    key SQCV.Batch,
    key SQCV.InventorySpecialStockType,

    /* Stock info */
    SQCV.InventoryStockType,
     @Semantics.quantity.unitOfMeasure: 'Unit'
    SQCV.MatlWrhsStkQtyInMatlBaseUnit as Quantity,
    SQCV.MaterialBaseUnit as Unit,
    SQCV.SDDocument,
    SQCV.SDDocumentItem,

    /* Display currency */
    $parameters.P_DisplayCurrency as NSDM_Display_Currency,

    /* Display amount */
    @Semantics.amount.currencyCode: 'NSDM_Display_Currency'
    SQCV.StockValueInDisplayCurrency
}

where SQCV.InventorySpecialStockType = 'E' and SQCV.InventoryStockType = '01'and SQCV.StockValueInDisplayCurrency <> 0
