public without sharing class EBC_ExecutiveBusinessCaseTriggerHelper {
  public static void EBCAttachmentError(Map<ID, Executive_Business_Case__c> updatedEBCsMap, Map<ID,Executive_Business_Case__c> oldEBCsMap){
    ID EBCrecType = Schema.SObjectType.Executive_Business_Case__c.getRecordTypeInfosByName().get('EBC Initial Request').getRecordTypeID();
    ID ConceptrecType = Schema.SObjectType.Executive_Business_Case__c.getRecordTypeInfosByName().get('Concept Initial').getRecordTypeID();
    List<Executive_Business_Case__c> ebclst = [SELECT ID,File_Attached__c 
                                               FROM Executive_Business_Case__c 
                                               WHERE ID IN:updatedEBCsMap.keySet() 
                                               AND RecordTypeID=:EBCrecType 
                                               AND File_Attached__c='Not Attached' ];
    List<Executive_Business_Case__c> conceptlst = [SELECT ID,Is_Concept_Attached__c 
                                                   FROM Executive_Business_Case__c 
                                                   WHERE ID IN:updatedEBCsMap.keySet() 
                                                   AND RecordTypeID=:ConceptrecType 
                                                   AND Is_Concept_Attached__c='Not Attached' ];
    List<Executive_Business_Case__c> ebcMapValues = updatedEBCsMap.Values();
    for(Executive_Business_Case__c ebc : ebcMapValues){
        if(ebc.RecordTypeID==EBCrecType){

            system.debug('****'+ebclst);
        
            if(ebclst.size()==0){return;}
         
            else{
              system.debug('***In ELSE');
              Set<ID> newApprovalEBCs = new Set<ID>();         
              for(Executive_Business_Case__c e: ebclst){
                newApprovalEBCs.add(e.ID);
              } 
              
                         
              List<FeedItem> chatterFileList = [SELECT ID, ParentID,ContentType,Type FROM FeedItem WHERE ParentID IN :newApprovalEBCs];
              for(FeedItem chatterFile : chatterFileList){
                if(newApprovalEBCs.contains(chatterFile.ParentID)&&chatterFile.Type=='ContentPost') { newApprovalEBCs.remove(chatterFile.ParentID); }
              }
              for(ID ebcerror:newApprovalEBCs){
                system.debug('****'+oldEBCsMap.get(ebcerror).File_Attached__c);
                
                if(oldEBCsMap.get(ebcerror).File_Attached__c=='Not Attached' && updatedEBCsMap.get(ebcerror).File_Attached__c=='Attached' ){ 
                  updatedEBCsMap.get(ebcerror).addError('Please upload the EBC Request Template Part-II to the case before updating the \'EBC Attachment Status\' field to "Attached."');
                }   
                else if(oldEBCsMap.get(ebcerror).File_Attached__c=='Not Attached' && updatedEBCsMap.get(ebcerror).File_Attached__c=='Not Attached'){
                  system.debug('&&&&in Else if');
                  return;
                }       
              }
            } 
          }
          else if(ebc.RecordTypeID==ConceptrecType){
            
            system.debug('****'+conceptlst);
        
            if(conceptlst.size()==0){return;}
         
            else{
              system.debug('***In ELSE');
              Set<ID> newApprovalEBCs = new Set<ID>();         
              for(Executive_Business_Case__c e: conceptlst){
                newApprovalEBCs.add(e.ID);
              } 
              
                         
              List<FeedItem> chatterFileList = [SELECT ID, ParentID,ContentType,Type FROM FeedItem WHERE ParentID IN :newApprovalEBCs];
              for(FeedItem chatterFile : chatterFileList){
                if(newApprovalEBCs.contains(chatterFile.ParentID)&&chatterFile.Type=='ContentPost') { newApprovalEBCs.remove(chatterFile.ParentID); }
              }
              for(ID ebcerror:newApprovalEBCs){
                system.debug('****'+oldEBCsMap.get(ebcerror).Is_Concept_Attached__c);
                
                if(oldEBCsMap.get(ebcerror).Is_Concept_Attached__c=='Not Attached' && updatedEBCsMap.get(ebcerror).Is_Concept_Attached__c=='Attached' ){ 
                  updatedEBCsMap.get(ebcerror).addError('Please upload the EBC Request Template Part-I to the case before updating the \'Concept Attachment Status\' field to "Attached."');
                }   
                else if(oldEBCsMap.get(ebcerror).Is_Concept_Attached__c=='Not Attached' && updatedEBCsMap.get(ebcerror).Is_Concept_Attached__c=='Not Attached'){
                  system.debug('&&&&in Else if');
                  return;
                }       
              }
            }
          }
    }
  }
}