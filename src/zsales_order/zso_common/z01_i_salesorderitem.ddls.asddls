@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_SalesOrderItem
  as select from z01_so_item
  association [1] to Z01_I_SalesOrderHeaderEnhanced as _SalesOrderHeader on $projection.OrderId = _SalesOrderHeader.OrderId
  association [1] to Z01_I_Material                 as _Material         on $projection.MaterialId = _Material.MaterialId
  association [1] to I_Currency                     as _Currency         on $projection.Currency = _Currency.Currency
{
  key order_id                                                                   as OrderId,
  key item_no                                                                    as ItemNo,
      material_id                                                                as MaterialId,

      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity                                                                   as Quantity,
      unit                                                                       as Unit,

      @Semantics.amount.currencyCode: 'Currency'
      price                                                                      as Price,
      currency                                                                   as Currency,

      /* Associations */
      _SalesOrderHeader,
      _Material,
      _Currency

}
