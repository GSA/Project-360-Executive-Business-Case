public with sharing class  P360_Controller { 
   
    public List<GPM_Project__c> ProjLst{get;set;}
    public List<GPM_Project__c> keyProj{get;set;}
    public List<GPM_Project__c> compltdProj{get;set;}
    public List<P360_Request__c> RqstLst{get;set;}
    public static Map<String, String> ProjActionMap{get; set;}
    public static Map<String, String> RequestActionMap{get; set;}
    public static List<String> ProjIDList{get; set;}
     public static List<String> RequestIDList{get; set;}
    public String actionMapJSON {get{return JSON.serialize(ProjActionMap);}}
    public String ProjIDListJSON {get{return JSON.serialize(ProjIDList);}}
    public String RequestactionMapJSON {get{return JSON.serialize(RequestActionMap);}}
    public String RequestIDListJSON {get{return JSON.serialize(RequestIDList);}}

   
    Id strRecordTypeId = [Select Id From RecordType Where SobjectType = 'GPM_Project__c' and DeveloperName = 'P360_CorporateITServices'].Id;
    public P360_Controller(){
      
        ProjActionMap = new Map<String, String>();
        ProjIDList = new List<String>();
        RequestActionMap = new Map<String, String>();
        RequestIDList = new List<String>();
       

        ProjLst = [
            SELECT
                ID
                ,Name
                ,Status__c 
                ,Project_Status__c  
                ,UpcomingActionItems__c
                ,Issues__c
                ,StatusUpdateOrComments__c
                ,Accomplishments__c
                ,OwnerId
                ,Owner.Name
                ,Actual_End_Date__c                
            FROM GPM_Project__c
            WHERE Project_Status__c!='Completed' 
            AND RecordTypeID=:strRecordTypeId                  
           
        ];  

        compltdProj = [
            SELECT
                ID
                ,Name
                ,Status__c 
                ,Project_Status__c
                ,UpcomingActionItems__c
                ,Issues__c
                ,StatusUpdateOrComments__c             
                ,Accomplishments__c
                ,OwnerId
                ,Owner.Name
                ,Actual_End_Date__c                
            FROM GPM_Project__c
            WHERE Project_Status__c='Completed'
            AND Days_Since_Closed__c < 365
            AND RecordTypeID=:strRecordTypeId
            
        ];

        keyProj = [
            SELECT
                ID
                ,Name
                ,Status__c 
                ,Project_Status__c
                ,UpcomingActionItems__c
                ,Issues__c
                ,StatusUpdateOrComments__c                 
                ,Accomplishments__c
                ,Key_Project__c                
                ,OwnerId
                ,Owner.Name
                ,Actual_End_Date__c            
            FROM GPM_Project__c
            Where Key_Project__c = True
            AND RecordTypeID=:strRecordTypeId
            ORDER BY LastModifiedDate desc
            LIMIT 3
        ];

        RqstLst = [
            SELECT
                ID
                ,Name
                ,Status__c               
                ,OwnerId                
                ,Owner.Name 
                ,IsConverted__c
                ,LevelOfEffort__c
                ,RequestType__c  
                ,InputChannel__c                 
                ,RecordTypeID 
                ,StatusUpdateOrComments__c 
                ,UpcomingActionItems__c            
                ,Accomplishments__c
                ,Type__c               
                ,Costs__c
                ,EstimatedCosts__c                       
            FROM P360_Request__c
            Where IsConverted__c= False
            AND   Status__c != 'Cancelled'                           
            ORDER BY LastModifiedDate desc
        ];

        setActionCountMap(ProjLst);
        setRequestActionCountMap(RqstLst);
    }

    public static void setActionCountMap(List<GPM_Project__c> proj) {
        for (GPM_Project__c i : proj) {
            ProjActionMap.put(i.id, String.valueOf(getActionCount(i.UpcomingActionItems__c)));
            ProjIDList.add(i.id);
        }
    }

    public static void setRequestActionCountMap(List<P360_Request__c> Req) {
        for (P360_Request__c j : Req) {
            RequestActionMap.put(j.id, String.valueOf(getActionCount(j.UpcomingActionItems__c)));
            RequestIDList.add(j.id);
        }
    }

    public static Integer getActionCount(String txt) {
    return (txt == null || txt.length() == 0) ? 0 : (txt.countMatches('<br>') + 1);
    }


}