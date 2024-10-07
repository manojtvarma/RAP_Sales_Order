CLASS zcl_ddic_objects_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

****Domain
    TYPES: BEGIN OF ty_fixed_value,
             lower_limit TYPE if_xco_gen_doma_s_fo_fxd_value=>tv_lower_limit,
             upper_limit TYPE if_xco_gen_doma_s_fo_fxd_value=>tv_upper_limit,
             description TYPE if_xco_gen_doma_s_fo_fxd_value=>tv_description,
           END OF ty_fixed_value.

    TYPES: BEGIN OF ty_domain_info,
             name          TYPE sxco_ad_object_name,
             description   TYPE if_xco_cp_gen_doma_s_form=>tv_short_description,
             data_type     TYPE cl_xco_ad_built_in_type_f=>tv_type,
             length        TYPE cl_xco_ad_built_in_type_f=>tv_length,
             output_length TYPE if_xco_gen_doma_s_fo_outpt_chr=>tv_output_length,
             conv_exit     TYPE if_xco_gen_doma_s_fo_outpt_chr=>tv_conversion_routine,
             sign          TYPE abap_bool,
             decimals      TYPE cl_xco_ad_built_in_type_f=>tv_decimals,
             value_table   TYPE if_xco_gen_doma_s_fo_fxd_vals=>tv_value_table,
             fixed_values  TYPE TABLE OF ty_fixed_value WITH DEFAULT KEY,
           END OF ty_domain_info,
           tt_domain_info TYPE TABLE OF ty_domain_info.
****

****Data Element
    TYPES: BEGIN OF ty_text_length,
             text   TYPE if_xco_gen_dtel_s_fo_fld_lbl=>tv_text,
             length TYPE if_xco_gen_dtel_s_fo_fld_lbl=>tv_length,
           END OF ty_text_length.

    TYPES: BEGIN OF ty_field_label,
             short   TYPE ty_text_length,
             medium  TYPE ty_text_length,
             long    TYPE ty_text_length,
             heading TYPE ty_text_length,
           END OF ty_field_label.

    TYPES: BEGIN OF ty_data_element_info,
             name        TYPE sxco_ad_object_name,
             description TYPE if_xco_cp_gen_doma_s_form=>tv_short_description,
             domname     TYPE sxco_ad_object_name,
             data_type   TYPE cl_xco_ad_built_in_type_f=>tv_type,
             length      TYPE cl_xco_ad_built_in_type_f=>tv_length,
             decimals    TYPE cl_xco_ad_built_in_type_f=>tv_decimals,
             field_label TYPE ty_field_label,
           END OF ty_data_element_info,
           tt_data_element_info TYPE TABLE OF ty_data_element_info.
