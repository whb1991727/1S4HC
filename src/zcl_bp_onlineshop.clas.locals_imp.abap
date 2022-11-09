
CLASS lcl_handler DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR onlineshop
        RESULT result.

* creation of a new order triggers a new purchase requisition
    METHODS create_pr FOR MODIFY
      IMPORTING keys FOR ACTION zi_onlineshop_whb~create_pr.

* create a new order_id
    METHODS calculate_order_id FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_onlineshop_whb~calculate_order_id.



ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create_pr.

    IF keys IS NOT INITIAL.
      MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
          CREATE FIELDS ( purchaserequisitiontype )
          WITH VALUE #(  ( %cid                    = 'My%CID_1'
                           purchaserequisitiontype = 'NB' ) )

         CREATE BY \_purchaserequisitionitem
         FIELDS ( plant
                  purchaserequisitionitemtext
                  material
                  deliverydate
                  requestedquantity
                  baseunit
                  purchaserequisitionprice
                  purreqnitemcurrency
                  materialgroup
                  purchasinggroup
                  purchasingorganization
                  StorageLocation    )
         WITH VALUE #(
                       (    %cid_ref = 'My%CID_1'
                            %target = VALUE #(
                                             (  %cid                        = 'My%ItemCID_1'
                                                plant                       = '1010'
                                                purchaserequisitionitemtext = 'PaaS test'
                                                material                    = 'TG0011'
                                                deliverydate                = cl_abap_context_info=>get_system_date( )
                                                requestedquantity           = '10.00'
                                                baseunit                    = 'PC'
                                                purchaserequisitionprice    = '10.00'
                                                purreqnitemcurrency         = 'EUR'
                                                materialgroup               = 'L001'
                                                purchasinggroup             = '002'
                                                purchasingorganization      = '1010'
                                                StorageLocation             = '101A'
                                                )
                                             )
                        )
                      )

       REPORTED DATA(ls_reported)
       MAPPED DATA(ls_mapped)
       FAILED DATA(ls_failed).

    ENDIF.

  ENDMETHOD.

  METHOD calculate_order_id.
    DATA:
      online_shops TYPE TABLE FOR UPDATE zi_onlineshop_whb,
      online_shop  TYPE STRUCTURE FOR UPDATE zi_onlineshop_whb.
*      delete from zonlineshop_xxx UP TO 15 ROWS.
    SELECT MAX( order_id ) FROM zonline_shop INTO @DATA(max_order_id).
    READ ENTITIES OF zi_onlineshop_whb IN LOCAL MODE
       ENTITY zi_onlineshop_whb
        ALL FIELDS
          WITH CORRESPONDING #( keys )
          RESULT DATA(lt_online_shop_result)
      FAILED    DATA(lt_failed)
      REPORTED  DATA(lt_reported).
    DATA(today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.
      online_shop = CORRESPONDING #( online_shop_read ).
      online_shop-orderid = max_order_id.
      online_shop-Creationdate = today.
      APPEND online_shop TO online_shops.
    ENDLOOP.

    MODIFY ENTITIES OF zi_onlineshop_whb IN LOCAL MODE
           ENTITY zi_onlineshop_whb UPDATE SET FIELDS WITH online_shops
           EXECUTE create_pr FROM CORRESPONDING #( keys )
           MAPPED   DATA(lt_mapped_modify)
           FAILED   DATA(failed_modify)
           REPORTED DATA(reported_modify).

    TRY.
        DATA(lo_log) = cl_bali_log=>create( ).
        lo_log->set_header( header = cl_bali_header_setter=>create( object = 'Z_ONLINE_SHOP'
        subobject = 'Z_ONLINE_SHOP_SUB'
        external_id = 'zcl_rap_test') ).

        MESSAGE ID 'Z_RAP_DEMO' TYPE 'S' NUMBER '010' INTO DATA(lv_message).
        lo_log->add_item( item = cl_bali_message_setter=>create_from_sy( ) ).
        cl_bali_log_db=>get_instance( )->save_log( log = lo_log ).

      CATCH cx_bali_runtime INTO DATA(lv_exception).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
