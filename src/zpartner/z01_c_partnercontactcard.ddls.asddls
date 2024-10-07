@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity Z01_C_PartnerContactCard
  as select from Z01_I_Partner
{
  key PartnerId,
      FirstName,
      LastName,
      @Semantics: {
//          text: true,
          name.fullName: true
      }
      concat_with_space( FirstName, LastName, 1 ) as Name,

      @Semantics.eMail.type: [ #WORK ]
      EmailAddress,

      @Semantics.telephone.type: [ #WORK ]
      PhoneNumber,

      @Semantics.address.street: true
      Street,
      @Semantics.address.city: true
      City,
      @Semantics.address.zipCode: true
      PostalCode,
      @Semantics.address.country: true
      CountryCode
}
