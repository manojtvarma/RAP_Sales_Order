@Metadata.layer: #CORE

@UI.headerInfo: {
    typeNamePlural: 'Sales Orders',
    /*ObjectPage*/
    title.value: 'OrderType',    //Title
    description.value: 'OrderId', //SubTitle
    imageUrl: 'OrderIcon'
}

annotate entity Z01_C_SalesOrderHeader with
{
  /*ObjectPage*/
  @UI.facet: [
      {
          id: 'Header',
          position: 10,
          label: 'Header',
          type: #COLLECTION
      },
      {
          id: 'General',
          label: 'General',
          parentId: 'Header',
          position: 10,
          targetQualifier: 'GRP1',
          type: #FIELDGROUP_REFERENCE
      },
      {
          id: 'AdminInfo',
          label: 'Admin Info',
          parentId: 'Header',
          position: 20,
          targetQualifier: 'GRP2',
          type: #FIELDGROUP_REFERENCE
      },
      {
          id: 'Items',
          position: 20,
          label: 'Items',
          type: #LINEITEM_REFERENCE,
          targetElement: '_SalesOrderItem'
      },
       /*Data Points*/
      {
          id:'SnappingHeader1',
          purpose: #HEADER,
          type: #DATAPOINT_REFERENCE,
          targetQualifier: 'OrderStatus',
          position: 10
      },
      {
          id:'SnappingHeader3',
          purpose: #HEADER,
          type: #DATAPOINT_REFERENCE,
          targetQualifier: 'TotalAmount',
          position: 20
      }
  ]

  @UI: {
    selectionField: [{ position: 10 }],
    lineItem: [{ position: 10 }],
    fieldGroup: [{ position: 10,
                   qualifier: 'GRP1' }]
  }
  OrderId;

  @UI.lineItem: [{ position: 20 }]
  @UI.fieldGroup: [{ position: 20, qualifier: 'GRP1' }]
  OrderType;

  @UI: {
    selectionField: [{ position: 30  }],
    lineItem: [{ position: 30,
                 label: 'Partner',
                 type: #AS_CONTACT,
                 value: '_PartnerContactCard'}],
    fieldGroup: [{ position: 30,
                   qualifier: 'GRP1',
                   label: 'Partner',
                   type:#AS_CONTACT,
                   value: '_PartnerContactCard' }]
  }
  PartnerId;

  @UI.selectionField: [{ position: 40 }]
  OrderStatus;

  @UI: {
    lineItem: [{ position: 40,
                 criticality: 'OrderStatusCriticality',
                 criticalityRepresentation: #WITHOUT_ICON }],
    dataPoint:{
        title: 'Order Status',
        qualifier: 'OrderStatus'
    }
  }
  @EndUserText.label: 'Order Status'
  OrderStatusDescription;


  @UI: {
    lineItem: [{ position: 60 }],
    dataPoint:{
        title: 'Total Amount',
        qualifier: 'TotalAmount'
  }}
  TotalAmount;

  @UI.fieldGroup: [{ position: 10,
                   qualifier: 'GRP2',
                   label: 'Created On' }]
  CreatedOn;

  @UI.fieldGroup: [{ position: 20,
                     qualifier: 'GRP2',
                     label: 'Created At' }]
  CreatedAt;

  @UI.fieldGroup: [{ position: 30,
                     qualifier: 'GRP2',
                     label: 'Created By' }]
  CreatedBy;

  @UI.fieldGroup: [{ position: 40,
                    qualifier: 'GRP2',
                    label: 'Changed On' }]
  ChangedOn;

  @UI.fieldGroup: [{ position: 50,
                     qualifier: 'GRP2',
                     label: 'Changed At' }]
  ChangedAt;

  @UI.fieldGroup: [{ position: 60,
                     qualifier: 'GRP2',
                     label: 'Changed By' }]
  ChangedBy;

}