@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity Z01_C_SalesOrderItem
  as select from Z01_I_SalesOrderItemEnhanced
{
  key OrderId,
  key ItemNo,
      MaterialId,
      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      @EndUserText.label: 'Material'
      MaterialDescription,

      @Search: {
          defaultSearchElement: true,
          fuzzinessThreshold: 0.7
      }
      @EndUserText.label: 'Category'
      CategoryDescription,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      Weight,
      WeightUnit,

      @Semantics.quantity.unitOfMeasure: 'Unit'
      Quantity,
      Unit,

      @Semantics.amount.currencyCode: 'Currency'
      Price,
      Currency,

      @Semantics.amount.currencyCode: 'Currency'
      @EndUserText.label: 'Total Amount'
      TotalPrice,
      /* Associations */
      _Currency,
      _Material,
      _SalesOrderHeader
}
