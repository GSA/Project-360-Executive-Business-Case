<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>P360_Request_ConvertedToProject</fullName>
        <description>P360-Request-ConvertedToProject</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>P360/P360_YourRequestConverted</template>
    </alerts>
    <alerts>
        <fullName>P360_Request_NewSubmitted</fullName>
        <description>P360-Request-NewSubmitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>packagesf@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>P360/P360_NewRequestSubmitted</template>
    </alerts>
    <alerts>
        <fullName>P360_Request_StatusUpdated</fullName>
        <description>P360-Request-StatusUpdated</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>P360/P360_YourRequestStatusUpdated</template>
    </alerts>
    <alerts>
        <fullName>P360_Request_YourRequestSubmitted</fullName>
        <description>P360-Request-YourRequestSubmitted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>P360/P360_YourRequestSubmitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>P360_Request_Converted_True</fullName>
        <description>P360 - Field Update for Converted checkbox field to &apos;True&apos;</description>
        <field>IsConverted__c</field>
        <literalValue>1</literalValue>
        <name>P360-Request-Converted-True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P360_Request_OwnerToTriage</fullName>
        <description>P360 - Field Update of Owner to Triage queue</description>
        <field>OwnerId</field>
        <lookupValue>packagesf@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>P360-Request-OwnerToTriage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P360_Request_Status_Approved</fullName>
        <description>P360 - Field Update for Status field to &apos;Approved&apos;</description>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>P360-Request-Status-Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P360_Request_Status_Cancelled</fullName>
        <description>P360 - Field Update for Status picklist field to Cancelled</description>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>P360-Request-Status-Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P360_Request_Status_NewRequest</fullName>
        <description>P360 - Field Update for Status field to &apos;New Request&apos;</description>
        <field>Status__c</field>
        <literalValue>New Request</literalValue>
        <name>P360-Request-Status-NewRequest</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>P360-Request-BRGApprovalReceived-No</fullName>
        <actions>
            <name>P360_Request_Status_Cancelled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>P360_Request__c.BRGApproved__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>P360 - If BRG Approved equals &apos;No,&apos; the Status is automatically updated to &apos;Cancelled&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P360-Request-BRGApprovalReceived-Yes</fullName>
        <actions>
            <name>P360_Request_Status_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>P360_Request__c.BRGApproved__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>P360 - If BRG Approved equals &apos;Yes,&apos; the Status is automatically updated to &apos;Approved&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P360-Request-Converted-True</fullName>
        <actions>
            <name>P360_Request_Converted_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>P360_Request__c.NewOrExistingProject__c</field>
            <operation>equals</operation>
            <value>Add to Existing Project</value>
        </criteriaItems>
        <criteriaItems>
            <field>P360_Request__c.IsConverted__c</field>
            <operation>notEqual</operation>
            <value>False</value>
        </criteriaItems>
        <description>P360 - If Project field was manually updated to an existing project, update the converted checkbox to True</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>P360-Request-CreatedFromWeb</fullName>
        <actions>
            <name>P360_Request_NewSubmitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>P360_Request_YourRequestSubmitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>P360_Request_OwnerToTriage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>P360_Request_Status_NewRequest</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>P360_Request__c.InputChannel__c</field>
            <operation>equals</operation>
            <value>Web</value>
        </criteriaItems>
        <description>P360 - Assign the request to the Triage queue when it comes into the application through web form</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>P360-Request-StatusUpdated</fullName>
        <actions>
            <name>P360_Request_StatusUpdated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>P360 - Send an email alert to the requestor when request&apos;s status is updated</description>
        <formula>AND ( ISPICKVAL(InputChannel__c , &apos;Web&apos;),       ISCHANGED( Status__c ),        OR ( 	       ISPICKVAL(Status__c , &apos;Scoping&apos;),  		   ISPICKVAL(Status__c , &apos;Analysis&apos;), 		   ISPICKVAL(Status__c , &apos;Solution/LOE Complete&apos;), 		   ISPICKVAL(Status__c , &apos;Awaiting BRG Approval&apos;), 		   ISPICKVAL(Status__c , &apos;Cancelled&apos;) 		 ) 	)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
