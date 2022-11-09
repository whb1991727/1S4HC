@EndUserText.label: 'Ledger Comparison For Demo'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_I532650_LEDGER_COMPARISON'

@UI.headerInfo: { typeName: 'Ledger Comparison'}

define custom entity ZI_I532650_Ledger_Comparison 
with parameters 
@Consumption.valueHelpDefinition: [{ entity: {name:'I_COMPANYCODEVH' ,element: 'CompanyCode' } }] 
  p_bukrs: bukrs,      
  p_gjahr: gjahr,

@EndUserText.label: 'First Ledger1'  
  p_ledger1: fins_ledger,
  
@EndUserText.label: 'Second Ledger'  
  p_ledger2: fins_ledger
  
  { 
    
    key companycode : bukrs;
    
    
//   @Consumption.filter: { mandatory: true , selectionType: #RANGE, multipleSelections: false, defaultValue: '2022'}
    key fiscalyear : gjahr;
    
    @UI.lineItem :[{label:'Account',position:10 ,importance: #HIGH }]
    glaccount : abap.char(10);
    
     
    @Semantics.amount.currencyCode : 'waers'
    @UI.lineItem :[{label:'First Ledger Amount',position:30 ,importance: #HIGH }]
    ledger1amount : abap.curr(23,2);
    
    
    @UI.lineItem :[{label:'Second Ledger Amount',position:50 ,importance: #HIGH }] 
    @Semantics.amount.currencyCode : 'waers'
    ledger2amount : abap.curr(23,2);
    
    @UI.lineItem :[{label:'Difference',position:70 ,importance: #HIGH }] 
    @Semantics.amount.currencyCode : 'waers'
    difamount : abap.curr(23,2);
    
    @UI.hidden: true
    waers: waers;
  }

