@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z01_C_SalesOrderHeaderTP
  provider contract transactional_query
  as projection on Z01_I_SalesOrderHeaderTP as _SalesOrderHeader
  association [1] to Z01_C_PartnerContactCard as _PartnerContactCard on _SalesOrderHeader.PartnerId = _PartnerContactCard.PartnerId
{

      @Consumption.valueHelpDefinition: [{
        entity: {
            name: 'Z01_C_SalesOrderIdVH',
            element: 'OrderId'
        }
      }]
  key OrderId,

      @Consumption.valueHelpDefinition: [{
          entity: {
          name: 'Z01_C_OrderTypeVH',
          element: 'OrderType'
        }
      }]
      OrderType,
      OrderTypeDescription,
      OrderIcon,

      @EndUserText.label: 'Partner'
      @Consumption.valueHelpDefinition: [{
        entity: {
          name: 'Z01_C_PartnerVH',
          element: 'PartnerId'
        }
      }]
      PartnerId,
      @Consumption.valueHelpDefinition: [{
        entity: {
          name: 'Z01_C_PartnerRoleVH',
          element: 'PartnerRole'
        }
      }]
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
      OrderStatusDescription,
      OrderStatusCriticality,

      @EndUserText.label: 'Total Amount'
      @Semantics.amount.currencyCode: 'Currency'
      TotalAmount,
      Currency,

      /*Admin Information*/
      CreatedDateTime,
      CreatedBy,
      CreatedOn,
      CreatedAt,
      ChangedDateTime,
      ChangedBy,
      ChangedOn,
      ChangedAt,

      /* Associations */
      _Currency,
      _OrderStatusText,
      _Partner,
      _PartnerContactCard,
      _SalesOrderItem : redirected to composition child Z01_C_SalesOrderItemTP
}
