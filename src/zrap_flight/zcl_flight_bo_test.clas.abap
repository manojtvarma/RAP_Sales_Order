CLASS zcl_flight_bo_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_flight_bo_test IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



**It will not read any fields data because we have not specified which fields to read
**After FROM we have mention internal table only
*    DATA: lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M,
*          lt_travel_data TYPE TABLE FOR READ RESULT /DMO/I_Travel_M.
*
*    lt_keys = VALUE #( ( travel_id  = 00000006 ) ).
*
*    READ ENTITY /DMO/I_Travel_M
*    FROM lt_keys
*    RESULT lt_travel_data.
*****
*
*****%control stucture mark field value as 01 which we want to read
*    DATA lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M.
*    lt_keys = VALUE #( ( travel_id  = 00000006
*                         %control = VALUE #( travel_id = if_abap_behv=>mk-on
*                                             agency_id = if_abap_behv=>mk-on
*                                             customer_id = if_abap_behv=>mk-on
*                                             overall_status = if_abap_behv=>mk-on
*                                             booking_fee = if_abap_behv=>mk-on
*                                             total_price = if_abap_behv=>mk-on
*                                             currency_code = if_abap_behv=>mk-on
*                                             begin_date = if_abap_behv=>mk-on
*                                             end_date = if_abap_behv=>mk-on
*                                             description = if_abap_behv=>mk-on ) ) ).
*
*    READ ENTITY /DMO/I_Travel_M
*    FROM lt_keys
*    RESULT DATA(lt_travel_data).
*****
*
*****Read Entity with all the fields
*    READ ENTITY /DMO/I_Travel_M
*    ALL FIELDS WITH VALUE #( ( travel_id  = 00000006 ) )
*    RESULT DATA(lt_travel_data).
*
**we can specify key using %key structure also
*    READ ENTITY /DMO/I_Travel_M
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = 00000006 ) )
*    RESULT DATA(lt_travel_data).
*****
*
****After FROM we have mention internal table only
*    READ ENTITY /DMO/I_Travel_M
*    FIELDS ( travel_id agency_id customer_id overall_status booking_fee total_price currency_code )
*    WITH VALUE #( ( %key-travel_id = 00000006 ) )
*    RESULT DATA(lt_travel_data).
*****
*
*
****Reading Booking Information
*Understand %key,%pky and %tkey
*%key: Current Entity[travel_id,booking_id]
*%pky: Parent Entity Key[travel_id,booking_id + %key]
*%tky: Transitive Key(Combination of Parent Key and Child Key) [travel_id,booking_id + %pky + %key]
*
*Example:1
*
*DATA lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Booking_M.
*    lt_keys = VALUE #( ( %key-travel_id = '00000006'
*                         %key-booking_id = '0002' )
*
*                       ( %key-travel_id = '00000006'
*                         %key-booking_id = '0003' ) ).
*
*    READ ENTITY /DMO/I_Booking_M
*    ALL FIELDS WITH lt_keys
*    RESULT DATA(lt_booking_data).
*
*Example:2 Read by Association
*
**    DATA lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M.""LT_KEYS" does not have the right type "TABLE FOR READ IMPORT /DMO/I_TRAVEL_M\_BOOKING" for the operation "READ BY \_BOOKING".
**    DATA lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M\\Booking.""LT_KEYS" does not have the right type "TABLE FOR READ IMPORT /DMO/I_TRAVEL_M\_BOOKING" for the operation "READ BY \_BOOKING".
*    DATA lt_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M\_Booking.
*
*    lt_keys = VALUE #( ( %key-travel_id = '00000006' ) ).
*
*    READ ENTITY /DMO/I_Travel_M
*    BY \_Booking
*    ALL FIELDS WITH lt_keys
*    RESULT DATA(lt_booking_data).
*
*    out->write( lt_booking_data ).
*
**another way
*    READ ENTITY /DMO/I_Travel_M
*    BY \_Booking
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = '00000006' ) )
*    RESULT DATA(lt_booking_data).
*
*Example: 3
*    READ ENTITIES OF /DMO/I_Travel_M
*    ENTITY travel
*    BY \_Booking
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = '00000006' ) )
*    RESULT DATA(lt_booking_data).
*
****Reading Entities: Travel, Booking and BookingSupplement at once
*
*    READ ENTITIES OF /DMO/I_Travel_M
*    ENTITY travel
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = '00000006' ) )
*    RESULT DATA(lt_travel_data)
*
*    ENTITY travel
*    BY \_Booking
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = '00000006' ) )
*    RESULT DATA(lt_booking_data)
*
*    ENTITY booking
*    BY \_BookSupplement
*    ALL FIELDS WITH VALUE #( ( %key-travel_id = '00000006' ) )
*
*    RESULT DATA(lt_booking_supplement).
*    CHECK sy-subrc EQ 0.
****
*
****Read Entities using operations
*    DATA: lt_operation  TYPE abp_behv_retrievals_tab,
*          lwa_operation TYPE abp_behv_retrievals.
*
*   DATA: lt_travel_keys  TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M,
*         lt_booking_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M\_Booking.
**          lt_booking_supplement_keys TYPE TABLE FOR READ IMPORT /DMO/I_Travel_M\\booking\_BookSupplement.
*
*    DATA: lt_travel_data  TYPE TABLE FOR READ RESULT /DMO/I_Travel_M,
*          lt_booking_data TYPE TABLE FOR READ RESULT /DMO/I_Travel_M\_Booking.
*
*    DATA: lt_booking_link TYPE TABLE FOR READ LINK /DMO/I_Travel_M\_Booking.
*
*****Travel Data
*    lt_travel_keys = VALUE #( ( %key-travel_id = '00000006'
*                                %control = VALUE #( travel_id = if_abap_behv=>mk-on
*                                                    agency_id = if_abap_behv=>mk-on
*                                                    customer_id = if_abap_behv=>mk-on
*                                                    overall_status = if_abap_behv=>mk-on
*                                                    booking_fee = if_abap_behv=>mk-on
*                                                    total_price = if_abap_behv=>mk-on
*                                                    currency_code = if_abap_behv=>mk-on
*                                                    begin_date = if_abap_behv=>mk-on
*                                                    end_date = if_abap_behv=>mk-on
*                                                    description = if_abap_behv=>mk-on  ) ) ).
*
*    lwa_operation = VALUE #( op = if_abap_behv=>op-r-read
*                             entity_name = '/DMO/I_TRAVEL_M'
*                             instances = REF #( lt_travel_keys )
*                             results = REF #( lt_travel_data )  )."Read
*    APPEND lwa_operation TO lt_operation.
*****
*
*****Booking Data
*    lt_booking_keys = VALUE #( ( %key-travel_id = '00000006'
*                                 %control = VALUE #( booking_id = if_abap_behv=>mk-on
*                                                     booking_date = if_abap_behv=>mk-on
*                                                     customer_id = if_abap_behv=>mk-on
*                                                     carrier_id = if_abap_behv=>mk-on
*                                                     connection_id = if_abap_behv=>mk-on
*                                                     flight_date = if_abap_behv=>mk-on
*                                                     flight_price = if_abap_behv=>mk-on
*                                                     currency_code = if_abap_behv=>mk-on
*                                                     booking_status = if_abap_behv=>mk-on ) ) ).
*
*    lwa_operation = VALUE #( op = if_abap_behv=>op-r-read_ba"Read by Association
*                             entity_name = '/DMO/I_TRAVEL_M'
*                             sub_name = '_BOOKING'
*                             instances = REF #( lt_booking_keys )
*                             results = REF #( lt_booking_data )
*                              ).
*    APPEND lwa_operation TO lt_operation.
*****
*
*    READ ENTITIES OPERATIONS lt_operation.
*
*    out->write( lt_travel_data  ).
*    out->write( lt_booking_data ).
***

