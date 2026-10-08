CLASS zcl_app04_ce01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APP04_CE01 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).

      DATA: lt_outdata   TYPE TABLE OF zmm_app04_ce,
            ls_outdata   LIKE LINE OF lt_outdata,
            lt_finaldata TYPE TABLE OF zmm_app04_ce,
            ls_finaldata LIKE LINE OF lt_outdata.


      DATA: lv_diffqty1 TYPE menge_d,
            lv_diffqty2 TYPE menge_d,
            lv_diffqty3 TYPE menge_d,
            lv_diffqty4 TYPE menge_d,
            lv_diffqty5 TYPE menge_d,
            lv_diffqty6 TYPE menge_d,
            lv_diffqty7 TYPE menge_d,
            lv_diffqty8 TYPE menge_d,
            lv_price    TYPE zmm_app04_ce-ohstkval,
            lv_stock    TYPE zmm_app04_ce-ohstkqty,
            lv_end      TYPE c.

      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0
                                  ELSE lv_top ).

      TRY.
          DATA(lt_clause)        = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range.
          DATA(lvere) = 1.
          "handle exception
      ENDTRY.
      DATA(lt_parameter)     = io_request->get_parameters( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).

      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
          DATA(lvere2) = 1.

      ENDTRY.

****************************Data selection and business logics goes here*********************************
*      LOOP AT lt_parameter ASSIGNING FIELD-SYMBOL(<fs_p>).
*        CASE <fs_p>-parameter_name.
*          WHEN 'P_KEYDATE'.   DATA(p_keydate) = <fs_p>-value.
*        ENDCASE.
*      ENDLOOP.

      LOOP AT lt_filter_cond INTO DATA(ls_filter_cond).
        IF ls_filter_cond-name = 'SLOC'.
          DATA(lt_storagelocation) = ls_filter_cond-range[].
        ELSEIF  ls_filter_cond-name = 'MATERIAL'.
          DATA(lt_material) = ls_filter_cond-range[].
        ELSEIF  ls_filter_cond-name = 'PLANT'.
          DATA(lt_plant) = ls_filter_cond-range[].
*        ELSEIF  ls_filter_cond-name = 'COMPANYCODE'.
*          DATA(lt_bukrs) = ls_filter_cond-range[].
        ENDIF.
      ENDLOOP.

      SELECT * FROM zmm_app04_rv
      WHERE Material IN @lt_material
      AND Plant IN @lt_plant
      AND Sloc IN @lt_storagelocation
      INTO TABLE @DATA(lt_stckagg).

*      SELECT * FROM I_ProductValuationBasic WITH PRIVILEGED ACCESS
*      WHERE  Product IN @lt_material
*      INTO TABLE @DATA(it_iproduct).

*      LOOP AT lt_stckagg INTO DATA(ls_stckagg).
*        IF ls_stckagg-stdprice IS NOT INITIAL.
*          lv_price = ls_stckagg-stdprice.
*        ELSE.
*          lv_price = ls_stckagg-mvgprice.
*        ENDIF.
*********************************** Special Stock Type (Manoj) ******************************************
      LOOP AT lt_stckagg INTO DATA(ls_stckagg) .
        ls_outdata-sono = ls_outdata-sono + 1.

        IF ls_stckagg-stktyp = 'E'.
          lv_price = ls_stckagg-priceperunit.
          lv_stock = ls_stckagg-spstockqty.
        ELSE.
          lv_stock = ls_stckagg-unstkqty + ls_stckagg-qistkqty + ls_stckagg-blstkqty + ls_stckagg-trstkqty.
          IF ls_stckagg-mvgprice IS NOT INITIAL.
            lv_price = ls_stckagg-mvgprice.
          ELSE.
            lv_price = ls_stckagg-stdprice.
          ENDIF.
        ENDIF.

