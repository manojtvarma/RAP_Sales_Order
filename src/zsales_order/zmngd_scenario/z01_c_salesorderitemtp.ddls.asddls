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
define view entity Z01_C_SalesOrderItemTP
  as projection on Z01_I_SalesOrderItemTP
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
      @EndUserText.label: 'Total Amount'
      @Semantics.amount.currencyCode: 'Currency'
      TotalPrice,
      /* Associations */
      _Currency,
      _Material,
      _SalesOrderHeader : redirected to parent Z01_C_SalesOrderHeaderTP
}
