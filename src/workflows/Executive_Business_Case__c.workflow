<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EBC_Email_to_requester_when_Type_of_Funding_Allocated_is_updated</fullName>
        <description>EBC - Email to requester when Type of Funding Allocated is updated</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Executive_Business_Case_Templates/EBC_Funding_Approval_Type</template>
    </alerts>
    <fieldUpdates>
        <fullName>EBC_imageTracker_to_10</fullName>
        <field>imageTracker__c</field>
        <formula>10</formula>
        <name>EBC imageTracker to 10</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imageTracker_to_11</fullName>
        <field>imageTracker__c</field>
        <formula>11</formula>
        <name>EBC imageTracker to 11</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imageTracker_to_13</fullName>
        <field>imageTracker__c</field>
        <formula>13</formula>
        <name>EBC imageTracker to 13</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imageTracker_to_9</fullName>
        <field>imageTracker__c</field>
        <formula>9</formula>
        <name>EBC imageTracker to 9</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imagelink_to_Funding_App_Not_Funde</fullName>
        <field>imageLink__c</field>
        <formula>&quot;015350000008uGE&quot;</formula>
        <name>EBC imagelink to Funding App - Not Funde</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imagelink_to_Funding_Approved_Full</fullName>
        <field>imageLink__c</field>
        <formula>&quot;015350000008uFz&quot;</formula>
        <name>EBC imagelink to Funding Approved - Full</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EBC_imagelink_to_Funding_Approved_Part</fullName>
        <field>imageLink__c</field>
        <formula>&quot;015350000008uG9&quot;</formula>
        <name>EBC imagelink to Funding Approved - Part</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EBC Funding Approval updates to EBC requester</fullName>
        <actions>
            <name>EBC_Email_to_requester_when_Type_of_Funding_Allocated_is_updated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>An email will be sent to the EBC requester every time the Type of Funding Allocated on their EBC request is updated with a new value</description>
        <formula>IF(PRIORVALUE(Type_of_Funding_Allocated__c) !=NULL,      ISCHANGED(Type_of_Funding_Allocated__c), FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>EBC image to Fully Funded</fullName>
        <actions>
            <name>EBC_imageTracker_to_9</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EBC_imagelink_to_Funding_Approved_Full</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Executive_Business_Case__c.Stage__c</field>
            <operation>equals</operation>
            <value>Funding Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Type_of_Funding_Allocated__c</field>
            <operation>equals</operation>
            <value>Fully Funded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EBC image to Funding Approved Decision Pending</fullName>
        <actions>
            <name>EBC_imageTracker_to_13</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Executive_Business_Case__c.Stage__c</field>
            <operation>equals</operation>
            <value>Funding Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Type_of_Funding_Allocated__c</field>
            <operation>notEqual</operation>
            <value>Fully Funded,Partially Funded,Not Funded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EBC image to Not Funded</fullName>
        <actions>
            <name>EBC_imageTracker_to_11</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EBC_imagelink_to_Funding_App_Not_Funde</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Executive_Business_Case__c.Stage__c</field>
            <operation>equals</operation>
            <value>Funding Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Type_of_Funding_Allocated__c</field>
            <operation>equals</operation>
            <value>Not Funded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EBC image to Partially Funded</fullName>
        <actions>
            <name>EBC_imageTracker_to_10</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EBC_imagelink_to_Funding_Approved_Part</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Executive_Business_Case__c.Stage__c</field>
            <operation>equals</operation>
            <value>Funding Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Type_of_Funding_Allocated__c</field>
            <operation>equals</operation>
            <value>Partially Funded</value>
        </criteriaItems>
        <criteriaItems>
            <field>Executive_Business_Case__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
