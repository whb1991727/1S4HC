CLASS zcl_badi_i532650_pr_check DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_mm_pur_s4_pr_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_badi_i532650_pr_check IMPLEMENTATION.


  METHOD if_mm_pur_s4_pr_check~check.
*    DATA ls_message TYPE mmpur_s_messages.
*
*    LOOP AT purchaserequisitionitem_table INTO DATA(ls_item).
*      IF ls_item-orderedquantity > 10.
*        ls_message-messageid = 'DUMMY'.
*        ls_message-messagetype = 'E'.
*        ls_message-messagenumber = '001'.
*        ls_message-messagevariable1 = 'Quantity limit 10'.
*        APPEND ls_message TO messages.
*      ENDIF.
*
*      IF ls_item-deliverydate - ( cl_abap_context_info=>get_system_date(  ) ) > 180.
*        ls_message-messageid = 'DUMMY'.
*        ls_message-messagetype = 'E'.
*        ls_message-messagenumber = '001'.
*        ls_message-messagevariable1 = 'Delivery date limit 180 days'.
*        APPEND ls_message TO messages.
*      ENDIF.
*
*      RETURN.
*    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