***************************************************************************************
*        IF ls_stckagg-mvgprice IS NOT INITIAL.
*          lv_price = ls_stckagg-mvgprice.
*        ELSE.
*          lv_price = ls_stckagg-stdprice.
*        ENDIF.

        ls_outdata-Material = ls_stckagg-Material.
        ls_outdata-maktx = ls_stckagg-matdesc.
        ls_outdata-matkl = ls_stckagg-matgrp.
        ls_outdata-wgbez = ls_stckagg-mgrptxt.
        ls_outdata-Plant = ls_stckagg-Plant.
        ls_outdata-plntname = ls_stckagg-plntname.
        ls_outdata-SalesOrder = ls_stckagg-SalesOrder.
        ls_outdata-SalesOrderItem = ls_stckagg-salesorderitem.
        ls_outdata-Sloc = ls_stckagg-Sloc.
        ls_outdata-Stktyp = ls_stckagg-Stktyp.
        ls_outdata-Unit = ls_stckagg-Unit.
        ls_outdata-currency = ls_stckagg-curky.
        ls_outdata-bukrs = ls_stckagg-CompanyCode.
        ls_outdata-butxt = ls_stckagg-ccname.
        ls_outdata-unstkqty = ls_stckagg-unstkqty.
        ls_outdata-qistkqty = ls_stckagg-qistkqty.
        ls_outdata-blstkqty = ls_stckagg-blstkqty.
        ls_outdata-trstkqty = ls_stckagg-trstkqty.
*        ls_outdata-ohstkqty = ls_stckagg-unstkqty + ls_stckagg-qistkqty + ls_stckagg-blstkqty + ls_stckagg-trstkqty.
        ls_outdata-ohstkqty = lv_stock.
*        ls_outdata-ohstkqty = ls_stckagg-unstkqty.
        ls_outdata-ohstkval = ls_outdata-ohstkqty * lv_price.

**********************************************************************
        IF ls_stckagg-dcrstkqty > 0.
**********************************************************************
          IF ls_stckagg-s8stkqty > 0.
            IF ls_stckagg-s8stkqty > ls_stckagg-dcrstkqty.
***********************************************Manoj**************************************************
*              ls_outdata-s8stkqty = ls_stckagg-s8stkqty - ls_stckagg-dcrstkqty.
******************************************************************************************************
              ls_outdata-s7stkqty = ls_stckagg-s7stkqty.
              ls_outdata-s6stkqty = ls_stckagg-s6stkqty.
              ls_outdata-s5stkqty = ls_stckagg-s5stkqty.
              ls_outdata-s4stkqty = ls_stckagg-s4stkqty.
              ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
              ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
              ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
              ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
              ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
              ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
              ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
              ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
              ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
              ls_outdata-s7stkval = ls_outdata-s7stkqty * lv_price.
***********************************************Manoj**************************************************
*             ls_outdata-s8stkval = ls_outdata-s8stkqty * lv_price.
******************************************************************************************************
              lv_end = 'X'.
            ELSE.
              IF ls_stckagg-s8stkqty > ls_stckagg-dcrstkqty.
                lv_diffqty8 = ls_stckagg-s8stkqty - ls_stckagg-dcrstkqty.
              ELSEIF ls_stckagg-s8stkqty < ls_stckagg-dcrstkqty.
                lv_diffqty8 = ls_stckagg-dcrstkqty - ls_stckagg-s8stkqty.
              ENDIF.
              ls_outdata-s8stkqty = 0.
              ls_outdata-s8stkval = ls_outdata-s8stkqty * lv_price.
            ENDIF.
          ELSE.
            ls_outdata-s8stkqty = 0.
            ls_outdata-s8stkval = ls_outdata-s8stkqty * lv_price.
            lv_diffqty8 = ls_stckagg-dcrstkqty.
          ENDIF.
******************************************Manoj*********************************************************
*for beyond 1 year Qty
IF ls_stckagg-s8stkqty > 0.
IF ls_stckagg-s8stkqty IS NOT INITIAL.
ls_outdata-s8stkqty = ls_stckagg-s8stkqty .
ls_outdata-s8stkval = ls_outdata-s8stkqty * lv_price.
lv_end = 'X'.
ENDIF.
ENDIF.

