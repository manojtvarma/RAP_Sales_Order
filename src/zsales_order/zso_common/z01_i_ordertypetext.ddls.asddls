@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Type Description'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Z01_I_OrderTypeText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z01_ORDER_TYPE' )
{
  key value_low as OrderType,
      text      as Description
}
