CLASS zedoc_img DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_edoc_adaptor_cloud .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZEDOC_IMG IMPLEMENTATION.


  METHOD if_edoc_adaptor_cloud~change_edocument_type.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~change_form.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~change_invoice_type.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~get_variable_key.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~is_relevant.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~restrict_cancel.
  ENDMETHOD.


  METHOD if_edoc_adaptor_cloud~set_output_data.

    DATA(lv_doc) = iv_source_key.
    DATA: lv_bill TYPE I_BillingDocument-BillingDocument.
    DATA: lv_billc TYPE I_BillingDocument-Country.
    lv_bill = lv_doc.

    SELECT SINGLE BillingDocument,billingdocumentitem,AddressID,Customer,partnerfunction FROM I_BillingDocItemPartner WITH PRIVILEGED ACCESS
    WHERE BillingDocument = @lv_bill
    AND partnerfunction = 'WE' INTO @DATA(ls_add).

    SELECT SINGLE CityName,PostalCode,Country,OrganizationName1,Statecode,StreetName,StreetPrefixName1,StreetSuffixName1,StreetPrefixName2,StreetSuffixName2 FROM ZCUSTOM_Add WITH PRIVILEGED ACCESS
    WHERE AddressID = @ls_add-AddressID INTO @DATA(ls_address).

    SELECT SINGLE Customer,taxnumber3
    FROM I_Customer WITH PRIVILEGED ACCESS AS c
    WHERE c~Customer = @ls_add-Customer
    INTO @DATA(ls_customer).

    SELECT SINGLE billingdocument,country FROM I_BillingDocument WITH PRIVILEGED ACCESS
    WHERE BillingDocument = @ls_add-BillingDocument INTO @DATA(ls_BILL).


    SELECT SINGLE BillingDocument,AddressID,Customer,partnerfunction FROM I_BillingDocumentPartner WITH PRIVILEGED ACCESS
    WHERE BillingDocument = @lv_bill
    AND partnerfunction = 'AG' INTO @DATA(ls_add1).

    SELECT SINGLE CityName,PostalCode,Country,OrganizationName1,Statecode,StreetName FROM ZCUSTOM_Add WITH PRIVILEGED ACCESS
    WHERE AddressID = @ls_add1-AddressID INTO @DATA(ls_address1).

    SELECT SINGLE Customer,taxnumber3
    FROM I_Customer WITH PRIVILEGED ACCESS AS c
    WHERE c~Customer = @ls_add1-Customer
    INTO @DATA(ls_customer1).

    IF ls_customer1-TaxNumber3 = ls_customer-TaxNumber3  AND ls_BILL-Country = 'IN'.
      ASSIGN COMPONENT 'REQUEST' OF STRUCTURE cs_output_data TO FIELD-SYMBOL(<fs_request>).
      IF <fs_request> IS ASSIGNED.
        ASSIGN COMPONENT 'DOC_DATA' OF STRUCTURE <fs_request> TO FIELD-SYMBOL(<fs_doc_data>).

        IF <fs_doc_data> IS ASSIGNED.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls1>).

          ASSIGN COMPONENT 'GSTIN' OF STRUCTURE <fs_seller_dtls1> TO FIELD-SYMBOL(<fs_stcd>).
          IF <fs_stcd> IS ASSIGNED.
            <fs_stcd> = ls_customer-TaxNumber3.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls2>).
          ASSIGN COMPONENT 'LGL_NM' OF STRUCTURE <fs_seller_dtls2> TO FIELD-SYMBOL(<adddr1>).
          IF <adddr1> IS ASSIGNED.
            <adddr1> = ls_address-OrganizationName1.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls3>).
          ASSIGN COMPONENT 'TRD_NM' OF STRUCTURE <fs_seller_dtls3> TO FIELD-SYMBOL(<adddr2>).
          IF <adddr2> IS ASSIGNED.
            <adddr2> = ls_address-OrganizationName1.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls4>).
          ASSIGN COMPONENT 'POS' OF STRUCTURE <fs_seller_dtls4> TO FIELD-SYMBOL(<adddr3>).
          IF <adddr3> IS ASSIGNED.
            <adddr3> = ls_address-CityName.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls5>).
          ASSIGN COMPONENT 'ADDR1' OF STRUCTURE <fs_seller_dtls5> TO FIELD-SYMBOL(<adddr4>).
          IF <adddr4> IS ASSIGNED.
*           IF ls_address-StreetName IS NOT INITIAL.
            DATA(lv_addr4) = |{ ls_address-StreetName } { ls_address-StreetPrefixName1 } { ls_address-StreetSuffixName1 } { ls_address-StreetPrefixName2 } { ls_address-StreetSuffixName2 }|.
            CONDENSE lv_addr4.
            <adddr4> = lv_addr4.
*              else.
*              <adddr4> = |{ ls_address-StreetName } { ls_address-StreetPrefixName1 } { ls_address-StreetSuffixName1 } { ls_address-StreetPrefixName2 } { ls_address-StreetSuffixName2 }|.

*            ELSEIF ls_address-StreetName IS INITIAL.
*              <adddr4> = |{ ls_address-StreetPrefixName1 } { ls_address-StreetSuffixName1 }|.
*
*            ELSEIF ls_address-StreetPrefixName1 IS INITIAL AND ls_address-StreetSuffixName1 IS INITIAL.
*              <adddr4> = |{ ls_address-StreetPrefixName2 } { ls_address-StreetSuffixName2 }|.
*            ENDIF.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls6>).
          ASSIGN COMPONENT 'ADDR2' OF STRUCTURE <fs_seller_dtls6> TO FIELD-SYMBOL(<adddr8>).
          IF <adddr8> IS ASSIGNED.
            <adddr8> = ls_address-CityName.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls7>).
          ASSIGN COMPONENT 'LOC' OF STRUCTURE <fs_seller_dtls7> TO FIELD-SYMBOL(<adddr5>).
          IF <adddr5> IS ASSIGNED.
            <adddr5> = ls_address-CityName.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls8>).
          ASSIGN COMPONENT 'PIN' OF STRUCTURE <fs_seller_dtls8> TO FIELD-SYMBOL(<adddr6>).
          IF <adddr6> IS ASSIGNED.
            <adddr6> = ls_address-PostalCode.
          ENDIF.

          ASSIGN COMPONENT 'SHIP_DTLS' OF STRUCTURE <fs_doc_data> TO FIELD-SYMBOL(<fs_seller_dtls9>).
          ASSIGN COMPONENT 'STCD' OF STRUCTURE <fs_seller_dtls9> TO FIELD-SYMBOL(<adddr7>).
          IF <adddr7> IS ASSIGNED.
            <adddr7> = ls_address-Statecode.
          ENDIF.


        ENDIF.

      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
