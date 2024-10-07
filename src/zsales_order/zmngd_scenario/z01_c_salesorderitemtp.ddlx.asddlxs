@Metadata.layer: #CORE

@UI.headerInfo:{
    title.value: 'MaterialDescription',
    description.value: 'ItemNo'//SubTitle
}

annotate entity Z01_C_SalesOrderItemTP with
{

  @UI.facet:[
      {
          id: 'Item',
          position: 10,
          label: 'Item',
          type: #COLLECTION
      },
      {
          id: 'General',
          label: 'General',
          parentId: 'Item',
          position: 10,
          targetQualifier: 'GRP1',
          type: #FIELDGROUP_REFERENCE
      },
      {
           id: 'Amount',
           label: 'Amount',
           parentId: 'Item',
           position: 20,
           targetQualifier: 'GRP2',
           type: #FIELDGROUP_REFERENCE
      },
      {
           id: 'Other',
           label: 'Other Info',
           parentId: 'Item',
           position: 30,
           targetQualifier: 'GRP3',
           type: #FIELDGROUP_REFERENCE
      }
  ]

  @UI: {
      lineItem: [{ position: 10,
                   label: 'Item' }],
      fieldGroup: [{ position: 10,
                     qualifier: 'GRP1' }]
  }
  ItemNo;

  @UI: {
      lineItem: [{ position: 20}],
      fieldGroup: [{ position: 20,
                     qualifier: 'GRP1' }]
  }
  MaterialDescription;

  @UI: {
    lineItem: [{ position: 30 }],
    fieldGroup: [{ position: 30,
                     qualifier: 'GRP1' }]
  }
  Quantity;

  @UI: {
    lineItem: [{ position: 40 }],
    fieldGroup: [{ position: 10,
                       qualifier: 'GRP2' }]
  }
  Price;

  @UI: {
    lineItem: [{ position: 50 }],
    fieldGroup: [{ position: 20,
                     qualifier: 'GRP2' }]
  }
  TotalPrice;

  @UI.fieldGroup: [{ position: 10,
                     qualifier: 'GRP3' }]
  CategoryDescription;

  @UI.fieldGroup: [{ position: 20,
                     qualifier: 'GRP3' }]
  Weight;

}