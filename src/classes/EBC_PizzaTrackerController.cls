public with sharing class EBC_PizzaTrackerController {

    public EBC_PizzaTrackerController(ApexPages.StandardController controller) {}
   
    @AuraEnabled    
    public static string TrackerUpdate(Id id){
       system.debug('id'+id);
       list<Executive_Business_Case__c> exlist= new list<Executive_Business_Case__c>();
       Executive_Business_Case__c exValue=[select id,Tracker__c from Executive_Business_Case__c where id=:id];
       system.debug('exValue.imageTracker__c'+exValue.Tracker__c); 
       return exValue.Tracker__c; 
    } 
}