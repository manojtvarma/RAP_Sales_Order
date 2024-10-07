@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity Z01_C_SalesOrderHeader
  as select from Z01_I_SalesOrderHeaderEnhanced
  association [1..*] to Z01_C_SalesOrderItem     as _SalesOrderItem     on $projection.OrderId = _SalesOrderItem.OrderId
  association [1]    to Z01_C_OrderStatusVH      as _OrderStatus        on $projection.OrderStatus = _OrderStatus.OrderStatus
  association [1]    to Z01_C_PartnerContactCard as _PartnerContactCard on $projection.PartnerId = _PartnerContactCard.PartnerId
{

      @Consumption.valueHelpDefinition: [{
       entity: {
          name: 'Z01_C_SalesOrderIdVH',
          element: 'OrderId'
        }
       }]
  key OrderId,
      @EndUserText.label: 'Order Type'
      OrderType,
      OrderIcon,
      @Consumption.valueHelpDefinition: [{
        entity: {
          name: 'Z01_C_PartnerVH',
          element: 'PartnerId'
        }
      }]
      PartnerId,
      PartnerRoleDescription,

      @Consumption.valueHelpDefinition: [{
        entity: {
          name: 'Z01_C_OrderStatusVH',
          element: 'OrderStatus'
        }
      }]
      OrderStatus,

      @Search:{
        defaultSearchElement: true,
        fuzzinessThreshold: 0.7
      }
      @EndUserText.label: 'Order Status Description'
      OrderStatusDescription,

      /*
      0 = None (default, no color)
      1 = Negative (red)
      2 = Critical (yellow)
      3 = Positive (green)
      */
      OrderStatusCriticality,

      @EndUserText.label: 'Total Amount'
      @Semantics.amount.currencyCode: 'Currency'
      TotalAmount,
      Currency,

      @EndUserText.label: 'Created On'
      CreatedOn,
      @EndUserText.label: 'Created At'
      CreatedAt,
      @EndUserText.label: 'Created By'
      CreatedBy,

      @EndUserText.label: 'Changed On'
      ChangedOn,
      @EndUserText.label: 'Changed At'
      ChangedAt,
      @EndUserText.label: 'ChangedBy'
      ChangedBy,

      /* Associations */
      _SalesOrderItem,
      _OrderStatus,
      _PartnerContactCard,
      _Partner
}
