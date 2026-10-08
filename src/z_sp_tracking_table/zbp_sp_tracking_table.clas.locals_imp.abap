CLASS lhc_Z_SP_TRACKING_TABLE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR z_sp_tracking_table RESULT result.

    METHODS update FOR DETERMINE ON MODIFY
      IMPORTING keys FOR z_sp_tracking_table~update.

ENDCLASS.

CLASS lhc_Z_SP_TRACKING_TABLE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD update.
**********************************************************************
    data: gt_update type TABLE of ZSP_TB,
          gs_update TYPE ZSP_TB.

**********************************************************************
  READ ENTITIES OF z_sp_tracking_table IN LOCAL MODE
  ENTITY z_sp_tracking_table
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(it_update).

  DATA(is_update) = it_update[ 1 ].
  if is_update-material is NOT INITIAL.
    gs_update-material = is_update-Material.
    gs_update-serialnumber = is_update-serialnumber.
    gs_update-Pws_Bdld = is_update-Pws_Bdld.
    gs_update-cse_bdld = is_update-cse_bdld.
    gs_update-mbd_bdld = is_update-Mbd_Bdld.
    gs_update-heatsink_bdld = is_update-heatsink_bdld.
    gs_update-Ipmi = is_update-Ipmi.
    gs_update-macaddress = is_update-macaddress.
    gs_update-remarks = is_update-remarks.
    gs_update-createdby = is_update-Createdby.

    APPEND gs_update to gt_update.
    zbp_sp_tracking_table=>gt_update = gt_update.
  endif.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_SP_TRACKING_TABLE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_SP_TRACKING_TABLE IMPLEMENTATION.

  METHOD save_modified.

  if zbp_sp_tracking_table=>gt_update is NOT INITIAL.
    DATA(gt_upd) = zbp_sp_tracking_table=>gt_update.
    MODIFY ZSP_TB FROM TABLE @gt_upd.
  ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
