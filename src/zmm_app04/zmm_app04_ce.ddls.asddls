@EndUserText.label: 'Stock Ageing Report - Custom Entity'
@ObjectModel: {
   query: {
        implementedBy: 'ABAP:ZCL_APP04_CE01'
    }
}
@UI: {
  headerInfo: {
    typeName: 'Stock in Age Bucket - Multiple Material',
    typeNamePlural: 'Stock in Age Bucket - Multiple Materials'
  }
}

define custom entity ZMM_APP04_CE
  // with parameters parameter_name : parameter_type
{
      @UI.facet  : [ { id :  'List',
                     purpose        :  #STANDARD,
                     type           :  #IDENTIFICATION_REFERENCE,
                     label          :  'Stocks',
                     position       : 10 }   ]
      @UI.lineItem     : [{ position: 50, label: 'Material'  }]
      @UI.selectionField      : [{position: 20}]
      @UI.identification      : [{position: 50, label: 'Material' }]
      @ObjectModel.text.element: [ 'maktx' ]
  key Material   : matnr;
      @UI.hidden : true
  key SONO       : abap.numc( 4 );
      @UI.lineItem     : [{ position: 20, label: 'Plant'  }]
      @UI.identification      : [{position: 20, label: 'Plant' }]
      @UI.selectionField      : [{position: 20}]
      @ObjectModel.text.element: [ 'plntname' ]
  key Plant      : werks_d;
      @UI.lineItem     : [{ position: 30, label: 'Stor. Loc'  }]
      @UI.identification      : [{position: 30, label: 'Stor. Loc' }]
      @UI.selectionField      : [{position: 30}]
  key Sloc       : lgort_d;
      @UI.lineItem     : [{ position: 40, label: 'Special Stock'  }]
      @UI.identification      : [{position: 40, label: 'Special Stock' }]
  key Stktyp     : abap.char( 1 );
      @UI.hidden : true
  key Unit       : meins;
      @UI.hidden : true
      maktx      : maktx;
      @UI.lineItem     : [{ position: 60, label: 'Material Group'  }]
      @UI.identification      : [{position: 60, label: 'Material Group' }]
      @ObjectModel.text.element: [ 'wgbez' ]
      matkl      : matkl;
      @UI.hidden : true
      wgbez      : wgbez;
      @UI.lineItem     : [{ position: 10, label: 'Company Code'  }]
      @UI.identification      : [{position: 10, label: 'Company Code' }]
      @ObjectModel.text.element: [ 'butxt' ]
      bukrs      : bukrs;
      @UI.hidden : true
      butxt      : butxt;
      @UI.hidden : true
      plntname   : abap.char( 30 );
      @UI.hidden : true
      @UI.lineItem     : [{ position: 70, label: 'Unrestricted Stock'  }]
      @UI.identification      : [{position: 70, label: 'Unrestricted Stock' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      unstkqty   : abap.quan( 10, 3 );
      @UI.hidden : true
      @UI.lineItem     : [{ position: 80, label: 'Stock in Quality Inspection'  }]
      @UI.identification      : [{position: 80, label: 'Stock in Quality Inspection' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      qistkqty   : abap.quan( 10, 3 );
      @UI.hidden : true
      @UI.lineItem     : [{ position: 90, label: 'Blocked Stock'  }]
      @UI.identification      : [{position: 90, label: 'Blocked Stock' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      blstkqty   : abap.quan( 10, 3 );
      @UI.hidden : true
      @UI.lineItem     : [{ position: 100, label: 'Stock in Transit'  }]
      @UI.identification      : [{position: 100, label: 'Stock in Transit' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      trstkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 110, label: 'Total Stock'  }]
      @UI.identification      : [{position: 110, label: 'Total Stock' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      ohstkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 115, label: 'Total Stock Value'  }]
      @UI.identification      : [{position: 115, label: 'Total Stock Value' }]
      @Semantics.amount.currencyCode: 'currency'
      ohstkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 120, label: '0-30(Qty)'  }]
      @UI.identification      : [{position: 120, label: '0-30(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s1stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 125, label: '0-30(in Rs)'  }]
      @UI.identification      : [{position: 125, label: '0-30(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s1stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 130, label: '30-60(Qty)'  }]
      @UI.identification      : [{position: 130, label: '30-60(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s2stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 135, label: '30-60(in Rs)'  }]
      @UI.identification      : [{position: 135, label: '30-60(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s2stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 140, label: '60-90(Qty)'  }]
      @UI.identification      : [{position: 140, label: '60-90(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s3stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 145, label: '60-90(in Rs)'  }]
      @UI.identification      : [{position: 145, label: '60-90(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s3stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 150, label: '90-120(Qty)'  }]
      @UI.identification      : [{position: 150, label: '90-120(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s4stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 155, label: '90-120(in Rs)'  }]
      @UI.identification      : [{position: 155, label: '90-120(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s4stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 160, label: '120-150(Qty)'  }]
      @UI.identification      : [{position: 160, label: '120-150(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s5stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 165, label: '120-150(in Rs)'  }]
      @UI.identification      : [{position: 165, label: '120-150(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s5stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 170, label: '150-180(Qty)'  }]
      @UI.identification      : [{position: 170, label: '150-180(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s6stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 175, label: '150-180(in Rs)'  }]
      @UI.identification      : [{position: 175, label: '150-180(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s6stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 180, label: '180-365(Qty)'  }]
      @UI.identification      : [{position: 180, label: '180-365(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s7stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 185, label: '180-365(in Rs)'  }]
      @UI.identification      : [{position: 185, label: '180-365(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s7stkval   : abap.curr( 15, 2 );
      @UI.lineItem     : [{ position: 190, label: 'Beyond 1 year(Qty)'  }]
      @UI.identification      : [{position: 190, label: 'Beyond 1 year(Qty)' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      s8stkqty   : abap.quan( 10, 3 );
      @UI.lineItem     : [{ position: 195, label: 'Beyond 1 year(in Rs)'  }]
      @UI.identification      : [{position: 195, label: 'Beyond 1 year(in Rs)' }]
      @Semantics.amount.currencyCode: 'currency'
      s8stkval   : abap.curr( 15, 2 );
      currency   : waers;
      @UI.lineItem     : [{ position: 200, label: 'SalesOrder'  }]
      @UI.identification      : [{position: 200, label: 'SalesOrder' }]
      SalesOrder : abap.char( 30 );
      @UI.lineItem     : [{ position: 210, label: 'SalesOrderItem'  }]
      @UI.identification      : [{position: 210, label: 'SalesOrderItem' }]
      SalesOrderItem : abap.char( 30 );

}