********************************************************************************************************
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s7stkqty > 0.
              IF lv_diffqty8 > 0.
               IF ls_stckagg-s7stkqty > lv_diffqty8.
                  ls_outdata-s7stkqty = ls_stckagg-s7stkqty - lv_diffqty8.
                  ls_outdata-s6stkqty = ls_stckagg-s6stkqty.
                  ls_outdata-s5stkqty = ls_stckagg-s5stkqty.
                  ls_outdata-s4stkqty = ls_stckagg-s4stkqty.
                  ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                  ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
                  ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
                  ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
                  ls_outdata-s7stkval = ls_outdata-s7stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s7stkqty > lv_diffqty8.
                    lv_diffqty7 = ls_stckagg-s7stkqty - lv_diffqty8.
                  ELSEIF ls_stckagg-s7stkqty < lv_diffqty8.
                    lv_diffqty7 =  lv_diffqty8 - ls_stckagg-s7stkqty.
                  ENDIF.
                  ls_outdata-s7stkqty = 0.
                  ls_outdata-s7stkval = ls_outdata-s7stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s7stkqty = 0.
              ls_outdata-s7stkval = ls_outdata-s7stkqty * lv_price.
              lv_diffqty7 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s6stkqty > 0.
              IF lv_diffqty7 > 0.
                IF ls_stckagg-s6stkqty > lv_diffqty7.
                  ls_outdata-s6stkqty = ls_stckagg-s6stkqty - lv_diffqty7.
                  ls_outdata-s5stkqty = ls_stckagg-s5stkqty.
                  ls_outdata-s4stkqty = ls_stckagg-s4stkqty.
                  ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                  ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
                  ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
                  ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s6stkqty > lv_diffqty7.
                    lv_diffqty6 = ls_stckagg-s6stkqty - lv_diffqty7.
                  ELSEIF ls_stckagg-s6stkqty < lv_diffqty7.
                    lv_diffqty6 = lv_diffqty7 - ls_stckagg-s6stkqty.
                  ENDIF.
                  ls_outdata-s6stkqty = 0.
                  ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s6stkqty = 0.
              ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
              lv_diffqty6 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s5stkqty > 0.
              IF lv_diffqty6 > 0.
                IF ls_stckagg-s5stkqty > lv_diffqty6.
                  ls_outdata-s5stkqty = ls_stckagg-s5stkqty - lv_diffqty6.
                  ls_outdata-s4stkqty = ls_stckagg-s4stkqty.
                  ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                  ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
                  ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s5stkqty > lv_diffqty6.
                    lv_diffqty5 = ls_stckagg-s5stkqty - lv_diffqty6.
                  ELSEIF ls_stckagg-s5stkqty < lv_diffqty6.
                    lv_diffqty5 = lv_diffqty6 - ls_stckagg-s5stkqty.
                  ENDIF.
                  ls_outdata-s5stkqty = 0.
                  ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s5stkqty = 0.
              ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
              lv_diffqty5 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s4stkqty > 0.
              IF lv_diffqty5 > 0.
                IF ls_stckagg-s4stkqty > lv_diffqty5.
                  ls_outdata-s4stkqty = ls_stckagg-s4stkqty - lv_diffqty5.
                  ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                  ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s4stkqty > lv_diffqty5.
                    lv_diffqty4 = ls_stckagg-s4stkqty - lv_diffqty5.
                  ELSEIF ls_stckagg-s4stkqty < lv_diffqty5.
                    lv_diffqty4 = lv_diffqty5 - ls_stckagg-s4stkqty.
                  ENDIF.
                  ls_outdata-s4stkqty = 0.
                  ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s4stkqty = 0.
              ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
              lv_diffqty4 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s3stkqty > 0.
              IF lv_diffqty4 > 0.
                IF ls_stckagg-s3stkqty > lv_diffqty4.
                  ls_outdata-s3stkqty = ls_stckagg-s3stkqty - lv_diffqty4.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s3stkqty > lv_diffqty4.
                    lv_diffqty3 = ls_stckagg-s3stkqty - lv_diffqty4.
                  ELSEIF ls_stckagg-s3stkqty < lv_diffqty4.
                    lv_diffqty3 = lv_diffqty4 - ls_stckagg-s3stkqty.
                  ENDIF.
                  ls_outdata-s3stkqty = 0.
                  ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s3stkqty = 0.
              ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
              lv_diffqty3 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s2stkqty > 0.
              IF lv_diffqty3 > 0.
                IF ls_stckagg-s2stkqty > lv_diffqty3.
                  ls_outdata-s2stkqty = ls_stckagg-s2stkqty - lv_diffqty3.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                  lv_end = 'X'.
                ELSE.
                  IF ls_stckagg-s2stkqty > lv_diffqty3.
                    lv_diffqty2 = ls_stckagg-s2stkqty - lv_diffqty3.
                  ELSEIF ls_stckagg-s2stkqty < lv_diffqty3.
                    lv_diffqty2 = lv_diffqty3 - ls_stckagg-s2stkqty.
                  ENDIF.
                  ls_outdata-s2stkqty = 0.
                  ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s2stkqty = 0.
              ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
              lv_diffqty2 = ls_stckagg-dcrstkqty.
            ENDIF.
          ENDIF.
