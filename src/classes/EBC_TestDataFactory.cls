@isTest
public class EBC_TestDataFactory {
	

	public static List<Executive_Business_Case__c> createTestEBCRecords(integer numebc, String Name,String Abs,String conceptattachment, String FY, String RecType){



		 
        List<Executive_Business_Case__c> ebcList = new List<Executive_Business_Case__c>();
        RecordType rtype = [SELECT Name, Id FROM RecordType 
                        	WHERE sObjectType='Executive_Business_Case__c' 
                        	AND isActive=true AND Name=:RecType];

        Id CurrentuserId = Userinfo.getUserId();

        Id UserId= [SELECT Id FROM User WHERE IsActive = true AND Id!=:CurrentuserId LIMIT 1].Id;

        for(Integer i=0;i<numebc;i++){

        Executive_Business_Case__c ebc = new Executive_Business_Case__c();
        ebc.Name = Name;
        ebc.Project_Start_Date__c = System.today();
        ebc.Portfolio__c = 'FAS';
        ebc.Request_Type__c = 'New Investment';
        ebc.Requested_Amount_1st_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_2nd_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_3rd_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_4th_Fiscal_Year__c = 0.00;
        ebc.Requested_Amount_5th_Fiscal_Year__c = 0.00;
        ebc.RecordTypeId = rtype.Id;
        ebc.File_Attached__c = 'Not Attached';
        ebc.Is_Concept_Attached__c = conceptattachment;
        ebc.Service_or_Staff_Office_SSO__c = 'A - Office of the Administrator';
        ebc.Executive_Sponsor_Delegate__c = UserId;
        ebc.Abstract__c = Abs;
        ebc.Fiscal_Year__c = FY;
        ebc.Project_End_Date__c = System.today();
        ebc.Program_Business_Line__c = 'GSS - FSSI BMO';
        ebcList.add(ebc);  
        }  
        insert ebcList;
    	return ebcList; 
    }

    
}