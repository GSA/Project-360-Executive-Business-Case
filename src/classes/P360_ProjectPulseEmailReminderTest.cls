@isTest
private class P360_ProjectPulseEmailReminderTest {

	public  static String CRON_EXP = '0 0 0 15 3 ? 2022';

	@testSetup public static void dataPrep() {

	  Id projRecordTypeId = Schema.SObjectType.GPM_Project__c.getRecordTypeInfosByName().get('Corporate IT Services').getRecordTypeId();
	  Id contactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Individual').getRecordTypeId();
      Contact con = new Contact();
      con.LastName = 'TestLAst';
      con.Email = 'test.name@gsa.gov';
      con.RecordTypeId = contactRecordTypeId;
      insert con;

      GPM_Project__c testproj = new GPM_Project__c();
      testproj.Name = 'Project 1';
      testproj.RecordTypeId = projRecordTypeId;
      testproj.ConvertedFromRequest__c = True;
      testproj.Project_Manager__c = con.Id;
      Insert testproj;
      System.assert(testproj.Name=='Project 1','1 new project created');
   }


	
	@isTest 
	Public static void schedulerTest() {
		System.Test.startTest();

      // Schedule the test job
      String jobId = System.schedule('ScheduleApexClassTest',
                        CRON_EXP,
                        new P360_ProjectPulseEmailReminder());

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(CRON_EXP,
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);

      // Verify the next time the job will run
      System.assertEquals('2022-03-15 00:00:00',
         String.valueOf(ct.NextFireTime));

      System.Test.stopTest();
	}
	
}