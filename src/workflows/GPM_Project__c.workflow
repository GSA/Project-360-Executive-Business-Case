<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>P360_Project_PopulateActualEndDate</fullName>
        <description>The &apos;Actual End Date&apos; field will automatically populate once a project status has been set to Completed</description>
        <field>Actual_End_Date__c</field>
        <formula>TODAY()</formula>
        <name>P360-Project-PopulateActualEndDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PC_Hidden_Date_update</fullName>
        <field>Hidden_Status_change_date__c</field>
        <formula>today()</formula>
        <name>PC Hidden Date update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PC_Set_Estmated_End_Date</fullName>
        <description>Set Estimated End Date for a Project when the Actual Date is Selected</description>
        <field>Estimated_End_Date__c</field>
        <formula>Planned_End_Date__c + (Actual_Start_Date__c - Planned_Start_Date__c)</formula>
        <name>PC Set Estmated End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>P360-Project-ActualEndDate</fullName>
        <actions>
            <name>P360_Project_PopulateActualEndDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GPM_Project__c.Project_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>GPM_Project__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Corporate IT Services,Simple Project,Sprint</value>
        </criteriaItems>
        <description>When a Project Status is set to Completed, the Project Actual End Date will automatically populate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PC Calc Est End Date</fullName>
        <actions>
            <name>PC_Set_Estmated_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculate the Estimated End Date for a Project</description>
        <formula>ISCHANGED(Actual_Start_Date__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PC Status Description Date Update</fullName>
        <actions>
            <name>PC_Hidden_Date_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Captures date of last Status Description update on a hidden date field on Projects</description>
        <formula>OR(ISNEW(),ISCHANGED( Status_Description__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
