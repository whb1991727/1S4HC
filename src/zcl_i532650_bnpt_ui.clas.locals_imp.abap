CLASS lhc_z_i532650_bounspoints_ui DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
*    METHODS:
*      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
*        IMPORTING
*           REQUEST requested_authorizations FOR z_i532650_bounspoints
*        RESULT result.

    METHODS redeem FOR MODIFY
      IMPORTING
                keys   FOR ACTION z_i532650_bounspoints~redeem
      RESULT    result.

ENDCLASS.

CLASS lhc_z_i532650_bounspoints_ui IMPLEMENTATION.
*  METHOD GET_GLOBAL_AUTHORIZATIONS.
*  ENDMETHOD.
  METHOD redeem.

    DATA(lt_keys) = keys.
    READ TABLE lt_keys INTO DATA(ls_key) INDEX 1.
    DATA(custom) = ls_key-Customer.
    DATA(product) = ls_key-%param-product.


ENDMETHOD.
ENDCLASS.
