@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z01_I_Material
  as select from z01_material
  association [1] to Z01_I_MaterialCategoryText as _MaterialCategoryText on $projection.Category = _MaterialCategoryText.Category
{
  key material_id  as MaterialId,
      description  as Description,
      category     as Category,
      
      measure_unit as MeasureUnit,
      
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      weight       as Weight,
      weight_unit  as WeightUnit,
      
      @Semantics.amount.currencyCode: 'Currency'
      price        as Price,
      currency     as Currency,
      
      /* Associations */
      _MaterialCategoryText
}
