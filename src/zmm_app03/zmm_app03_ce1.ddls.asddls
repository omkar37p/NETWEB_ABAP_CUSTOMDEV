@EndUserText.label: 'Stock Ageing Report - Custom Entity'
@Search.searchable: true
@ObjectModel: {
   query: {
        implementedBy: 'ABAP:ZCL_APP03_CE01'
    }
}
@UI: {
  headerInfo: {
    typeName: 'Stock in Age Bucket - Multiple Material',
    typeNamePlural: 'Stock in Age Bucket - Multiple Materials'
//    title: { value: 'Material' }
//    description: { value: 'MATERIAL' }
  }
}

define custom entity ZMM_APP03_CE1
  // with parameters parameter_name : parameter_type
{
      @UI.facet: [ { id :  'List',
                     purpose        :  #STANDARD,
                     type           :  #IDENTIFICATION_REFERENCE,
                     label          :  'Stocks',
                     position       : 10 }   ]
      @UI.lineItem     : [{ position: 10, label: 'Material'  }]
      @UI.selectionField      : [{position: 10}]
      @UI.identification      : [{position: 10, label: 'Material' }]
      //      @UI.textArrangement: #TEXT_FIRST
      @Search.defaultSearchElement : true
  key Material : matnr;
      @UI.lineItem     : [{ position: 20, label: 'Plant'  }]
      @UI.identification      : [{position: 20, label: 'Plant' }]
      @UI.selectionField      : [{position: 20}]
  key Plant    : werks_d;
      @UI.lineItem     : [{ position: 30, label: 'Stor. Loc'  }]
      @UI.identification      : [{position: 30, label: 'Stor. Loc' }]
      @UI.selectionField      : [{position: 30}]
  key Sloc     : lgort_d;
      @UI.lineItem     : [{ position: 40, label: 'Special Stock'  }]
      @UI.identification      : [{position: 40, label: 'Special Stock' }]
  key Stktyp   : abap.char(1);
      @UI.hidden:true
  key Unit     : meins;
      @UI.selectionField      : [{position: 40}]
      @EndUserText.label: 'Report Date'
      Rptdate  : bldat;
      @UI.lineItem     : [{ position: 50, label: 'Unrestricted Stock'  }]
      @UI.identification      : [{position: 50, label: 'Unrestricted Stock' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      unstkqty : menge_d;
      @UI.lineItem     : [{ position: 60, label: 'Stock in Quality Inspection'  }]
      @UI.identification      : [{position: 60, label: 'Stock in Quality Inspection' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      qistkqty : menge_d;
      @UI.lineItem     : [{ position: 70, label: 'Blocked Stock'  }]
      @UI.identification      : [{position: 70, label: 'Blocked Stock' }]
      @Semantics.quantity.unitOfMeasure: 'Unit'
      blstkqty : menge_d;



}
