@isTest 
public  class EBC_PizzaTrackerControllerTest {
	static testMethod void testCheckForApprovalBeforeUpdate(){       
        List<Executive_Business_Case__c> ebc = EBC_TestDataFactory.createTestEBCRecords(1,'Concept Test Record2','Testing...', 'Attached', '2020', 'Concept Initial');    
        ApexPages.StandardController sc = new ApexPages.StandardController(ebc[0]);
        EBC_PizzaTrackerController con = new EBC_PizzaTrackerController(sc);
        String exVal =  EBC_PizzaTrackerController.TrackerUpdate(ebc[0].Id);
        system.assertEquals(exVal,'Concept-New-Pending');
    }              
}