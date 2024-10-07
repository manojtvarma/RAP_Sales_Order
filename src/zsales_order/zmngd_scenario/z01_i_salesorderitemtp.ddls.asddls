@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_SalesOrderItemTP
  as select from Z01_I_SalesOrderItemEnhanced
  association to parent Z01_I_SalesOrderHeaderTP as _SalesOrderHeader on $projection.OrderId = _SalesOrderHeader.OrderId
{

  key OrderId,
  key ItemNo,
      MaterialId,
      MaterialDescription,
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
      TotalPrice,
      
      /* Associations */
      _Currency,
      _Material,
      _SalesOrderHeader
}
