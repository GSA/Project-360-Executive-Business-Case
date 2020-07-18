public with sharing class P360_RequestForm_Controller {
    Id newRecordTypeId = Schema.SObjectType.P360_Request__c.getRecordTypeInfosByName().get('New Application').getRecordTypeId();
    Id enhancementrecordTypeId = Schema.SObjectType.P360_Request__c.getRecordTypeInfosByName().get('Enhancement').getRecordTypeId();
    String[] values{get;set;}
    Public string MyRequestsURL{get;set;}

    public P360_RequestForm_Controller(){
        values = new string[0];
        RequestsURL();
    }

    public P360_Request__c request {
        get {
            if (request == null)
                request = new P360_Request__c();
            return request;
        }
        set; }


 //get the multi-select pick list values
    public List<SelectOption> TypeofUserOptions {
     get {
       List<SelectOption> options = new List<SelectOption>();
       for( Schema.PicklistEntry f : P360_Request__c.TypeOfUsersImpacted__c.getDescribe().getPicklistValues()) {
         options.add(new SelectOption(f.getValue(), f.getLabel()));
        } 
       return options;
     }  
     set;
    }


    public List<SelectOption> RequestBenefitOptions {
     get {
       List<SelectOption> options = new List<SelectOption>();
       for( Schema.PicklistEntry f : P360_Request__c.ImplementationBenefits__c.getDescribe().getPicklistValues()) {
         options.add(new SelectOption(f.getValue(), f.getLabel()));
        } 
       return options;
     }  
     set;
    }
    
    public String[] TypeOfUserSelected { 
        get {
            String[] selected = new List<String>();
            return selected;
        } public set {
            String selectedCheckBox = '';
            for(String s : value) {
                system.debug('Value1'+s);
                if (selectedCheckBox == '') 
                    selectedCheckBox += s;
                else selectedCheckBox += ';' + s;
            }
            request.TypeOfUsersImpacted__c = selectedCheckBox;
        }
    }
    
     public String[] BenefitsSelected { 
        get {
            String[] selected = new List<String>();
            return selected;
        } public set {
            String selectedCheckBox = '';
            for(String s : value) {
                if (selectedCheckBox == '') 
                    selectedCheckBox += s;
                else selectedCheckBox += ';' + s;
            }
            request.ImplementationBenefits__c = selectedCheckBox;
        }
    }

    public void RequestsURL(){
        String ProjectPrefix = P360_Request__c.SObjectType.getDescribe().getKeyPrefix();
        MyRequestsURL = '/'+ProjectPrefix+'/o';
    }
    //get and set the multi-select pick list as checkboxes
    public PageReference Submit(){
        system.debug('In Submit button');
        P360_Request__c newRequest = new P360_Request__c();
        newRequest.RequestorName__c = request.RequestorName__c;
        newRequest.RequestorPhone__c = request.RequestorPhone__c;
        newRequest.RequestorEmail__c = request.RequestorEmail__c;
        newRequest.RequestorSSO__c = request.RequestorSSO__c;
        newRequest.Type__c = request.Type__c;
        newRequest.InputChannel__c = 'Web';
        newRequest.Type__c = request.Type__c;
        newRequest.Office_Portfolio__c = request.Office_Portfolio__c;
        newRequest.Division__c = request.Division__c;
        newRequest.Region__c = request.Region__c;
        newRequest.TypeOfUsersImpacted__c = request.TypeOfUsersImpacted__c;
        if(request.Type__c=='New'){
             system.debug('In New');
            newRequest.RecordTypeId = newRecordTypeId; 
            newRequest.Name = request.Name;
            newRequest.Description__c = request.Description__c;
            newRequest.ResultOfFederalMandate__c = request.ResultOfFederalMandate__c;
            newRequest.DescriptionOfMandate__c = request.DescriptionOfMandate__c;
            newRequest.HowDoYouAccomplishThisTaskToday__c = request.HowDoYouAccomplishThisTaskToday__c;
            newRequest.DeptLeadershipSupportBudget__c= request.DeptLeadershipSupportBudget__c;
            newRequest.CurrentCostInformation__c = request.CurrentCostInformation__c;
            newRequest.EstimatedCosts__c = request.EstimatedCosts__c;
            newRequest.NumberOfUsersImpacted__c = request.NumberOfUsersImpacted__c;
            newRequest.TypeOfUsersImpacted__c = request.TypeOfUsersImpacted__c;
            newRequest.ImplementationBenefits__c = request.ImplementationBenefits__c;
            newRequest.RequestedSolutionCompletionDate__c = request.RequestedSolutionCompletionDate__c;  
            newRequest.TypeOfUsersImpactedOther__c = request.TypeOfUsersImpactedOther__c;
            newRequest.ImplementationBenefitsOther__c = request.ImplementationBenefitsOther__c;
            newRequest.ManagementContactInfo__c = request.ManagementContactInfo__c;
        }
        else if(request.Type__c=='Enhancement'){

             newRequest.RecordTypeId = enhancementrecordTypeId;
             newRequest.Name = request.Name;
             newRequest.EnhancementRequestCategory__c = request.EnhancementRequestCategory__c;
             newRequest.EnhancementRequestCategoryOther__c = request.EnhancementRequestCategoryOther__c;
             newRequest.ResultOfFederalMandate__c = request.ResultOfFederalMandate__c;
             newRequest.DescriptionOfMandate__c = request.DescriptionOfMandate__c;
             newRequest.Description__c = request.Description__c;
             newRequest.HowDoYouAccomplishThisTaskToday__c = request.HowDoYouAccomplishThisTaskToday__c;
             newRequest.DeptLeadershipSupportBudget__c = request.DeptLeadershipSupportBudget__c;
             newRequest.CurrentCostInformation__c = request.CurrentCostInformation__c;
             newRequest.ImplementationBenefits__c = request.ImplementationBenefits__c;
             newRequest.RequestedEnhancementCompletionDate__c = request.RequestedEnhancementCompletionDate__c;
             newRequest.ManagementContactInfo__c = request.ManagementContactInfo__c;
             newRequest.NumberOfUsersImpacted__c = request.NumberOfUsersImpacted__c;
             newRequest.TypeOfUsersImpactedOther__c=request.TypeOfUsersImpactedOther__c;
        }

        try{          
                 insert newRequest;     
           
        }

        catch(DMLException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error inserting a new Project.'+e));
        }
         
        PageReference pg = new PageReference('/apex/P360_RequestForm_Thankyou');
        pg.getParameters().put('RequestId', newRequest.Id);
        return pg;
    }
}