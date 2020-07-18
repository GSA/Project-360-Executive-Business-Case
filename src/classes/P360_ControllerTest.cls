@isTest
public class P360_ControllerTest {

    static testMethod void testActionMap() {
        P360_Controller con = new P360_Controller();
        Map<String,String> m = P360_Controller.ProjActionMap;
        for (String s : P360_Controller.ProjIDList) {
            System.assert(m.get(s) != null, s + ' was not inserted.');
        }
    }


    static testMethod void testGetActionCount() {
        P360_Controller con = new P360_Controller();
        String TestactionMapJSON = con.actionMapJSON;
        String TestProjIDListJSON = con.ProjIDListJSON;
        String TestRequestactionMapJSON = con.RequestactionMapJSON;
        String TestRequestIDListJSON = con.RequestIDListJSON;
        Integer oneLine = P360_Controller.getActionCount('asdf');
        Integer nullInput = P360_Controller.getActionCount(null);
        Integer threeLines = P360_Controller.getActionCount('asdf<br>asdf<br>asdf');

        System.assert(oneLine == 1, 'Given string with no breaks, did not parse to 1 row.');
        System.assert(nullInput == 0, 'Given null string, did not parse to 0 rows.');
        System.assert(threeLines == 3, 'Given string with two breaks, did not parse to 2 rows.');
    }


    @testSetup
    static void setup() {
         Id strRecordTypeId = [Select Id From RecordType Where SobjectType = 'GPM_Project__c' and DeveloperName = 'P360_CorporateITServices'].Id;

         List<GPM_Project__c> proj = new List<GPM_Project__c>{new GPM_Project__c(Name='I1', Project_Status__c=null, Key_Project__c=True,RecordTypeId=strRecordTypeId,UpcomingActionItems__c='Hello'),
                                                            new GPM_Project__c(Name='I2', Project_Status__c=null,  Key_Project__c=True,RecordTypeId=strRecordTypeId),
                                                            new GPM_Project__c(Name='I3', Project_Status__c=null,  Key_Project__c=True,RecordTypeId=strRecordTypeId),
                                                            new GPM_Project__c(Name='nonKeyProject'),
                                                            new GPM_Project__c(Name='completedProject',Actual_End_Date__c= System.today()+100, Project_Status__c='Completed',RecordTypeId=strRecordTypeId)};
        insert proj;
        System.assert(proj.size()==5,'5 new projects created');
        system.debug('**+id'+proj);
        
         List<P360_Request__c> Request = new List<P360_Request__c>{new P360_Request__c(Name='RequestProj',IsConverted__c= False, Status__c='New Request')};
        //insert Request;
        System.assert(Request.size()==1,'1 new projects created');
    }

     

}