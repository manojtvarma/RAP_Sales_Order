@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity Z01_C_OrderStatusVH
  as select from Z01_I_OrderStatusText
{
      @EndUserText.label: 'Order Status'
      @ObjectModel.text.element: [ 'Description' ]
  key OrderStatus,
      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      @EndUserText.label: 'Description'
      Description
}
