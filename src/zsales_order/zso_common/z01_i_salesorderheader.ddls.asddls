@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_SalesOrderHeader
  as select from z01_so_header
  association [1..*] to Z01_I_SalesOrderItemEnhanced as _SalesOrderItem  on $projection.OrderId = _SalesOrderItem.OrderId
  association [1]    to Z01_I_Partner                as _Partner         on $projection.PartnerId = _Partner.PartnerId
  association [1]    to Z01_I_OrderStatusText        as _OrderStatusText on $projection.OrderStatus = _OrderStatusText.OrderStatus
  association [1]    to Z01_I_OrderTypeText          as _OrderTypeText   on $projection.OrderType = _OrderTypeText.OrderType
  association [1]    to I_Currency                   as _Currency        on $projection.Currency = _Currency.Currency


{
  key order_id          as OrderId,
      partner_id        as PartnerId,
      order_status      as OrderStatus,
      order_type        as OrderType,
      @Semantics.amount.currencyCode: 'Currency'
      total_amount      as TotalAmount,
      currency          as Currency,

      @Semantics.systemDateTime.createdAt: true
      created_date_time as CreatedDateTime,
      @Semantics.user.createdBy: true
      created_by        as CreatedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      changed_date_time as ChangedDateTime,
      @Semantics.user.lastChangedBy: true
      changed_by        as ChangedBy,
      /* Associations */
      _SalesOrderItem,
      _Partner,
      _OrderStatusText,
      _OrderTypeText,
      _Currency
}
