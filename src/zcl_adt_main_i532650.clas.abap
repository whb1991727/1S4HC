CLASS zcl_adt_main_i532650 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_adt_main_i532650 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  out->write( |hello world| ).

  select single * from i_product into @data(lt_data).




** Create Log master data
*        DATA(lo_log) = cl_bali_log=>create( ).
*        DATA(lo_filter) = cl_bali_log_filter=>create( ).
*        lo_log->create_object(
*            iv_object = 'Z_ONLINE_SHOP'
*            iv_object_text = 'Log for Online Shop'
*            it_subobjects  = VALUE #( ( subobject = 'Z_ONLINE_SHOP_SUB' subobject_text = 'Sub Log for Online Shop' ) )
*            iv_package = 'Z_I532650'
*            iv_transport_request = 'CZMK900136'
*         ).
** Create Log
*        lo_log->set_header( cl_bali_header_setter=>create( object = 'Z_ONLINE_SHOP'
*                                                           subobject = 'Z_ONLINE_SHOP_SUB'
*                                                           external_id = 'External ID' ) ).
*
*        MESSAGE ID 'Z_RAP_DEMO' TYPE 'S' NUMBER '010' INTO DATA(lv_message).
*        lo_log->add_item( cl_bali_message_setter=>create_from_sy( ) ).
*
*        cl_bali_log_db=>get_instance( )->save_log( log = lo_log ).

** Read Log
*        DATA(l_filter) = cl_bali_log_filter=>create(
*                                          )->set_descriptor( object = 'Z_ONLINE_SHOP'
*                                                             subobject = 'Z_ONLINE_SHOP_SUB'
*                                                             external_id = 'E*' ).
*        DATA(log_table) = cl_bali_log_db=>get_instance( )->load_logs_via_filter( filter = l_filter ).
*        out->write( log_table ).


** Job
*    CONSTANTS lc_catalog_name      TYPE cl_apj_dt_create_content=>ty_catalog_name  VALUE 'ZTEST_MY_SIMPLE_JOB'.
*    CONSTANTS lc_catalog_text      TYPE cl_apj_dt_create_content=>ty_text          VALUE 'My first simple application job'.
*    CONSTANTS lc_class_name        TYPE cl_apj_dt_create_content=>ty_class_name    VALUE 'ZCL_JOB_I532650'.
*
*    CONSTANTS lc_template_name     TYPE cl_apj_dt_create_content=>ty_template_name VALUE 'ZTEST_MY_SIMPLE_JOB_TEMPL'.
*    CONSTANTS lc_template_text     TYPE cl_apj_dt_create_content=>ty_text          VALUE 'My first simple job template'.
*
*    CONSTANTS lc_transport_request TYPE cl_apj_dt_create_content=>ty_transport_request VALUE 'CZMK900136'.
*    CONSTANTS lc_package           TYPE cl_apj_dt_create_content=>ty_package           VALUE 'Z_I532650'.
*
*    DATA(lo_dt) = cl_apj_dt_create_content=>get_instance( ).
*
*    " Create job catalog entry (corresponds to the former report incl. selection parameters)
*    " Provided implementation class iv_class_name shall implement two interfaces:
*    " - if_apj_dt_exec_object to provide the definition of all supported selection parameters of the job
*    "   (corresponds to the former report selection parameters) and to provide the actual default values
*    " - if_apj_rt_exec_object to implement the job execution
*    TRY.
*        lo_dt->create_job_cat_entry(
*            iv_catalog_name       = lc_catalog_name
*            iv_class_name         = lc_class_name
*            iv_text               = lc_catalog_text
*            iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
*            iv_transport_request  = lc_transport_request
*            iv_package            = lc_package
*        ).
*        out->write( |Job catalog entry created successfully| ).
*
*      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
*        out->write( |Creation of job catalog entry failed: { lx_apj_dt_content->get_text( ) }| ).
*    ENDTRY.
*
*    " Create job template (corresponds to the former system selection variant) which is mandatory
*    " to select the job later on in the Fiori app to schedule the job
*    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.
*
*    NEW zcl_job_i532650( )->if_apj_dt_exec_object~get_parameters(
*      IMPORTING
*        et_parameter_val = lt_parameters
*    ).
*
*    TRY.
*        lo_dt->create_job_template_entry(
*            iv_template_name     = lc_template_name
*            iv_catalog_name      = lc_catalog_name
*            iv_text              = lc_template_text
*            it_parameters        = lt_parameters
*            iv_transport_request = lc_transport_request
*            iv_package           = lc_package
*        ).
*        out->write( |Job template created successfully| ).
*
*      CATCH cx_apj_dt_content INTO lx_apj_dt_content.
*        out->write( |Creation of job template failed: { lx_apj_dt_content->get_text( ) }| ).
*        RETURN.
*    ENDTRY.
*INSERT  zi532650_je  FROM TABLE @( VALUE #(
*       (
*       client = '080'
*       bukrs = '1310'
*       gjahr = '2022'
*       belnr = '10006'
*       buzei = '1'
*       racct = '1003000'
*       rldnr = 'C5'
*       amount = '1.00'
*       waers = 'CNY'
*       )
*       )
*       ) .

  ENDMETHOD.
ENDCLASS.