**********************************************************************
          IF lv_end IS INITIAL.
            IF ls_stckagg-s1stkqty > 0.
              IF lv_diffqty2 > 0.
                IF ls_stckagg-s1stkqty > lv_diffqty2.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty - lv_diffqty2.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.

                ELSE.
                  ls_outdata-s1stkqty = ls_stckagg-s1stkqty + lv_diffqty2.
                  ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
                ENDIF.
              ENDIF.
            ELSE.
              ls_outdata-s1stkqty = 0.
              ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
            ENDIF.
          ENDIF.
**********************************************************************
        ELSE.
          ls_outdata-s8stkqty = ls_stckagg-s8stkqty.
          ls_outdata-s7stkqty = ls_stckagg-s7stkqty.
          ls_outdata-s6stkqty = ls_stckagg-s6stkqty.
          ls_outdata-s5stkqty = ls_stckagg-s5stkqty.
          ls_outdata-s4stkqty = ls_stckagg-s4stkqty.
          ls_outdata-s3stkqty = ls_stckagg-s3stkqty.
          ls_outdata-s2stkqty = ls_stckagg-s2stkqty.
          ls_outdata-s1stkqty = ls_stckagg-s1stkqty.
          ls_outdata-s1stkval = ls_outdata-s1stkqty * lv_price.
          ls_outdata-s2stkval = ls_outdata-s2stkqty * lv_price.
          ls_outdata-s3stkval = ls_outdata-s3stkqty * lv_price.
          ls_outdata-s4stkval = ls_outdata-s4stkqty * lv_price.
          ls_outdata-s5stkval = ls_outdata-s5stkqty * lv_price.
          ls_outdata-s6stkval = ls_outdata-s6stkqty * lv_price.
          ls_outdata-s7stkval = ls_outdata-s7stkqty * lv_price.
          ls_outdata-s8stkval = ls_outdata-s8stkqty * lv_price.
        ENDIF.
**********************************************************************
        APPEND ls_outdata TO lt_outdata.
        CLEAR: lv_diffqty8,lv_diffqty7,lv_diffqty6,lv_diffqty5,lv_diffqty4,lv_diffqty3,lv_diffqty2,lv_diffqty1,lv_price,lv_end.
      ENDLOOP.
**********************************************************************

      SORT lt_outdata BY material plant sloc .
      lv_max_rows = lv_skip + lv_top.
      IF lv_skip > 0.
        lv_skip = lv_skip + 1.
      ENDIF.

      CLEAR lt_finaldata.
      LOOP AT lt_outdata ASSIGNING FIELD-SYMBOL(<lfs_out_line_item>) FROM lv_skip TO lv_max_rows.
        ls_finaldata = <lfs_out_line_item>.
        APPEND ls_finaldata TO lt_finaldata.
      ENDLOOP.

      io_response->set_total_number_of_records( lines( lt_outdata ) ).
      io_response->set_data( lt_finaldata ).


    ENDIF.
  ENDMETHOD.
ENDCLASS.