***Create
****Example1: Create Travel Data: Need to Test
    DATA lt_travel_new_data TYPE TABLE FOR CREATE /dmo/i_travel_m.

    lt_travel_new_data = VALUE #( ( agency_id = '070049'
                                    customer_id = '000072'
                                    %control = VALUE #( agency_id = if_abap_behv=>mk-on
                                                        customer_id = if_abap_behv=>mk-on )
                                 ) ).

    MODIFY ENTITY /dmo/i_travel_m
    CREATE AUTO FILL CID
    WITH lt_travel_new_data
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported)
    MAPPED DATA(lt_mapped).

    COMMIT ENTITIES.

    CHECK sy-subrc EQ 0.
***


***Update
*Example:1 Update Travel Description
*    DATA lt_travel_data TYPE TABLE FOR UPDATE /dmo/i_travel_m.
*
*    lt_travel_data = VALUE #( ( %key-travel_id = '00000006'
*                                 description = 'Vacation'
*                                 %control-description = if_abap_behv=>mk-on ) ).
*
*    MODIFY ENTITY /dmo/i_travel_m
*    UPDATE FROM lt_travel_data
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
***

*Example:2 Update Travel Description and Begin Date
*    MODIFY ENTITY /dmo/i_travel_m
*    UPDATE FIELDS ( description begin_date )"specify fields which we want to update
*    WITH VALUE #( (  %key-travel_id = '00000006'
*                     description = 'Vacation'
*                     begin_date = cl_abap_context_info=>get_system_date( )  ) )
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
***


