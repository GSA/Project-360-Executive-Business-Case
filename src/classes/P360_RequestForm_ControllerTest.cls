@isTest
private class P360_RequestForm_ControllerTest {
  
  @isTest static void test_method_NewRequestype() {
    
        PageReference pageRef = Page.P360_Request_Form;
        Test.setCurrentPage(pageRef);
        
        P360_RequestForm_Controller obj = new P360_RequestForm_Controller();

        obj.request.RequestorName__c = 'Test User';
        obj.request.RequestorPhone__c = '(703) 603-8172';
        obj.request.RequestorEmail__c = 'test@gsa.gov';
        obj.request.RequestorSSO__c = 'Other';
        obj.request.Type__c = 'New';
        obj.request.Name = 'Test Title';
        obj.request.Description__c = 'Other';
        obj.request.ResultOfFederalMandate__c = 'Yes';
        obj.request.DescriptionOfMandate__c = 'Federal Mandate';
        obj.request.HowDoYouAccomplishThisTaskToday__c = 'Accomplist it manually';
        obj.request.DeptLeadershipSupportBudget__c= 'No';
        obj.request.CurrentCostInformation__c = 'Yes';
        obj.request.EstimatedCosts__c = 1000;
        obj.request.NumberOfUsersImpacted__c = '1-100';
        obj.request.TypeOfUsersImpacted__c = 'Internal GSA';
        obj.request.ImplementationBenefits__c = 'Federal mandate';
        
    	List<SelectOption> typeofuser = obj.TypeofUserOptions;
     	List<SelectOption> typeofbenefits = obj.RequestBenefitOptions;
     	List<String> Testtypeofusersselected = new List<String>{'Internal GSA','Citizen','Vendor'};
        List<String> Testbenefitsselected = new List<String>{'Cost Reduction','Reduce service calls/emails or service tickets','Increase revenue'};
        obj.TypeOfUserSelected = Testtypeofusersselected;
        obj.BenefitsSelected = Testbenefitsselected; 
        obj.request.RequestedSolutionCompletionDate__c = system.today();
        obj.Submit();

        String nextPage = obj.Submit().getUrl();
        system.debug('next'+nextPage);
        System.assertEquals('/apex/P360_RequestForm_Thankyou', nextPage);


  }
  
  @isTest static void test_method_EnhancementRequestype() {
    
    PageReference pageRef = Page.P360_Request_Form;
        Test.setCurrentPage(pageRef);
        
        P360_RequestForm_Controller obj = new P360_RequestForm_Controller();

        obj.request.RequestorName__c = 'Test User';
        obj.request.RequestorPhone__c = '(703) 603-8172';
        obj.request.RequestorEmail__c = 'test@gsa.gov';
        obj.request.RequestorSSO__c = 'Other';
        obj.request.Type__c = 'Enhancement';
        obj.request.Name = 'Test Enhancement';
        obj.request.EnhancementRequestCategory__c = 'HR Services';
        obj.request.EnhancementRequestCategoryOther__c = '';
        obj.request.ResultOfFederalMandate__c = 'No';
        obj.request.DescriptionOfMandate__c = '';
        obj.request.Description__c = 'Test';
        obj.request.HowDoYouAccomplishThisTaskToday__c = 'Manually';
        obj.request.DeptLeadershipSupportBudget__c = 'No';
        obj.request.CurrentCostInformation__c = 'No';
        obj.request.TypeOfUsersImpacted__c = 'Internal GSA';
        obj.request.ImplementationBenefits__c = 'Federal mandate';
        obj.request.RequestedEnhancementCompletionDate__c = system.today(); 
        obj.request.ManagementContactInfo__c = 'Test User';
        obj.request.NumberOfUsersImpacted__c = '1-100';
        List<SelectOption> typeofuser = obj.TypeofUserOptions;
        List<SelectOption> typeofbenefits = obj.RequestBenefitOptions;
        List<String> Testtypeofusersselected = new List<String>{'Internal GSA','Citizen','Vendor'};
        List<String> Testbenefitsselected = new List<String>{'Cost Reduction','Reduce service calls/emails or service tickets','Increase revenue'};
        obj.TypeOfUserSelected = Testtypeofusersselected;
        obj.BenefitsSelected = Testbenefitsselected; 
        obj.request.RequestedEnhancementCompletionDate__c = system.today();
     	obj.Submit();
       
        String nextPage = obj.Submit().getUrl();
        system.debug('next'+nextPage);
        System.assertEquals('/apex/P360_RequestForm_Thankyou', nextPage);
  }  
}