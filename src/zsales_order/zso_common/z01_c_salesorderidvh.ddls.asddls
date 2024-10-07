@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order ID Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity Z01_C_SalesOrderIdVH
  as select from Z01_I_SalesOrderHeaderEnhanced
  association [1] to Z01_I_OrderStatusText as _OrderStatusText on $projection.OrderStatus = _OrderStatusText.OrderStatus
{

  key OrderId,
      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      
      @UI.hidden: true
      OrderStatus,
      @EndUserText.label: 'Order Status'
      _OrderStatusText.Description,

      /* Associations */
      _OrderStatusText
}
