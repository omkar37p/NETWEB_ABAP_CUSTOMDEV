@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for BOQ Sales Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOQ_PV1 provider contract transactional_query
  as projection on ZBOQ_RV
{
    key SalesOrder,
    key SalesOrderItem,
    key ScheduleLine,
    SOStatus,
    CustomerName,
    SODate,
    DeliveryDate,
    FGNo,
    FGDescription,
    SFGNo,
    SFGDescription,
    SOUnit,
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    OrderQuantity,
    @Semantics.quantity: { unitOfMeasure: 'SOUnit' }
    TotalOrderQuantity,
    KITBOQ,
    KITBOQName,
    BOQQty,
    SalesHead,
    BranchName,
    BillStatus,
    SFGNo1
}
