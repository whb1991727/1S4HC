@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Demo Bonus Points'
define root view entity ZI_I532650_BNPT
  as select from zi532650_bnpt as z_i532650_bounspoints
{
  key uuid as UUID,
  key customer as Customer,
  points as Points,
  
  abp_locinst_lastchange_date as AbpLocinstLastchangeDate,
  abp_locinst_lastchange_time as AbpLocinstLastchangeTime,
  abp_locinst_lastchange_tstmpl as AbpLocinstLastchangeTstmpl,
  abp_locinst_lastchange_utcl as AbpLocinstLastchangeUtcl,
  abp_lastchange_date as AbpLastchangeDate,
  abp_lastchange_time as AbpLastchangeTime,
  abp_lastchange_tstmpl as AbpLastchangeTstmpl,
  abp_lastchange_utcl as AbpLastchangeUtcl
  
}
