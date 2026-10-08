@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Margin Analysis Report P View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSALESORDER_REPORT_PV 
provider contract transactional_query
as projection on ZSALESORDER_REPORT_RV
{
key SO,             //Serial Number
//key WF_ID,        
key WorkflowTaskInternalID,          //Workflow Id
Created_By,                          // Who Created the Sales Order 
Created_By_Name,                     // Who Created the Sales Order Full Name
Created_Date,                        // Creation of the Sales Order Date
Processor,                           // Approvers ID
Processor_Name,                      // Approvers Full Name
Status                               // CCompleted or not completed Status 
}
