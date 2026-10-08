@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ETA table cds view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  view entity ZCDS_ETAtab 
as select from zeta_table as ETAtab

{

    key ETAtab.pono      as pono,
       ETAtab.etadate     as ETADate,
       ETAtab.po          as PO,
       ETAtab.sono1       as Sono1,
       //ETAtab.sono        as Sono1,
       ETAtab.remarks     as Remarks,
       ETAtab.customercode as CustomerCode,
       ETAtab.customername as CustomerName,
       ETAtab.branchname   as Branchname,
       ETAtab.sodate       as Sodate,
       ETAtab.edd         as Edd,
       ETAtab.polineitem as PoLine, 
       @Semantics.user.createdBy: true
       ETAtab.createdby   as Createdby
       
       
}
