CLASS lhc_ZMM_PurchaseorderETA_RE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZMM_PurchaseorderETA_RE RESULT result.

    METHODS update FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZMM_PurchaseorderETA_RE~update.
    METHODS getdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZMM_PurchaseorderETA_RE~getdata.

ENDCLASS.

CLASS lhc_ZMM_PurchaseorderETA_RE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD update.

**********************************************************************
    DATA: it_update TYPE TABLE OF zeta_table,
          wa_update TYPE zeta_table.

    READ ENTITIES OF zmm_purchaseordereta_re IN LOCAL MODE
    ENTITY ZMM_PurchaseorderETA_RE
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(it_allvalue).

    DATA(gs_update) = it_allvalue[ 1 ].

    MOVE-CORRESPONDING gs_update TO wa_update.
    APPEND wa_update TO it_update.

    zbp_mm_purchaseordereta_re=>gt_update = it_update.


  ENDMETHOD.

  METHOD getdata.
**********************************************************************
    DATA: it_create TYPE TABLE OF zeta_table,
          wa_create TYPE zeta_table.

    READ ENTITIES OF zmm_purchaseordereta_re IN LOCAL MODE
    ENTITY ZMM_PurchaseorderETA_RE
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_create).

    DATA(gs_create) = gt_create[ 1 ].
**********************************************************************
    wa_create-pono = gs_create-PONo.
    wa_create-polineitem = gs_create-POLineItem.
    wa_create-sono = gs_create-SONo.
    wa_create-etadate1 = gs_create-ETADate1.
    wa_create-remark1 = gs_create-Remark1.
    wa_create-customercode1 = gs_create-CustomerCode1.
    wa_create-customername1 = gs_create-CustomerName1.
    wa_create-branchname1 = gs_create-BranchName1.
    wa_create-sodate1    = gs_create-SOdate1.
    wa_create-edd1      = gs_create-edd1.
    wa_create-material = gs_create-Material.
    wa_create-baseunit = gs_create-Baseunit.
    wa_create-productdesc = gs_create-ProductDesc.
    wa_create-taxcode  = gs_create-TaxCode.
    wa_create-podoctype = gs_create-PODoctype.
    wa_create-podocdate = gs_create-PODocdate.
    wa_create-orderqty = gs_create-OrderQTY.
    wa_create-qtytobedelivered = gs_create-QtytobeDelivered.
    wa_create-supplier = gs_create-Supplier.
    wa_create-customercode = gs_create-Customercode.
    wa_create-customername = gs_create-Customername.
    wa_create-branchname = gs_create-Branchname.
    wa_create-sodate   = gs_create-SOdate.
    wa_create-edd     = gs_create-Edd.
    wa_create-sono1        = gs_create-SONo1.
    wa_create-etadate = gs_create-ETADate.
    wa_create-remarks = gs_create-Remarks.
    wa_create-createdby = gs_create-CreatedBy.
    wa_create-po = gs_create-po.

    APPEND wa_create to it_create.
    zbp_mm_purchaseordereta_re=>gt_create = it_create.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMM_PURCHASEORDERETA_RE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMM_PURCHASEORDERETA_RE IMPLEMENTATION.

  METHOD save_modified.

*  if create-zmm_purchaseordereta_re is NOT INITIAL.
    if zbp_mm_purchaseordereta_re=>gt_create is NOT INITIAL.
        DATA(lt_create) = zbp_mm_purchaseordereta_re=>gt_create.
        MODIFY zeta_table FROM TABLE @lt_create.
  endif.
*  ENDIF.

    IF zbp_mm_purchaseordereta_re=>gt_update IS NOT INITIAL.
      DATA(gt_upd) = zbp_mm_purchaseordereta_re=>gt_update.
*    MODIFY ZETA_TABLE FROM TABLE @gt_upd.
      MODIFY zeta_table FROM TABLE @gt_upd.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
