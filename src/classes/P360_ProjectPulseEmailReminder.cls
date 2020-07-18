/*-------------------------------------------------------------------------------------------------*
Scheduler class for Sending email notifications to Project Managers (custom field - lookup Contact)
*--------------------------------------------------------------------------------------------------*
Author           | Date        | Version | Description
*--------------------------------------------------------------------------------------------------*
Mayank Singla      01/18/2017    1.0       Scheduler class created

*--------------------------------------------------------------------------------------------------*

*--------------------------------------------------------------------------------------------------*/

global class P360_ProjectPulseEmailReminder implements Schedulable {

    global void execute(SchedulableContext SC) {

        sendmail();

    }

    public void sendmail()
    {
        List<GPM_Project__c> projectList = [
                SELECT Id, Name, OwnerId, Project_Manager__c
                FROM GPM_Project__c
                WHERE Id != NULL 
            		AND Project_Manager__c != NULL 
            		AND ConvertedFromRequest__c = TRUE 
            		AND RecordTypeId IN (select Id 
                                     FROM RecordType 
                                     WHERE SobjectType = 'GPM_Project__c'
                                        	AND DeveloperName = 'P360_CorporateITServices') 
        		];

        Set<Id> projMngrId = new Set<Id>();

        for(GPM_Project__c proj : projectList){
            projMngrId.add(proj.Project_Manager__c);
        }

        Map<String, String> mapContactEmail = new Map<String, String>();
        List<Contact> contactList = [
                SELECT Id, Email
                FROM Contact
                WHERE Id IN :projMngrId
        ];

        for(Contact c : contactList){
            mapContactEmail.put(c.Id, c.Email);
        }

        Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
        List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();

        for(GPM_Project__c  proj : projectList){
            m = new Messaging.SingleEmailMessage();
            String name = proj.Name;
            Id projId = proj.Id;
            String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() +'/'+ proj.Id;

            OrgWideEmailAddress[] owea = [
                    SELECT Id
                    FROM OrgWideEmailAddress
                    WHERE DisplayName like '%Corporate IT%'
            ];

            if ( owea.size() > 0 ) {
                m.setOrgWideEmailAddressId(owea.get(0).Id);
            }

            m.setSubject('Bi-Weekly Status Update');
            String body ='<html lang="en"><body>'+
                '<br><br>'+
                'Hello,'+
                '<br><br>'+
                'As a friendly reminder, please provide your bi-weekly status for the following Project: '+
                '<a href=' + '"' + fullRecordURL + '"' + '>' + name + '</a>' + '. ' +
                'All Corporate IT Services projects are reviewed every 2 weeks and require an updated Pulse. '+
                'If you have any questions/concerns, please contact: '+
                '<a href='+'"'+'mailto:corporateitservicesrequestsupport@gsa.gov'+'"'+'>'+'Corporate IT Services Request Team.'+'<a>'+
                '<br><br>'+
                'When creating your Pulse, please make sure you enter each item on a new line without numbers or dashes.' + '' +
                ' For example:'+
                '<br><br>'+
                '<b>'+'Accomplishments:'+'</b>'+
                '<br>'+
                'This is Accomplishment 1'+
                '<br>'+
                'This is Accomplishment 2'+
                '<br><br>'+
                'Thank you,'+'<br>'+
                'Corporate IT Services Request Team'+ '<br>'+
                'Email: '+'<a href=mailto:corporateitservicesrequestsupport@gsa.gov>'+'CorporateITServicesRequestSupport@gsa.gov'+ '<a>'+
                '</body></html>';
            m.setHTMLBody(body);
            m.setToAddresses(new String[]{string.valueof(mapContactEmail.get(proj.Project_Manager__c))});
            allMails.add(m);
        }
        Messaging.sendEmail(allMails);
    }
}