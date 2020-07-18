public with sharing class P360_HomePageController {
    public List<RecentlyViewed> Projectrecs{get;set;}
    public List<RecentlyViewed> Requestrecs{get;set;}
    public Boolean usergroup{get;set;}
        public string MyRequestsURL{get;set;}
        public string MyProjectsURL{get;set;}
    

    
    public P360_HomePageController() {
        
                Requestrecs = [SELECT ID,Name FROM RecentlyViewed WHERE Type ='P360_Request__c' ORDER BY LastViewedDate DESC Limit 5];
                Projectrecs = [SELECT ID,Name FROM RecentlyViewed WHERE Type ='GPM_Project__c' ORDER BY LastViewedDate DESC Limit 5];
                List<Profile> profiles = new List<Profile>();
                profiles = [SELECT Id, Name FROM Profile WHERE Name='GSA System Administrator'];
                Id pID = null;
                if(!profiles.isEmpty())
                    pID = profiles[0].Id;
                else               
                    pID = [SELECT Id, Name FROM Profile WHERE Name='System Administrator'].ID;                   
                ID grpID = [ SELECT ID FROM Group WHERE DeveloperName='P360_Triage' AND Type='Regular' ].ID;
            List<GroupMember> gm = [SELECT ID,UserOrGroupID FROM GroupMember WHERE  GroupID=:grpID];
                
                Set<ID> gmID = new Set<ID>();

                for(GroupMember g : gm){
                    gmID.add(g.UserOrGroupID);
                }

                if(gmID.contains(userinfo.getUserID()) || userinfo.getProfileID()==pID){

                    usergroup = true;
                }

                MyRequestUrl();
                MyProjectURL();

    }

        public void MyRequestUrl(){
                String RequestPrefix = P360_Request__c.SObjectType.getDescribe().getKeyPrefix();
                MyRequestsURL = '/'+RequestPrefix+'/o';
        }

        public void MyProjectURL(){
                String ProjectPrefix = GPM_Project__c.SObjectType.getDescribe().getKeyPrefix();
                MyProjectsURL = '/'+ProjectPrefix+'/o';
        }
}