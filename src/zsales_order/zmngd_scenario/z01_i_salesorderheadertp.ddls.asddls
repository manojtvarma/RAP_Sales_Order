@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z01_I_SalesOrderHeaderTP
  as select from Z01_I_SalesOrderHeaderEnhanced
  composition [1..*] of Z01_I_SalesOrderItemTP as _SalesOrderItem
{
  key OrderId,
      OrderType,
      OrderIcon,

      PartnerId,
      PartnerName,
      PartnerRoleDescription,

      OrderStatus,
      OrderStatusCriticality,
      OrderStatusDescription,
      OrderTypeDescription,

      @Semantics.amount.currencyCode: 'Currency'
      TotalAmount,
      Currency,

      /*Admin Information*/
      CreatedDateTime,
      CreatedOn,
      CreatedAt,
      CreatedBy,
      ChangedDateTime,
      ChangedOn,
      ChangedAt,
      ChangedBy,

      /* Associations */
      _Currency,
      _OrderStatusText,
      _Partner,
      _SalesOrderItem
}
