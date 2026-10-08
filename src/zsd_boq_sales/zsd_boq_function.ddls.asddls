@EndUserText.label: 'BOQ Sales Report Table Function'
@ClientHandling: { type: #CLIENT_DEPENDENT, algorithm: #SESSION_VARIABLE }
define table function ZSD_BOQ_FUNCTION                                                                          //All Required Fields for Output
  with parameters
    FromDate   : abap.dats,
    ToDate     : abap.dats,
    SalesONumber : abap.char( 10 )
returns
{
  key mandt            : abap.clnt;
  key SalesOrderNumber : abap.char( 10 );
  key SalesOrderItem   : abap.numc( 6 );
//  key ScheduleLine     : abap.numc( 4 );      //No Need
  key ItemLevel01      : abap.int2;
  key ItemLevel02      : abap.int2;
  key ItemLevel03      : abap.int2;
      SalesOrderStatus : abap.char( 40 );
      CustomerName     : abap.char( 80 );
      SalesDate        : abap.dats;
      DeliveryDate     : abap.dats;
//      ScheduleCategory : abap.char( 2 );      //No Need
      FGNumber         : abap.char( 40 );
      FGName           : abap.char( 60 );
      FGBaseQty        : abap.dec( 13, 3 );
      FGQty            : abap.dec( 13, 3 );
//      ScheduleQuantity : abap.dec( 13, 3 );   //No Need
      SFGVariant       : abap.char( 2 );
      SFGNumber        : abap.char( 40 );
      SFGName          : abap.char( 60 );
      SFGBaseQty       : abap.dec( 13, 3 );
      SFGQty           : abap.dec( 13, 3 );
      KITBOQVariant    : abap.char( 2 );
      KITBOQ           : abap.char( 40 );
      KITBOQName       : abap.char( 60 );
      KITBOQQty        : abap.dec( 13, 3 );
      SalesHead        : abap.char( 80 );
      SalesPerson      : abap.char( 80 );
      BranchName       : abap.char( 40 );
      BillStatus       : abap.char( 40 );
      
}
implemented by method ZCL_BOQ_SALES_RPT=>GET_DATA;