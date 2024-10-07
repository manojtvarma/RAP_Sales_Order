@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status Description'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Z01_I_OrderStatusText
 as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z01_ORDER_STATUS' )
{

  key value_low as OrderStatus,
      text      as Description
}
