@EndUserText.label: 'Inventory Ageing Report - Table function'
@ClientHandling: { type: #CLIENT_DEPENDENT, algorithm: #SESSION_VARIABLE }
define table function ZMM_APP01_TF01
  //with parameters parameter_name : parameter_type
returns
{
  key mandt      : abap.clnt;
  key matnr      : matnr40;
  key werks      : werks_d;
  key lgort      : lgort_d;
  key spstktype  : abap.char( 1 );
      maktx      : maktx;
      plntname   : abap.char( 30 );
      slocname   : abap.char( 20 );
      spstkname  : abap.char( 30 );
      @Semantics.quantity.unitOfMeasure: 'unit'
      stkonhand  : menge_d;
      @Semantics.quantity.unitOfMeasure: 'unit'
      stktransit : menge_d;
      unit       : meins;

}
implemented by method
  zcl_app01_invagerpt=>GET_DATA;