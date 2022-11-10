CLASS zcl_i532650_ledger_comparison DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_i532650_ledger_comparison IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    IF io_request->is_data_requested( ).

      DATA: lt_response TYPE TABLE OF zi_i532650_ledger_comparison.


      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lt_clause)        = io_request->get_filter( )->get_as_ranges( ).
      DATA(lt_parameter)     = io_request->get_parameters( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).

      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
      ENDTRY.


****Data retrival and business logics goes here*****
      DATA lt_ledger TYPE TABLE OF zi_i532650_je.

      LOOP AT lt_parameter ASSIGNING FIELD-SYMBOL(<fs_p>).
        CASE <fs_p>-parameter_name.
          WHEN 'P_BUKRS'.   DATA(p_bukrs) = <fs_p>-value.
          WHEN 'P_GJAHR'.   DATA(p_gjahr) = <fs_p>-value.
          WHEN 'P_LEDGER1'. DATA(p_ledger1) = <fs_p>-value.
          WHEN 'P_LEDGER2'. DATA(p_ledger2) = <fs_p>-value.
        ENDCASE.
      ENDLOOP.


      SELECT
      bukrs as companycode,
      gjahr as fiscalyear,
      racct as glaccount,
      SUM( amount1 ) AS amount1,
      SUM( amount2 ) AS amount2
      FROM zi_i532650_je(
      p_bukrs = @p_bukrs,
      p_gjahr = @p_gjahr,
      p_rldnr1 = @p_ledger1,
      p_rldnr2 = @p_ledger2 )
      GROUP BY bukrs, gjahr, racct
      INTO CORRESPONDING FIELDS OF TABLE @lt_response.

      LOOP AT lt_response ASSIGNING FIELD-SYMBOL(<fs_l>).
        <fs_l>-difamount = abs(  <fs_l>-amount1 - <fs_l>-amount2 ).
      ENDLOOP.

      io_response->set_total_number_of_records( lines( lt_response ) ).
      io_response->set_data( lt_response ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
