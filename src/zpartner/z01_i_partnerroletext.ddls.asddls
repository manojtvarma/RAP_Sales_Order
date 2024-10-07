@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Role Description'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Z01_I_PartnerRoleText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z01_PARTNER_ROLE' )
{

  key value_low as PartnerRole,
      text      as Description
}
