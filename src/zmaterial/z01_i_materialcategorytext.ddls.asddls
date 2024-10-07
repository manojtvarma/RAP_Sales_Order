@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Category'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity Z01_I_MaterialCategoryText
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'Z01_MATERIAL_CATEGORY' )
{

  key value_low as Category,
      text      as Description
}
