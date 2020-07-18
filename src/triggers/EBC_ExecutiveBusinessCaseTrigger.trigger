/*Trigger has been modified to handle new attachment validation process*/
/*Author --Ramesh Dugar-- Date- 1/11/17*/
trigger EBC_ExecutiveBusinessCaseTrigger on Executive_Business_Case__c (before update, before insert) {
   
    if(Trigger.isUpdate){
       EBC_ExecutiveBusinessCaseTriggerHelper.EBCAttachmentError(trigger.newMap,trigger.oldMap);   
	}
    if(trigger.isInsert){
        for(Executive_Business_Case__c e:trigger.new){
            if(e.Is_Concept_Attached__c=='Attached'){
                e.Is_Concept_Attached__c='Not Attached';
            }
        }
    }
}