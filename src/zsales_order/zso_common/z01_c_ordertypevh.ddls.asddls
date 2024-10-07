@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity Z01_C_OrderTypeVH
  as select from Z01_I_OrderTypeText
{
      @ObjectModel.text.element: [ 'Description' ]
  key OrderType,
      @Search: {
             defaultSearchElement: true,
             fuzzinessThreshold: 0.7
      }
      Description
}
