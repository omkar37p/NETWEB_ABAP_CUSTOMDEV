@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection view'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define root view entity Z_SP_TRACKING_TABLE_PV 
provider contract transactional_query
as projection on Z_SP_TRACKING_TABLE
{
    key Material,
    @Search.defaultSearchElement: true
    key Serialnumber,
    Pws_Bdld,
    Cse_Bdld,
    Mbd_Bdld,
    Heatsink_Bdld,
    Ipmi,
    Macaddress,
    Createdby,
    Remarks
}
