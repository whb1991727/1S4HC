@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED onlineshop'
define root view entity ZI_ONLINESHOP_WHB
  as select from zonline_shop as onlineshop
{
  key order_uuid as OrderUUID,
  order_id as OrderID,
  ordereditem as Ordereditem,
  deliverydate as Deliverydate,
  creationdate as Creationdate
  
}
