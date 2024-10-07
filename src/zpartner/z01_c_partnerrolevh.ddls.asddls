@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Role'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity Z01_C_PartnerRoleVH
  as select from Z01_I_PartnerRoleText
{
      @ObjectModel.text.element: [ 'Description' ]
  key PartnerRole,
      Description
}
