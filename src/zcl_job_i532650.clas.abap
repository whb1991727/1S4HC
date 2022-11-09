CLASS zcl_job_i532650 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_job_i532650 IMPLEMENTATION.


  METHOD if_apj_dt_exec_object~get_parameters.
  " Return the supported selection parameters here
    et_parameter_def = VALUE #(
      ( selname = 'S_ID'    kind = if_apj_dt_exec_object=>select_option datatype = 'C' length = 10 param_text = 'My ID'                                      changeable_ind = abap_true )
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 80 param_text = 'My Description'   lowercase_ind = abap_true changeable_ind = abap_true )
      ( selname = 'P_COUNT' kind = if_apj_dt_exec_object=>parameter     datatype = 'I' length = 10 param_text = 'My Count'                                   changeable_ind = abap_true )
      ( selname = 'P_SIMUL' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length =  1 param_text = 'My Simulate Only' checkbox_ind = abap_true  changeable_ind = abap_true )
    ).

    " Return the default parameters values here
    et_parameter_val = VALUE #(
      ( selname = 'S_ID'    kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = '4711' )
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'My Default Description' )
      ( selname = 'P_COUNT' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = '200' )
      ( selname = 'P_SIMUL' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = abap_true )
    ).

  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.

  TYPES ty_id TYPE c LENGTH 10.

    DATA s_id    TYPE RANGE OF ty_id.
    DATA p_descr TYPE c LENGTH 80.
    DATA p_count TYPE i.
    DATA p_simul TYPE abap_boolean.

    " Getting the actual parameter values
    LOOP AT it_parameters INTO DATA(ls_parameter).
      CASE ls_parameter-selname.
        WHEN 'S_ID'.
          APPEND VALUE #( sign   = ls_parameter-sign
                          option = ls_parameter-option
                          low    = ls_parameter-low
                          high   = ls_parameter-high ) TO s_id.
        WHEN 'P_DESCR'. p_descr = ls_parameter-low.
        WHEN 'P_COUNT'. p_count = ls_parameter-low.
        WHEN 'P_SIMUL'. p_simul = ls_parameter-low.
      ENDCASE.
    ENDLOOP.

    " Implement the job execution

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
                                                purchaserequisitionitemtext = 'Job testing for demo purpose'
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
       COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
