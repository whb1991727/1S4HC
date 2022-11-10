@AbapCatalog.sqlViewName: 'ZI532650_JE_CDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for table zi532650_je'

define view zi_i532650_je
    with parameters 
    p_bukrs: bukrs,
    p_gjahr: gjahr,
    p_rldnr1: fins_ledger,
    p_rldnr2: fins_ledger
as select from zi532650_je {
    key bukrs as Bukrs,
    key gjahr as Gjahr,
    key belnr as Belnr,
    key buzei as Buzei,
    racct as Racct,
    case when rldnr = :p_rldnr1 then amount else 0 end as amount1,
    case when rldnr = :p_rldnr2 then amount else 0 end as amount2,
    waers as Waers
} 
where bukrs = $parameters.p_bukrs
and gjahr = $parameters.p_gjahr 
and ( rldnr = $parameters.p_rldnr1 or rldnr = $parameters.p_rldnr2)
