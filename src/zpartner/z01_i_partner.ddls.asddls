@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_Partner
  as select from z01_partner
  association [1] to Z01_I_PartnerRoleText as _PartnerRoleText on $projection.PartnerRole = _PartnerRoleText.PartnerRole
{
  key partner_id    as PartnerId,
      partner_role  as PartnerRole,
      first_name    as FirstName,
      last_name     as LastName,
      email_address as EmailAddress,
      phone_number  as PhoneNumber,
      street        as Street,
      city          as City,
      postal_code   as PostalCode,
      country_code  as CountryCode,
      
     /* Associations */
     _PartnerRoleText
      
}