****

    CONSTANTS: mc_transport_request TYPE sxco_transport VALUE 'TRLK900692',
               mc_package           TYPE c LENGTH 30    VALUE 'ZLEARN_SAP_RAP'.

    INTERFACES if_oo_adt_classrun .

    CLASS-METHODS domain_delete IMPORTING i_name TYPE sxco_ad_object_name.
    CLASS-METHODS data_element_delete IMPORTING i_name TYPE sxco_ad_object_name.

    CLASS-METHODS domain_create IMPORTING
                                  is_domain_info  TYPE ty_domain_info
                                EXPORTING
                                  et_xco_findings TYPE sxco_t_gen_o_findings.

    CLASS-METHODS data_element_create IMPORTING
                                        is_data_element_info TYPE ty_data_element_info
                                      EXPORTING
                                        et_xco_findings      TYPE sxco_t_gen_o_findings.

    CLASS-METHODS domain_values_get EXPORTING
                                      et_domain_values TYPE tt_domain_info.

    CLASS-METHODS data_element_values_get EXPORTING
                                            et_data_element_values TYPE tt_data_element_info.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_ddic_objects_generator IMPLEMENTATION.

  METHOD domain_create.

    DATA(lref_environment)     = xco_cp_generation=>environment->dev_system( mc_transport_request ).
    DATA(lref_put_operation)   = lref_environment->create_put_operation( ).
    DATA(lref_doma) = lref_put_operation->for-doma->get_object( is_domain_info-name ).

    IF lref_doma IS INITIAL.
      DATA(lref_specification) = lref_put_operation->for-doma->add_object( is_domain_info-name
                                                                         )->set_package( mc_package
                                                                         )->create_form_specification( ).
    ELSE.
      lref_specification  = lref_doma->set_package( mc_package )->get_form_specification( ).
    ENDIF.
    lref_specification->set_short_description( is_domain_info-description ).
    lref_specification->set_format( xco_cp_abap_dictionary=>built_in_type->for( iv_type =  is_domain_info-data_type
                                                                                iv_length = is_domain_info-length
                                                                                iv_decimals = is_domain_info-decimals ) ).

    lref_specification->output_characteristics->set_case_sensitive( abap_false ).
    lref_specification->output_characteristics->set_output_length( is_domain_info-output_length ).
    lref_specification->output_characteristics->set_conversion_routine( is_domain_info-conv_exit ).
    lref_specification->output_characteristics->set_sign( is_domain_info-sign ).
    lref_specification->fixed_values->set_value_table( is_domain_info-value_table ).

    LOOP AT is_domain_info-fixed_values ASSIGNING FIELD-SYMBOL(<lwa_fixed_value>).
      DATA(lref_fixed_value) = lref_specification->fixed_values->add_fixed_value( iv_lower_limit = <lwa_fixed_value>-lower_limit ).
      lref_fixed_value->set_description( iv_description = <lwa_fixed_value>-description ).

      IF NOT <lwa_fixed_value>-upper_limit IS INITIAL.
        lref_fixed_value->set_upper_limit( iv_upper_limit = <lwa_fixed_value>-upper_limit ).
      ENDIF.
    ENDLOOP.

    TRY.
        lref_put_operation->execute( ).
        DATA(lref_transport) = xco_cp_cts=>transport->for( mc_transport_request ).
        DATA(lref_api_state) = xco_cp_ars=>api_state->released( VALUE #( ( xco_cp_ars=>visibility->sap_cloud_platform ) ) ).

        DATA(lref_domain) = xco_cp_abap_repository=>object->doma->for( is_domain_info-name  ).
        lref_domain->set_api_state( io_change_scenario = lref_transport
                                    io_api_state       = lref_api_state ).


      CATCH cx_xco_gen_put_exception INTO DATA(lref_put_exception).
        et_xco_findings = lref_put_exception->findings->get( ).

    ENDTRY.

  ENDMETHOD.

  METHOD data_element_create.

    DATA(lref_environment)     = xco_cp_generation=>environment->dev_system( mc_transport_request ).
    DATA(lref_put_operation)   = lref_environment->create_put_operation( ).

    DATA(lref_dtel) = lref_put_operation->for-dtel->get_object( is_data_element_info-name ).
    IF lref_dtel IS INITIAL.
      DATA(lref_specification) = lref_put_operation->for-dtel->add_object( is_data_element_info-name
                                                                         )->set_package( mc_package
                                                                         )->create_form_specification( ).
    ELSE.
      lref_specification  = lref_dtel->set_package( mc_package )->get_form_specification( ).
    ENDIF.

    lref_specification->set_short_description( is_data_element_info-description ).

    IF is_data_element_info-domname IS NOT INITIAL."Domain based
      lref_specification->set_data_type( xco_cp_abap_repository=>object->doma->for( is_data_element_info-domname ) ).

    ELSEIF is_data_element_info-data_type IS NOT INITIAL."Data Type
      lref_specification->set_data_type( xco_cp_abap_dictionary=>built_in_type->for( iv_type      = is_data_element_info-data_type
                                                                                     iv_length    = is_data_element_info-length
                                                                                     iv_decimals  = is_data_element_info-decimals ) ).
    ENDIF.

    lref_specification->field_label-short->set_length( is_data_element_info-field_label-short-length ).
    lref_specification->field_label-short->set_text( is_data_element_info-field_label-short-text ).

    lref_specification->field_label-medium->set_length( is_data_element_info-field_label-medium-length ).
    lref_specification->field_label-medium->set_text( is_data_element_info-field_label-medium-text ).

    lref_specification->field_label-long->set_length( is_data_element_info-field_label-long-length ).
    lref_specification->field_label-long->set_text( is_data_element_info-field_label-long-text ).

    lref_specification->field_label-heading->set_length( is_data_element_info-field_label-heading-length ).
    lref_specification->field_label-heading->set_text( is_data_element_info-field_label-heading-text ).


    TRY.
        lref_put_operation->execute( ).
        DATA(lref_transport) = xco_cp_cts=>transport->for( mc_transport_request ).
        DATA(lref_api_state) = xco_cp_ars=>api_state->released( VALUE #( ( xco_cp_ars=>visibility->sap_cloud_platform ) ) ).

        DATA(lref_data_element) = xco_cp_abap_repository=>object->dtel->for( is_data_element_info-name ).
        lref_data_element->set_api_state( io_change_scenario = lref_transport
                                          io_api_state       = lref_api_state ).

      CATCH cx_xco_gen_put_exception INTO DATA(lref_put_exception).
        et_xco_findings = lref_put_exception->findings->get( ).

    ENDTRY.


  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA lt_xco_findings TYPE sxco_t_gen_o_findings.

****Domain Create
    domain_values_get(
     IMPORTING
        et_domain_values = DATA(lt_domain_info)
    ).

    LOOP AT lt_domain_info ASSIGNING FIELD-SYMBOL(<lwa_domain_info>).
      CLEAR lt_xco_findings.

      domain_create(
        EXPORTING
          is_domain_info  = <lwa_domain_info>
        IMPORTING
          et_xco_findings = lt_xco_findings
      ).

      LOOP AT lt_xco_findings INTO DATA(lwa_xco_finding).
        out->write( lwa_xco_finding->object_type ).
        out->write( lwa_xco_finding->object_name ).
        out->write( lwa_xco_finding->message->value ).
      ENDLOOP.
    ENDLOOP.
****

****Data Element Create
    data_element_values_get(
      IMPORTING
        et_data_element_values = DATA(lt_data_element_info)
    ).

    LOOP AT lt_data_element_info ASSIGNING FIELD-SYMBOL(<lwa_data_element_info>).
      CLEAR lt_xco_findings.

      data_element_create(
        EXPORTING
          is_data_element_info = <lwa_data_element_info>
        IMPORTING
          et_xco_findings      = lt_xco_findings
      ).

      LOOP AT lt_xco_findings INTO lwa_xco_finding.
        out->write( lwa_xco_finding->object_type ).
        out->write( lwa_xco_finding->object_name ).
        out->write( lwa_xco_finding->message->value ).
      ENDLOOP.
    ENDLOOP.
***

*****Delete Data Element
*    data_element_delete( i_name = 'Z01_MAT_CATEG' ).
*
*****Delete Domain
*    domain_delete( i_name = 'Z01_MAT_CATEG' ).


  ENDMETHOD.



  METHOD data_element_values_get.

    et_data_element_values = VALUE #( ( name = 'Z01_DESCRIPTION'
                                     description = 'Description'
                                     data_type = 'CHAR'
                                     length = '60'
                                     field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Descr.' )
                                                            medium = VALUE #( length = 20
                                                                              text = 'Description' )
                                                            long = VALUE #( length = 40
                                                                            text = 'Description' )
                                                            heading = VALUE #( length = 55
                                                                               text = 'Description' ) ) )
                                  ( name = 'Z01_AMOUNT'
                                     description = 'Amount'
                                     data_type = 'CURR'
                                     length = '15'
                                     decimals = '03'
                                     field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Amount' )
                                                            medium = VALUE #( length = 20
                                                                              text = 'Amount' )
                                                            long = VALUE #( length = 40
                                                                            text = 'Amount' )
                                                            heading = VALUE #( length = 55
                                                                               text = 'Amount' ) ) )

                                     ( name = 'Z01_CURRENCY'
                                       description = 'Currency'
                                       data_type = 'CUKY'
                                       length = '5'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Curcy' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Currency' )
                                                              long = VALUE #( length = 40
                                                                              text = 'Currency' )
                                                              heading = VALUE #( length = 55
                                                                                  text = 'Currency' ) ) )

                                   ( name = 'Z01_ITEM_NO'
                                     description = 'Item Number'
                                     data_type = 'NUMC'
                                     length = '06'
                                     field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Item' )
                                                            medium = VALUE #( length = 20
                                                                              text = 'Item Number' )
                                                            long = VALUE #( length = 40
                                                                            text = 'Item Number' )
                                                            heading = VALUE #( length = 55
                                                                               text = 'Item Number' ) ) )

                                    ( name = 'Z01_MATERIAL_CATEGORY'
                                     description = 'Material Category'
                                     domname = 'Z01_MATERIAL_CATEGORY'
                                     field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Category' )
                                                            medium = VALUE #( length = 20
                                                                              text = 'Category' )
                                                            long = VALUE #( length = 40
                                                                            text = 'Material Category' )
                                                            heading = VALUE #( length = 55
                                                                               text = 'Material Category' ) ) )

                                     ( name = 'Z01_ORDER_STATUS'
                                       description = 'Order Status'
                                       domname = 'Z01_ORDER_STATUS'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                               text = 'Status' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Order Status' )
                                                              long = VALUE #( length = 40
                                                                              text = 'Order Status' )
                                                              heading = VALUE #( length = 55
                                                                                 text = 'Order Status' ) ) )


                                     ( name = 'Z01_MATERIAL_ID'
                                       description = 'Material ID'
                                       domname = 'Z01_MATERIAL_ID'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                               text = 'Mat.' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Material' )
                                                              long = VALUE #( length = 40
                                                                               text = 'Material ID' )
                                                              heading = VALUE #( length = 55
                                                                                 text = 'Material ID' ) ) )

                                     ( name = 'Z01_ORDER_ID'
                                       description = 'Order ID'
                                       domname = 'Z01_ORDER_ID'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                               text = 'Order' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Order ID' )
                                                              long = VALUE #( length = 40
                                                                               text = 'Order ID' )
                                                              heading = VALUE #( length = 55
                                                                                 text = 'Order ID' ) ) )

                                     ( name = 'Z01_PARTNER_ID'
                                       description = 'Partner ID'
                                       domname = 'Z01_PARTNER_ID'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                               text = 'Partner' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Partner ID' )
                                                              long = VALUE #( length = 40
                                                                               text = 'Partner ID' )
                                                              heading = VALUE #( length = 55
                                                                                 text = 'Partner ID' ) ) )


                                      ( name = 'Z01_PARTNER_ROLE'
                                        description = 'Partner Role'
                                        domname = 'Z01_PARTNER_ROLE'
                                        field_label = VALUE #( short = VALUE #( length = 10
                                                                               text = 'Role' )
                                                               medium = VALUE #( length = 20
                                                                                text = 'Partner Role' )
                                                               long = VALUE #( length = 40
                                                                               text = 'Partner Role' )
                                                               heading = VALUE #( length = 55
                                                                                  text = 'Partner Role' ) ) )


                                     ( name = 'Z01_QUANTITY'
                                       description = 'Quantity'
                                       data_type = 'QUAN'
                                       length = '15'
                                       decimals = '03'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Qty' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Quantity' )
                                                              long = VALUE #( length = 40
                                                                              text = 'Quantity' )
                                                              heading = VALUE #( length = 55
                                                                                  text = 'Quantity' ) ) )

                                     ( name = 'Z01_UNIT'
                                       description = 'Unit'
                                       data_type = 'UNIT'
                                       length = '02'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Unit' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Unit' )
                                                              long = VALUE #( length = 40
                                                                              text = 'Unit' )
                                                              heading = VALUE #( length = 55
                                                                                  text = 'Unit' ) ) )
                                     ( name = 'Z01_WEIGHT'
                                       description = 'Weight'
                                       data_type = 'QUAN'
                                       length = '15'
                                       decimals = '03'
                                       field_label = VALUE #( short = VALUE #( length = 10
                                                                             text = 'Weight' )
                                                              medium = VALUE #( length = 20
                                                                                text = 'Weight' )
                                                              long = VALUE #( length = 40
                                                                              text = 'Weight' )
                                                              heading = VALUE #( length = 55
                                                                                  text = 'Weight' ) ) )
                                                                               ).

  ENDMETHOD.

  METHOD domain_values_get.
    et_domain_values = VALUE #( ( name = 'Z01_MATERIAL_CATEGORY'
                                description = 'Material Category'
                                data_type = 'CHAR'
                                length = '02'
                                output_length = '02'
                                fixed_values = VALUE #( ( lower_limit = 'SP'
                                                          description = 'SmartPhone' )

                                                         ( lower_limit = 'CA'
                                                           description = 'Computer Accessories' )

                                                         ( lower_limit = 'LP'
                                                           description = 'Laptop' )

                                                         ( lower_limit = 'NB'
                                                           description = 'Notebooks' )

                                                           ) )

                              ( name = 'Z01_ORDER_STATUS'
                                description = 'Order Status'
                                data_type = 'CHAR'
                                length = '02'
                                output_length = '02'
                                fixed_values = VALUE #( ( lower_limit = 'OP'
                                                          description = 'Open' )

                                                         ( lower_limit = 'PR'
                                                           description = 'Processing' )

                                                         ( lower_limit = 'CO'
                                                           description = 'Completed' )

                                                         ( lower_limit = 'CL'
                                                           description = 'Closed' )

                                                         ( lower_limit = 'CA'
                                                           description = 'Cancelled' )

                                                         ( lower_limit = 'RL'
                                                           description = 'Released' )

                                                         ( lower_limit = 'BL'
                                                           description = 'Blocked' )

                                                           ) )

                              ( name = 'Z01_PARTNER_ROLE'
                                description = 'Partner Role'
                                data_type = 'CHAR'
                                length = '02'
                                output_length = '02'
                                fixed_values = VALUE #( ( lower_limit = 'ST'
                                                          description = 'Sold-to Party' )

                                                         ( lower_limit = 'SH'
                                                           description = 'Ship-to Party' )

                                                         ( lower_limit = 'BP'
                                                           description = 'Bill-to Party' )

                                                         ( lower_limit = 'CU'
                                                           description = 'Customer' )

                                                         ( lower_limit = 'SP'
                                                           description = 'Supplier' )

                                                         ( lower_limit = 'VN'
                                                           description = 'Vendor' )

                                                           ) )

                              ( name = 'Z01_MATERIAL_ID'
                                description = 'Material ID'
                                data_type = 'NUMC'
                                length = '10'
                                output_length = '10' )

                               ( name = 'Z01_ORDER_ID'
                                description = 'Order ID'
                                data_type = 'NUMC'
                                length = '10'
                                output_length = '10' )

                               ( name = 'Z01_PARTNER_ID'
                                description = 'Partner ID'
                                data_type = 'NUMC'
                                length = '10'
                                output_length = '10' )


                                ).
  ENDMETHOD.

  METHOD domain_delete.

    DATA(lref_environment)   = xco_cp_generation=>environment->dev_system( mc_transport_request ).
    DATA(lref_put_operation) = lref_environment->create_put_operation( ).

    DATA(lref_transport) = xco_cp_cts=>transport->for( mc_transport_request ).
    DATA(lref_api_state) = xco_cp_ars=>api_state->not_released( ).

    DATA(lref_domain) = xco_cp_abap_repository=>object->doma->for( i_name ).
    CHECK lref_domain->exists( ) IS NOT INITIAL.

    IF lref_domain->get_api_state( )->get_release_state( )->value EQ 'RELEASED'.
      lref_domain->set_api_state( io_change_scenario = lref_transport
                                  io_api_state       = lref_api_state ).
    ENDIF.

    DATA(lref_delete_operation) = lref_environment->for-doma->create_delete_operation( ).
    lref_delete_operation->add_object( i_name ).
    lref_delete_operation->execute( ).

  ENDMETHOD.

  METHOD data_element_delete.

    DATA(lref_environment)   = xco_cp_generation=>environment->dev_system( mc_transport_request ).
    DATA(lref_put_operation) = lref_environment->create_put_operation( ).

    DATA(lref_transport) = xco_cp_cts=>transport->for( mc_transport_request ).
    DATA(lref_api_state) = xco_cp_ars=>api_state->not_released( ).

    DATA(lref_data_element) = xco_cp_abap_repository=>object->dtel->for( i_name ).
    CHECK lref_data_element->exists( ) IS NOT INITIAL.

    IF lref_data_element->get_api_state( )->get_release_state( )->value EQ 'RELEASED' .
      lref_data_element->set_api_state( io_change_scenario = lref_transport
                                        io_api_state       = lref_api_state ).
    ENDIF.

    DATA(lref_delete_operation) = lref_environment->for-dtel->create_delete_operation( ).
    lref_delete_operation->add_object( i_name ).
    lref_delete_operation->execute( ).

  ENDMETHOD.

ENDCLASS.
