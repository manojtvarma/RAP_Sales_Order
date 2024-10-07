CLASS zcl_auto_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS: generate_data,
      delete_all_data.

  PRIVATE SECTION.
    METHODS:
      generate_customers,
      generate_materials,
      generate_sales_orders.

ENDCLASS.

CLASS zcl_auto_generate_data IMPLEMENTATION.

  METHOD generate_customers.

    DATA lt_customer   TYPE TABLE OF z01_partner.

    APPEND VALUE #( partner_id = '0000000001'
                    partner_role = 'ST'
                    first_name = 'John'
                    last_name = 'Doe'
                    email_address = 'john.doe@example.com'
                    phone_number = '+1234567890'
                    address = VALUE z01_address( street = '123 Main St'
                                                  city = 'Springfield'
                                                  postal_code = '12345'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000002'
                    partner_role = 'SH'
                    first_name = 'Alice'
                    last_name = 'Smith'
                    email_address = 'alice.smith@example.com'
                    phone_number = '+1234567891'
                    address = VALUE z01_address( street = '456 Oak Ave'
                                                  city = 'Springfield'
                                                  postal_code = '12346'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000003'
                    partner_role = 'BP'
                    first_name = 'Bob'
                    last_name = 'Johnson'
                    email_address = 'bob.johnson@example.com'
                    phone_number = '+1234567892'
                    address = VALUE z01_address( street = '789 Pine St'
                                                  city = 'Springfield'
                                                  postal_code = '12347'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000004'
                    partner_role = 'ST'
                    first_name = 'Jane'
                    last_name = 'Smith'
                    email_address = 'jane.smith@example.com'
                    phone_number = '+1234567891'
                    address = VALUE z01_address( street = '456 Elm St'
                                                  city = 'Springfield'
                                                  postal_code = '12346'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000005'
                    partner_role = 'ST'
                    first_name = 'Michael'
                    last_name = 'Johnson'
                    email_address = 'michael.johnson@example.com'
                    phone_number = '+1234567892'
                    address = VALUE z01_address( street = '789 Pine St'
                                                  city = 'Springfield'
                                                  postal_code = '12347'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000006'
                    partner_role = 'SH'
                    first_name = 'Emily'
                    last_name = 'Brown'
                    email_address = 'emily.brown@example.com'
                    phone_number = '+1234567893'
                    address = VALUE z01_address( street = '321 Oak St'
                                                  city = 'Springfield'
                                                  postal_code = '12348'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000007'
                    partner_role = 'BP'
                    first_name = 'David'
                    last_name = 'Williams'
                    email_address = 'david.williams@example.com'
                    phone_number = '+1234567894'
                    address = VALUE z01_address( street = '654 Maple Ave'
                                                  city = 'Springfield'
                                                  postal_code = '12349'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000008'
                    partner_role = 'SH'
                    first_name = 'Olivia'
                    last_name = 'Jones'
                    email_address = 'olivia.jones@example.com'
                    phone_number = '+1234567895'
                    address = VALUE z01_address( street = '987 Birch St'
                                                  city = 'Springfield'
                                                  postal_code = '12350'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000009'
                    partner_role = 'SH'
                    first_name = 'William'
                    last_name = 'Garcia'
                    email_address = 'william.garcia@example.com'
                    phone_number = '+1234567896'
                    address = VALUE z01_address( street = '123 Cedar St'
                                                  city = 'Springfield'
                                                  postal_code = '12351'
                                                  country_code = 'US' ) ) TO lt_customer.

    APPEND VALUE #( partner_id = '0000000010'
                    partner_role = 'ST'
                    first_name = 'Sophia'
                    last_name = 'Martinez'
                    email_address = 'sophia.martinez@example.com'
                    phone_number = '+1234567897'
                    address = VALUE z01_address( street = '456 Walnut St'
                                                  city = 'Springfield'
                                                  postal_code = '12352'
                                                  country_code = 'US' ) ) TO lt_customer.
    INSERT z01_partner FROM TABLE @lt_customer.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD generate_materials.

    DATA lt_material TYPE TABLE OF z01_material.

    APPEND VALUE #(
                    material_id = '0000000001'
                    description = 'Wireless Mouse'
                    category = 'CA'
                    measure_unit = 'EA'
                    weight = '0.15'
                    weight_unit = 'KG'
                    price = '29.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000002'
                    description = 'Keyboard'
                    category = 'CA'
                    measure_unit = 'EA'
                    weight = '0.80'
                    weight_unit = 'KG'
                    price = '89.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000003'
                    description = 'Smartphone A1'
                    category = 'SP'
                    measure_unit = 'EA'
                    weight = '0.17'
                    weight_unit = 'KG'
                    price = '299.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000004'
                    description = 'Smartphone B2'
                    category = 'SP'
                    measure_unit = 'EA'
                    weight = '0.15'
                    weight_unit = 'KG'
                    price = '399.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000005'
                    description = 'HP Laptop'
                    category = 'LP'
                    measure_unit = 'PC'
                    weight = '1.50'
                    weight_unit = 'KG'
                    price = '799.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000006'
                    description = 'Dell Laptop'
                    category = 'LP'
                    measure_unit = 'PC'
                    weight = '1.80'
                    weight_unit = 'KG'
                    price = '1199.99'
                    currency = 'USD' ) TO lt_material.


    APPEND VALUE #(
                    material_id = '0000000007'
                    description = 'Samsung Galaxy M1'
                    category = 'SP'
                    measure_unit = 'EA'
                    weight = '0.17'
                    weight_unit = 'KG'
                    price = '299.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000008'
                    description = 'Samsung Galaxy M2'
                    category = 'SP'
                    measure_unit = 'EA'
                    weight = '0.15'
                    weight_unit = 'KG'
                    price = '399.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000009'
                    description = 'Asus Laptop'
                    category = 'LP'
                    measure_unit = 'PC'
                    weight = '2.50'
                    weight_unit = 'KG'
                    price = '799.99'
                    currency = 'USD' ) TO lt_material.

    APPEND VALUE #(
                    material_id = '0000000010'
                    description = 'Levovo Laptop'
                    category = 'LP'
                    measure_unit = 'PC'
                    weight = '1.90'
                    weight_unit = 'KG'
                    price = '1199.99'
                    currency = 'USD' ) TO lt_material.


    INSERT z01_material FROM TABLE @lt_material.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD generate_sales_orders.

    DATA: lt_material        TYPE TABLE OF z01_material,
          lt_customer        TYPE TABLE OF z01_partner,
          lt_so_hdr          TYPE TABLE OF z01_so_header,
          lt_so_item         TYPE TABLE OF z01_so_item,
          lv_order_id        TYPE z01_order_id,
          lv_partner_id      TYPE z01_partner_id,
          lv_amount          TYPE z01_amount,
          lv_item_amount     TYPE z01_amount,
          lv_currency        TYPE z01_currency,
          ls_material        TYPE z01_material,
          lv_quantity        TYPE z01_quantity,
          lv_so_counter      TYPE n LENGTH 10 VALUE '0000000001',
          lv_so_item_counter TYPE n LENGTH 6 VALUE '000001'.

    SELECT * FROM z01_material
    INTO TABLE @lt_material.

    SELECT * FROM z01_partner
    INTO TABLE @lt_customer.

    SELECT * FROM Z01_I_OrderStatusText
    INTO TABLE @DATA(lt_order_status).

    DATA(lref_random_generator) = cl_abap_random=>create( seed = cl_abap_random=>seed( ) ).

    "Generate 10 Sales Order
    DO 10 TIMES.
      CLEAR: lv_so_counter,
             lv_order_id,
             lv_partner_id,
             lv_amount.

      DATA(lv_index) = sy-index.
      lv_order_id = lv_so_counter +   sy-index."Generate Sales Order Number
      lv_partner_id = VALUE #( lt_customer[ sy-index ]-partner_id OPTIONAL ).

      " Generate items for this order
      DO 3 TIMES.
        DATA: lv_item_no     TYPE z01_item_no,
              lv_material_id TYPE z01_material_id.

        CLEAR lv_so_item_counter.

        lv_item_no = lv_so_item_counter +  sy-index."Generate item number
        lv_material_id = VALUE #( lt_material[ sy-index ]-material_id OPTIONAL ).
        lv_quantity = sy-index.

        READ TABLE lt_material INTO ls_material
        WITH KEY material_id = lv_material_id.
        IF sy-subrc = 0.
          lv_item_amount = ls_material-price * lv_quantity.
          lv_currency = ls_material-currency.

          APPEND VALUE #(
                          order_id = lv_order_id
                          item_no = lv_item_no
                          material_id = lv_material_id
                          quantity = lv_quantity
                          unit = 'EA'
                          price = ls_material-price
                          currency = lv_currency ) TO lt_so_item.

          lv_amount = lv_amount + lv_item_amount.
        ENDIF.
      ENDDO.

      DATA(lv_random_number) = lref_random_generator->intinrange( low = 1 high = lines( lt_order_status ) ).
      DATA(lv_order_status) = VALUE #( lt_order_status[ lv_random_number ]-OrderStatus OPTIONAL ).

      " Ensure the total amount in header matches the sum of items
      APPEND VALUE #(
                      order_id = lv_order_id
                      partner_id = lv_partner_id
                      order_status = lv_order_status
                      order_type = 'OR'
                      total_amount = lv_amount
                      currency = lv_currency
                      admin = VALUE z01_admin( created_by = sy-uname
                                               created_date_time = sy-datum && sy-uzeit
                                               changed_by  = sy-uname
                                               changed_date_time  = sy-datum && sy-uzeit )
                            ) TO lt_so_hdr.

    ENDDO.

    INSERT z01_so_header FROM TABLE @lt_so_hdr.
    INSERT z01_so_item FROM TABLE @lt_so_item.

  ENDMETHOD.

  METHOD generate_data.
    generate_customers( ).
    generate_materials( ).
    generate_sales_orders( ).
  ENDMETHOD.

  METHOD delete_all_data.
    DELETE FROM z01_partner.
    DELETE FROM z01_material.
    DELETE FROM z01_so_header.
    DELETE FROM z01_so_item.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    DATA(lref_sales_order) = NEW zcl_auto_generate_data( ).
    lref_sales_order->delete_all_data( ).
    lref_sales_order->generate_data( ).
  ENDMETHOD.

ENDCLASS.

