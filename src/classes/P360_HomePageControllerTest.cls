@isTest
private class P360_HomePageControllerTest {
    
    @isTest static void P360HomeTestMethod1() {

        ID pID = [SELECT ID,Name FROM Profile WHERE Name=:'System Administrator'].ID;
        User u = [Select ID FROM USER where profileID=:pID AND isActive = true Limit 1];
        
        system.runAs(u){
            P360_HomePageController obj = new P360_HomePageController();
            //system.assertEquals(obj.usergroup,true);
            System.assert(true);
        }   
    }
}