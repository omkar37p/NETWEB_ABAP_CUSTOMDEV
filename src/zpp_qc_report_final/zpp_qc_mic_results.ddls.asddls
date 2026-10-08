@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mic Results'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_QC_MIC_RESULTS 
as select from  I_InspectionResult       as INSRLT
 left outer join I_InspectionCodeText     as ICT on  ICT.InspectionCodeGroup = INSRLT.CharacteristicAttributeCodeGrp
                                                    and ICT.InspectionCode      = INSRLT.CharacteristicAttributeCode
                                                    and ICT.Language            = 'E'
{
   
    key INSRLT.InspectionLot,
    key INSRLT.CharacteristicAttributeCode, 
    INSRLT.InspectionCharacteristic,
     INSRLT.CharacteristicAttributeCodeGrp,
      ICT.InspectionCodeText,
      INSRLT.InspectionResultText
}