*Example:3 Update Travel Description
*    DATA lt_travel_data TYPE TABLE FOR UPDATE /dmo/i_travel_m.
*
*    lt_travel_data = VALUE #( ( %key-travel_id = '00000006'
*                                 description = 'Vacation Test'
*                                 %control-description = if_abap_behv=>mk-on ) ).
*
*    MODIFY ENTITIES OF /dmo/i_travel_m
*    ENTITY travel
*    UPDATE FROM lt_travel_data
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
*    CHECK sy-subrc EQ 0.
***

*Example:4 Update Travel Description
*    DATA: lt_operation  TYPE abp_behv_changes_tab,
*          lwa_operation TYPE abp_behv_changes.
*
*    DATA lt_travel_data TYPE TABLE FOR UPDATE /dmo/i_travel_m.
*
*    lt_travel_data = VALUE #( ( %key-travel_id = '00000006'
*                                 description = 'Vacation Test'
*                                 %control-description = if_abap_behv=>mk-on ) ).
*
*    lwa_operation  = VALUE #( op = if_abap_behv=>op-m-update
*                              entity_name = '/DMO/I_TRAVEL_M'
*                              instances = REF #( lt_travel_data ) ).
*    APPEND lwa_operation TO lt_operation.
*
*    MODIFY ENTITIES OPERATIONS lt_operation
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
****
*
****Delete: It will automatically delete its child based on associations(booking and supplements)
*
*Example:1
*    DATA lt_travel_keys TYPE TABLE FOR DELETE /dmo/i_travel_m.
*
*    lt_travel_keys = VALUE #( ( %key-travel_id = '00000004' ) ).
*
*    MODIFY ENTITY /dmo/i_travel_m
*    DELETE FROM lt_travel_keys
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
****
*
*Example:2
*
*    DATA lt_travel_keys TYPE TABLE FOR DELETE /dmo/i_travel_m.
*
*    lt_travel_keys = VALUE #( ( %key-travel_id = '00000101' ) ).
*
*    MODIFY ENTITIES OF /dmo/i_travel_m
*    ENTITY travel
*    DELETE FROM lt_travel_keys
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    COMMIT ENTITIES.
*
*    CHECK sy-subrc EQ 0.
****
*
*
*Example:3
*    DATA: lt_operation  TYPE abp_behv_changes_tab,
*          lwa_operation TYPE abp_behv_changes.
*
*    DATA lt_travel_keys TYPE TABLE FOR DELETE /dmo/i_travel_m.
*
*    lt_travel_keys = VALUE #( ( %key-travel_id = '00000005'  ) ).
*    lwa_operation  = VALUE #( op = if_abap_behv=>op-m-delete
*                              entity_name = '/DMO/I_TRAVEL_M'
*                              instances = REF #( lt_travel_keys ) ).
*    APPEND lwa_operation TO lt_operation.
*
*    MODIFY ENTITIES OPERATIONS lt_operation
*    FAILED DATA(lt_failed).
*
*    COMMIT ENTITIES.
***


  ENDMETHOD.
ENDCLASS.
