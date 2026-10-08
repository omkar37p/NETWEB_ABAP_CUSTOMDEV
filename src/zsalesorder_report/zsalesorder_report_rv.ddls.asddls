@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Margin Analysis Report Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSALESORDER_REPORT_RV 
as select from I_SalesOrder as SOH
inner join I_WorkflowStatusOverview as WF on WF.SAPBusinessObjectNodeKey1 = SOH.SalesOrder and WF.SAPObjectNodeRepresentation = 'SalesOrder'
inner join I_WorkflowStatusDetails as WFS on WFS.WorkflowInternalID = WF.WorkflowInternalID  // and WFS.WorkflowTaskProcessor = ' '
left outer join I_WorkflowRecipients_V2 as WFR on WFR.WorkflowInternalID = WFS.WorkflowInternalID and WFR.WorkflowTaskInternalID = WFS.WorkflowTaskInternalID
//inner join YY1_salesorderworkflow as WFS on WFS.WorkflowInternalID = WF.WorkflowInternalID
left outer join I_BusinessUserBasic as SUID on SUID.UserID = SOH.CreatedByUser
left outer join I_BusinessUserBasic as WUID on WUID.UserID = WFS.WorkflowTaskProcessor
left outer join I_BusinessUserBasic as WUID2 on WUID2.UserID = WFR.WorkflowTaskRecipient
{
key SOH.SalesOrder as SO,
key WFS.WorkflowTaskInternalID , //as WF_ID,
SOH.CreatedByUser as Created_By,
SUID.PersonFullName as Created_By_Name,
SOH.CreationDate as Created_Date,
WFS.WorkflowTaskProcessor as Processor,
WUID.PersonFullName as Processor_Name,
WFS.WorkflowTaskExternalStatus as Status
}
