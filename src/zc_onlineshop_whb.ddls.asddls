@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_ONLINESHOP_WHB'
@Search.searchable: true
@ObjectModel.semanticKey: ['OrderID']

define root view entity ZC_ONLINESHOP_WHB 
  as projection on ZI_ONLINESHOP_WHB
{
  key OrderUUID,
@EndUserText.label: 'Order'  
@Search.defaultSearchElement: true
  OrderID,
@EndUserText.label: 'Item'  
  Ordereditem,
@EndUserText.label: 'Delivery Date'   
  Deliverydate,
@EndUserText.label: 'Create Date'  
  Creationdate
}
