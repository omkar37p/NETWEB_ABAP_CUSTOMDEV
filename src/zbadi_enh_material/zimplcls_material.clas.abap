CLASS zimplcls_material DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_cmd_prod_data_api_check_2 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZIMPLCLS_MATERIAL IMPLEMENTATION.


  METHOD   if_cmd_prod_data_api_check_2~check_data.


    TRY.
        " Get the Reponse of Custom BO for Condition.


        READ TABLE ct_product_upd ASSIGNING FIELD-SYMBOL(<ls_curr_product>) INDEX 1.    " get the current Product ID.
        DATA(currproductid) =  <ls_curr_product>-product.
        SHIFT currproductid LEFT DELETING LEADING '0'.

        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination_mat_get) = cl_http_destination_provider=>create_by_url( 'https://my414395-api.s4hana.cloud.sap/sap/opu/odata/sap/YY1_PRODUCTTOWMS_CDS/YY1_PRODUCTTOWMS?$filter=ProductID%20eq%20%27' &&  currproductid && '%27' ).
        DATA(lo_web_http_client_mat_get) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination_mat_get ) .

        "adding headers with API Key for API Sandbox
        DATA(lo_web_http_request_mat_get) = lo_web_http_client_mat_get->get_http_request( ).
        lo_web_http_request_mat_get->set_header_fields( VALUE #(
        ( name = 'Accept' value = 'application/json' )
        ( name = 'Authorization' value = 'Basic V01TOldNU0ludGVncmF0aW9uQDEyMzQ1Njc4OTA=' )
        ) ).

        "set request method and execute request
        DATA(lo_web_http_response_mat_get) = lo_web_http_client_mat_get->execute( if_web_http_client=>get ).
        DATA(lv_response_mat_get) = lo_web_http_response_mat_get->get_text( ).


        " Get the Response of Web Service.
        TYPES: BEGIN OF ty_results,
                 productid TYPE string,
                 response  TYPE string,
               END OF ty_results.

        TYPES: BEGIN OF ty_d,
                 results TYPE STANDARD TABLE OF ty_results WITH EMPTY KEY,
               END OF ty_d.

        TYPES: BEGIN OF ty_response,
                 d TYPE ty_d,
               END OF ty_response.

        "DATA: lv_response_get_service TYPE ty_response.
        "DATA GetService_json_string TYPE string.

        "GetService_json_string = lv_response_mat_get.

        DATA: ls_json_data TYPE ty_response.

        CALL METHOD /ui2/cl_json=>deserialize   "Call method to DeSerialize the JSON Response.
          EXPORTING
            json = lv_response_mat_get
          CHANGING
            data = ls_json_data.   "Get the Response in structure format in variable-json_data.

        LOOP AT ls_json_data-d-results INTO DATA(ls_inner_loop).
          DATA(Product_ID_Get_Service) = ls_inner_loop-productid.
        ENDLOOP.
        "End Get the Reponse of Custom BO for Condition.

if product_id_get_service is initial.
        DATA:lv_json_string TYPE string.
        lv_json_string = '{"UID":0,' && '"SiteCode":"S001",' &&  '"UserName":"","UserID":"123","UserType":"",'
       && '"Password":"05","EmailID":"",' && '"Department":"","CreatedBy":"",' && '"CreatedOn":"2024-09-21T11:00:26.4172423+05:30","PhoneNo":"",'
       && '"Result":"","Value":"","Text":"","isActive":"","dDateOfJoining":"2024-09-21T11:00:26.4172442+05:30",'
       && '"dDateOfBirth":"2024-09-21T11:00:26.4172739+05:30","sMaretialStatus":"",'
       && '"dMarriageAniversary":"2024-09-21T11:00:26.4172745+05:30"}'.

        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination) = cl_http_destination_provider=>create_by_url( 'http://43.204.246.102:202/API/Login' ).

        " lv_json_string =  '{"SalesOrderType": "OR","SalesOrganization": "10S0","DistributionChannel": "01","OrganizationDivision": "01","SoldToParty": "1003113","to_Item":[{"Material": "DR-00406-14"}]}'.
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "adding headers with API Key for API Sandbox
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).
        lo_web_http_request->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Accept' value = 'application/json' )
        "( name = 'Authorization' value = 'Basic Q09NVVNFUl9BTExFTkdFUlM6V2VsY29tZUAxMjM0NTY3ODkwMTIzNDU2Nzg5MA==' )
        ) ).

        lo_web_http_request->set_text( lv_json_string ).
        "lo_web_http_client->set_csrf_token( ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>post ).
        DATA(lv_response) = lo_web_http_response->get_text( ).


        "Get the Response(SalesOrdeID) in purchase Order screen.
        TYPES: BEGIN OF ty_product2,
                 result   TYPE string,    "Structure of Sales Order Response
                 sitecode TYPE string,
               END OF ty_product2.

*            TYPES: BEGIN OF ty_json_data,
*                     d TYPE ty_sales_order2,
*                   END OF ty_json_data.
        DATA json_string TYPE string.

        json_string = lv_response.
        "json_string = '{"d": {"SalesOrder": "970"}}'.

        DATA: json_data TYPE ty_product2.

        CALL METHOD /ui2/cl_json=>deserialize   "Call method to DeSerialize the JSON Response.
          EXPORTING
            json = json_string
          CHANGING
            data = json_data.   "Get the Response in structure format in variable-json_data.

        DATA(product_id) = 'ABC'."json_data-result.
        DATA(site_code) = json_data-sitecode.
        DATA(result) = json_data-result.
        "purchaseorderchange-yy1_serialno_pdh = sales_order.
        DATA: test TYPE c.
        test = '334'.

        "Update Material from WMS response

        READ TABLE ct_product_upd ASSIGNING FIELD-SYMBOL(<ls_product>) INDEX 1.
        IF sy-subrc = 0.
          DATA(productid) =  <ls_product>-product.
          SHIFT productid LEFT DELETING LEADING '0'.
        ENDIF.

        lv_json_string = ' {"d": {"ProductID": "' && productid &&  '","Response": "' && result && '"}}'.

        "create http destination by url; API endpoint for API sandbox
        DATA(lo_http_destination_mat) = cl_http_destination_provider=>create_by_url( 'https://my414395-api.s4hana.cloud.sap/sap/opu/odata/sap/YY1_PRODUCTTOWMS_CDS/YY1_PRODUCTTOWMS' ).
        DATA(lo_web_http_client_mat) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination_mat ) .

        "adding headers with API Key for API Sandbox
        DATA(lo_web_http_request_mat) = lo_web_http_client_mat->get_http_request( ).
        lo_web_http_request_mat->set_header_fields( VALUE #(
        ( name = 'Content-Type' value = 'application/json' )
        ( name = 'Accept' value = 'application/json' )
        ( name = 'Authorization' value = 'Basic V01TOldNU0ludGVncmF0aW9uQDEyMzQ1Njc4OTA=' )
        ) ).

        lo_web_http_request_mat->set_text( lv_json_string ).
        lo_web_http_client_mat->set_csrf_token( ).

        "set request method and execute request
        DATA(lo_web_http_response_mat) = lo_web_http_client_mat->execute( if_web_http_client=>post ).
        DATA(lv_response_mat) = lo_web_http_response_mat->get_text( ).

    endif.
        "End Update Material from WMS response

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
