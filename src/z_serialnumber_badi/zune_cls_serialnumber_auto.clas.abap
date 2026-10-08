CLASS zune_cls_serialnumber_auto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_losn_ser_num_int_create .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZUNE_CLS_SERIALNUMBER_AUTO IMPLEMENTATION.


  METHOD if_losn_ser_num_int_create~get_serial_numbers.
    DATA ls_serial_number    TYPE losn_serial_number_s.
    DATA incrementnumber       TYPE i.
    DATA lv_count TYPE  i.
    DATA lv_csetype TYPE string.
    DATA lv_cpu TYPE string.
    DATA lv_serial TYPE i.
    DATA lv_creationdate TYPE d.
    DATA: gd_day(2) TYPE c.
    DATA gd_month(2) TYPE c.
    DATA gd_year(4) TYPE c.
    DATA f_pattern TYPE string.
    DATA s_pattern TYPE string.
    DATA spaces TYPE i.

    gd_year = substring(
            val = cl_abap_context_info=>get_system_date( )
          off = 2
           len = 2
          ).
    gd_month = substring(
            val = cl_abap_context_info=>get_system_date( )
          off = 4
           len = 2
          ).
    gd_day = substring(
            val = cl_abap_context_info=>get_system_date( )
          off = 6
           len = 2
          ).
    IF serial_number_assignment-plant = 'NT10'.
      "" CSETYPE Custom Field
      SELECT SINGLE yy1_csetype_prd FROM i_product WITH PRIVILEGED ACCESS
      WHERE product = @serial_number_assignment-material
      INTO @lv_csetype.
      "" CPU Custom Field
      SELECT SINGLE yy1_cpu_prd FROM i_product WITH PRIVILEGED ACCESS
      WHERE product = @serial_number_assignment-material
      INTO @lv_cpu.

      "select SINGLE YY1_SERIALNO_PRD from I_Product with privileged access
      "Where product = @serial_number_assignment-material
      "INTO @lv_serial.

      "select SINGLE LASTCHANGEDATE from I_Product  with privileged access
      "Where product = @serial_number_assignment-material
      "INTO @lv_creationdate.

      f_pattern =  gd_month && gd_year.
      s_pattern = '%' && f_pattern.

      SELECT COUNT(*) AS serialnumber FROM i_serialnumbermanufacturingord WITH PRIVILEGED ACCESS
      WHERE serialnumber LIKE @s_pattern INTO @lv_count.

      "f_pattern = lv_cpu && lv_csetype && gd_year && gd_month .


      incrementnumber = lv_count + 1.
      DO serial_number_assignment-numberofserialnumbers TIMES.
        DATA v_number TYPE string.
        v_number = incrementnumber.


        spaces = 6 - strlen( v_number ).
        DO spaces TIMES.
          CONCATENATE '0' v_number INTO v_number.
        ENDDO.
        v_number = substring(
                            val = v_number
                          off = 0
                           len = 6
                          ).

        ls_serial_number-serialnumber =  lv_csetype && lv_cpu && v_number && gd_month && gd_year.

        incrementnumber = incrementnumber + 1.
        APPEND ls_serial_number TO serial_numbers_out.
      ENDDO.

      "Code for NT11

    ELSEIF serial_number_assignment-plant = 'NT11'.

      DATA: lv_manufacturingord TYPE string.
      lv_manufacturingord = substring(
              val = serial_number_assignment-manufacturingorder
            off = 8
             len = 4
            ).

      f_pattern = gd_year."gd_month && gd_year.
      s_pattern = '%' && f_pattern.

      SELECT COUNT(*) AS serialnumber FROM i_serialnumbermanufacturingord WITH PRIVILEGED ACCESS
      WHERE material = @serial_number_assignment-material AND serialnumber LIKE @s_pattern INTO @lv_count.

      SELECT * FROM i_serialnumbermanufacturingord WITH PRIVILEGED ACCESS
      WHERE material = @serial_number_assignment-material AND serialnumber LIKE @s_pattern INTO table @Data(lv_count2).
      "f_pattern = lv_cpu && lv_csetype && gd_year && gd_month .


      incrementnumber = lv_count + 1.
      DO serial_number_assignment-numberofserialnumbers TIMES.
        DATA v_number2 TYPE string.
        v_number2 = incrementnumber.


        spaces = 6 - strlen( v_number2 ).
        DO spaces TIMES.
          CONCATENATE '0' v_number2 INTO v_number2.
        ENDDO.
        v_number2 = substring(
                            val = v_number2
                          off = 0
                           len = 6
                          ).

        ls_serial_number-serialnumber =  lv_manufacturingord && gd_day && gd_month && gd_year && v_number2 .

        incrementnumber = incrementnumber + 1.
        APPEND ls_serial_number TO serial_numbers_out.
      ENDDO.


    ENDIF.

  ENDMETHOD.
ENDCLASS.
