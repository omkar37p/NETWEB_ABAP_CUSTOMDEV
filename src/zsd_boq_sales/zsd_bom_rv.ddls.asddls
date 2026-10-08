@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Sales Report BOM Details RV'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{ serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }
define view entity ZSD_BOM_RV with parameters Material : abap.char( 40 ), Plant : abap.char( 4 )                    //Input Parameters
as select from I_MaterialBOMLink as MBL                                                                             //To get BOM ID of input Material
//left outer join I_BillOfMaterialItemBasic as BOMI on BOMI.BillOfMaterial = MBL.BillOfMaterial                       //To get Material Components of input Material
//                                                     and BOMI.BillOfMaterialCategory = MBL.BillOfMaterialCategory
left outer join I_BillOfMaterialHeaderDEX_2 as BOM on BOM.BillOfMaterial = MBL.BillOfMaterial                       //To get BOM Header Details
                                                    and BOM.BillOfMaterialCategory = MBL.BillOfMaterialCategory
                                                    and BOM.BillOfMaterialVariant = MBL.BillOfMaterialVariant
                                                    and BOM.BillOfMaterialVariantUsage = MBL.BillOfMaterialVariantUsage
left outer join I_BillOfMaterialItemDEX_3 as BOMI on BOMI.BillOfMaterial = MBL.BillOfMaterial                       //To get Material Components of input Material
                                                     and BOMI.BillOfMaterialCategory = MBL.BillOfMaterialCategory
                                                     and BOMI.BillOfMaterialVariant = MBL.BillOfMaterialVariant
left outer join I_ProductDescription as PD on PD.Product = BOMI.BillOfMaterialComponent and PD.Language = 'E'       //To get Material Component Description                                    
{
    key MBL.Material as MaterialNum,
    key MBL.BillOfMaterialVariant as Variant,                                                                                
    key BOMI.BillOfMaterialComponent as MaterialComponent,                                                         
        PD.ProductDescription as ComponentDescription,
        BOM.BOMHeaderBaseUnit as HdrUnit,
        @Semantics.quantity: { unitOfMeasure: 'HdrUnit' }
        BOM.BOMHeaderQuantityInBaseUnit as MaterialQty,                                                             
        BOMI.BillOfMaterialItemUnit as Unit,                                                                      
        @Semantics.quantity: { unitOfMeasure: 'Unit' }
        BOMI.BillOfMaterialItemQuantity as ComponentQty                                                           
} where MBL.Material = $parameters.Material and MBL.Plant = $parameters.Plant                                       //Fetching BOM ID Based on input Material and Plant
    and MBL.BillOfMaterialVariantUsage = '1'                                                                        //For Production BOM Usage only
