@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROOT VIEW entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity Z_SP_TRACKING_TABLE
  as select from    I_Equipment    as MD
//    inner join      I_MaterialDocumentItem_2 as SIRI on  SIRI.Material             = MD.Material
//                                                     //   and SIRI.MaterialDocument     = MD.MaterialDocument
//                                                     //   and SIRI.MaterialDocumentItem = MD.MaterialDocumentItem
    left outer join zsp_tb                      as TB   on  TB.material     = MD.Material
                                                        and TB.serialnumber = MD.SerialNumber

{
  key MD. Material       as Material,
  key MD. SerialNumber as Serialnumber,
      TB. pws_bdld       as Pws_Bdld,
      TB.cse_bdld        as Cse_Bdld,
      TB. mbd_bdld       as Mbd_Bdld,
      TB. heatsink_bdld  as Heatsink_Bdld,
      TB. ipmi           as Ipmi,
      TB. macaddress     as Macaddress,
      TB. createdby      as Createdby,
      TB.remarks         as Remarks
      // Make association public
}
//*I_MaterialDocumentItem_2
//I_Equipment
