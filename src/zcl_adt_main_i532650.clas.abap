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

    SELECT SINGLE * FROM i_product INTO @DATA(lt_data).

  ENDMETHOD.
ENDCLASS.
