@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity Z01_C_PartnerVH
  as select from Z01_I_Partner
  association [1] to Z01_I_PartnerRoleText as _PartnerRoleText on $projection.PartnerRole = _PartnerRoleText.PartnerRole
{
  key PartnerId,

      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      FirstName,
      
      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      LastName,
      
      @UI.hidden: true
      PartnerRole,
      @EndUserText.label: 'Role'
      _PartnerRoleText.Description                as Role,

      /* Associations */
      _PartnerRoleText

}
