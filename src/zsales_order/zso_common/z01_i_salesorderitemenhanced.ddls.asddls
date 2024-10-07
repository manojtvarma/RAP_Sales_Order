@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_SalesOrderItemEnhanced
  as select from Z01_I_SalesOrderItem
{
  key OrderId,
  key ItemNo,
      MaterialId,
      _Material.Description                                                      as MaterialDescription,

      _Material._MaterialCategoryText.Description                                as CategoryDescription,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      _Material.Weight                                                           as Weight,
      _Material.WeightUnit                                                       as WeightUnit,

      @Semantics.quantity.unitOfMeasure: 'Unit'
      Quantity,
      Unit,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      Currency,
      @Semantics.amount.currencyCode: 'Currency'
      cast( Quantity as abap.dec( 15, 2 ) ) * cast( Price as abap.dec( 15, 2 ) ) as TotalPrice,
      /* Associations */
      _Currency,
      _Material,
      _SalesOrderHeader

}
