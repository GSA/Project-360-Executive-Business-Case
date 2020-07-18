@isTest
public class EBC_ExecutiveBusinessCaseTriggerTest {
    
    @testSetup static void testmethodebc () {
      
        List<Executive_Business_Case__c> ebc = EBC_TestDataFactory.createTestEBCRecords(1,'EBC Test Record','Testing...','Not Attached','2020', 'EBC Initial Request');   
        List<Executive_Business_Case__c> ebc1 = EBC_TestDataFactory.createTestEBCRecords(1,'Concept Test Record','Testing...','Not Attached', '2020', 'Concept Initial');
        List<Executive_Business_Case__c> ebc2 = EBC_TestDataFactory.createTestEBCRecords(1,'Concept Test Record2','Testing...','Not Attached', '2020', 'Concept Initial');
        List<Executive_Business_Case__c> ebc3 = EBC_TestDataFactory.createTestEBCRecords(1,'Concept Test Record2','Testing...', 'Attached', '2020', 'Concept Initial');
        List<Executive_Business_Case__c> ebclst = [select id from Executive_Business_Case__c];
        system.assertEquals(4, ebclst.size());
    }
     
        @isTest static void  testforrecordupdate() {
            
           List<Executive_Business_Case__c> ebc = [SELECT Id,Abstract__c FROM Executive_Business_Case__c ];
              
            ebc[0].Abstract__c ='testing';
            ebc[1].Abstract__c ='testing';
            update ebc;     
            system.assertEquals(ebc[0].Abstract__c,'testing');    
        }


        @isTest static void  testforattachment() {

            List<Executive_Business_Case__c> ebc1 = [SELECT Id, File_Attached__c,Is_Concept_Attached__c FROM Executive_Business_Case__c ];
                    
            ebc1[0].File_Attached__c ='Attached';
            ebc1[1].Is_Concept_Attached__c ='Attached';

            try{update ebc1;}

            catch(DmlException e){
                    System.debug('The following exception has occured: '+ e.getMessage());                 
                    System.assert(e.getMessage().indexOf('Please upload') > 0);
            }
        }

        @isTest static void  testnotattachedebc() {

            List<Executive_Business_Case__c> ebc2 = [SELECT Id, File_Attached__c, Abstract__c FROM Executive_Business_Case__c Where Name='EBC Test Record' ];
                    
            ebc2[0].File_Attached__c ='Not Attached';   
            ebc2[0].Abstract__c='new test case';
            update ebc2;

            system.assertEquals(ebc2[0].File_Attached__c,'Not Attached');
            
        }

        @isTest static void  testnotattachedconcept() {

            List<Executive_Business_Case__c> ebc3 = [SELECT Id, Is_Concept_Attached__c, Abstract__c FROM Executive_Business_Case__c Where Name='Concept Test Record' ];        
            
            ebc3[0].Is_Concept_Attached__c ='Not Attached';   
            ebc3[0].Abstract__c='new test case';
            update ebc3;
            system.assertEquals(ebc3[0].Is_Concept_Attached__c,'Not Attached');

                
        }        

}