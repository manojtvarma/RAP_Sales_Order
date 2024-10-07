CLASS lhc__SalesOrderHeader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    DATA gv_test TYPE abap_boolean.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _SalesOrderHeader RESULT result.

    METHODS check_state FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _salesorderheader~check_state.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE _SalesOrderHeader.

    METHODS earlynumbering_item_create FOR NUMBERING
      IMPORTING entities FOR CREATE _SalesOrderHeader\_SalesOrderItem.

ENDCLASS.

CLASS lhc__SalesOrderHeader IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

  ENDMETHOD.

  METHOD check_state.
    gv_test = abap_true.
  ENDMETHOD.

  METHOD earlynumbering_item_create.
    CHECK sy-subrc EQ 0.

  ENDMETHOD.

ENDCLASS.
