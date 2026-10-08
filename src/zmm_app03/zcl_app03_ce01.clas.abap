CLASS zcl_app03_ce01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APP03_CE01 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).
      DATA(lv_top)   = io_request->get_paging( )->get_page_size( ).
      DATA(lv_top1)   = io_request->get_paging( )->get_offset( ).

      DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
      DATA(requested_fields)  = io_request->get_requested_elements( ).
      DATA(lt_sort)    = io_request->get_sort_elements( ).



      DATA : lv_orderby TYPE string.
      LOOP AT lt_sort INTO DATA(ls_sort).
        IF ls_sort-descending = abap_true.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } DESCENDING '|.
        ELSE.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } ASCENDING '|.
        ENDIF.
      ENDLOOP.
      IF lv_orderby IS INITIAL.
        lv_orderby = 'mat~Material'.
      ENDIF.

      DATA(lv_conditions) = io_request->get_filter(  )->get_as_sql_string(  ).

      DATA(lv_rptdate) = CONV d( xco_cp=>sy->date( )->as( xco_cp_time=>format->abap )->value ).

    ENDIF.
  ENDMETHOD.
ENDCLASS.
