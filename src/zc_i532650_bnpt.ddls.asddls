@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_I532650_BNPT'
@ObjectModel.semanticKey: [ 'Customer' ]
define root view entity ZC_I532650_BNPT
  provider contract transactional_query
  as projection on ZI_I532650_BNPT
{
  key UUID,
  key Customer,
  Points,
  AbpLocinstLastchangeDate,
  AbpLocinstLastchangeTime,
  AbpLocinstLastchangeTstmpl,
  AbpLocinstLastchangeUtcl,
  AbpLastchangeTime,
  AbpLastchangeTstmpl,
  AbpLastchangeUtcl
  
  
}
