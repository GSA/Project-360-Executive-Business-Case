({
	myAction : function(component, event, helper) {
        //Geting the present URL
		var recid= component.get("v.recordId");
        console.log('The record is ----->--------->'+recid);
        var action= component.get("c.TrackerUpdate");
        
        action.setParams({
                        
                         id: recid
                        
                        });
        
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
              var resp= response.getReturnValue();
              if(resp== "Concept-New-Pending" || resp=="Concept-New-Recalled"){
                component.set("v.PerValue",0);
                component.set("v.lival1","PENDING");
                component.set("v.lival2",""); 
                component.set("v.lival3",""); 
                component.set("v.lival4",""); 
				component.set("v.lisubval1","...");
                component.set("v.lisubval2","");
                component.set("v.lisubval3","");
                component.set("v.lisubval4","");
                component.set("v.lisubvalClassone","stageonepending");
                component.set("v.phaseclassone","pendingphase");              
                var el = document.getElementById('li1');
                el.classList.add('slds-is-active'); 
                var el = document.getElementById('ConceptRequest');
                el.style.backgroundColor = '#36B7DA';
                var el = document.getElementById('li2');
                el.classList.remove('slds-is-active');
                var el = document.getElementById('Executive');
                el.style.removeProperty('background-color');
                var el = document.getElementById('li3');
                el.classList.remove('slds-is-active');
                var el = document.getElementById('GSAIT');
				el.style.removeProperty('background-color');
                var el = document.getElementById('li4');
                el.classList.remove('slds-is-active');
                var el = document.getElementById('GovernanceReview');
				el.style.removeProperty('background-color');
              }
              else if(resp== "Concept-Executive Sponsor Review-Pending" || resp== "Concept-Executive Sponsor Review-Recalled"){
                component.set("v.PerValue",33.00); 
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","PENDING");
                component.set("v.lival3",""); 
                component.set("v.lival4",""); 
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","...");
                component.set("v.lisubval3","");
                component.set("v.lisubval4","");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","pending"); 
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","pendingphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";               
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active");
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#36B7DA";
                var el = document.getElementById("li3");
                el.classList.remove("slds-is-active");
                var el = document.getElementById("GSAIT");
                el.style.removeProperty("background-color");
                var el = document.getElementById("li4");
                el.classList.remove("slds-is-active");
                var el = document.getElementById("GovernanceReview");
                el.style.removeProperty("background-color");
              }
              else if(resp== "Concept-Executive Sponsor Review-Denied"){
                component.set("v.PerValue",33.00);  
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","DENIED");
                component.set("v.lival3",""); 
                component.set("v.lival4",""); 
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","&#10006");
                component.set("v.lisubval3","");
                component.set("v.lisubval4","");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","denied");
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","deniedphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active");
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#FC0202";
                var el = document.getElementById("li3");
                el.classList.remove("slds-is-active");
                var el = document.getElementById("GSAIT");
				el.style.removeProperty("background-color");
                var el = document.getElementById("li4");
                el.classList.remove("slds-is-active");
              }
               else if(resp== "Concept-Internal Review-Pending"||resp=="Concept-Internal Review-Recalled"){
                component.set("v.PerValue",66.00); 
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","APPROVED"); 
                component.set("v.lival3","PENDING");
                component.set("v.lival4",""); 
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","&#10004");
                component.set("v.lisubval3","...");
                component.set("v.lisubval4","");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","approved"); 
                component.set("v.lisubvalClassthree","pending"); 
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","approvedphase");
                component.set("v.phaseclassthree","pendingphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li3");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GSAIT");
                el.style.backgroundColor = "#36B7DA";
                var el = document.getElementById("li4");
                el.classList.remove("slds-is-active");
                var el = document.getElementById("GovernanceReview");
				el.style.removeProperty("background-color");
              }
               else if(resp== 'Concept-Internal Review-Denied'){
                component.set("v.PerValue",66.00); 
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","APPROVED"); 
                component.set("v.lival3","DENIED");   
                component.set("v.lival4",""); 
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","&#10004");
                component.set("v.lisubval3","&#10006");
                component.set("v.lisubval4","");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","approved"); 
                component.set("v.lisubvalClassthree","denied");
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","approvedphase");
                component.set("v.phaseclassthree","deniedphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li3");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GSAIT");
                el.style.backgroundColor = "#FC0202";                 
                var el = document.getElementById("li4");
                el.classList.remove("slds-is-active");
                var el = document.getElementById("GovernanceReview");
				el.style.removeProperty("background-color");
              }
               else if(resp== 'Concept-Governance Review-Pending'||resp=='Concept-Governance Review-Recalled'){
                component.set("v.PerValue",100.00); 
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","APPROVED"); 
                component.set("v.lival3","APPROVED"); 
                component.set("v.lival4","PENDING");  
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","&#10004");
                component.set("v.lisubval3","&#10004");
                component.set("v.lisubval4","...");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","approved"); 
                component.set("v.lisubvalClassthree","approved");
                component.set("v.lisubvalClassfour","pending");
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","approvedphase");
                component.set("v.phaseclassthree","approvedphase");
                component.set("v.phaseclassfour","pendingphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li3");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GSAIT");
                el.style.backgroundColor = "#92D051";      
                var el = document.getElementById("li4");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GovernanceReview");
                el.style.backgroundColor = "#36B7DA";
              }
               else if(resp== 'Concept-Governance Review-Denied'){
                component.set("v.PerValue",100.00); 
                component.set("v.lival1","SUBMITTED");
                component.set("v.lival2","APPROVED"); 
                component.set("v.lival3","APPROVED"); 
                component.set("v.lival4","DENIED");   
                component.set("v.lisubval1","&#10004");
                component.set("v.lisubval2","&#10004");
                component.set("v.lisubval3","&#10004");
                component.set("v.lisubval4","&#10006");
                component.set("v.lisubvalClassone","stageone"); 
                component.set("v.lisubvalClasstwo","approved"); 
                component.set("v.lisubvalClassthree","approved");
                component.set("v.lisubvalClassfour","denied");
                component.set("v.phaseclassone","approvedphase");
                component.set("v.phaseclasstwo","approvedphase");
                component.set("v.phaseclassthree","approvedphase");
                component.set("v.phaseclassfour","deniedphase");
                var el = document.getElementById("li1");
                el.classList.add("slds-is-active");
                var el = document.getElementById("ConceptRequest");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li2");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("Executive");
                el.style.backgroundColor = "#92D051";
                var el = document.getElementById("li3");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GSAIT");
                el.style.backgroundColor = "#92D051";      
                var el = document.getElementById("li4");
                el.classList.add("slds-is-active"); 
                var el = document.getElementById("GovernanceReview");
                el.style.backgroundColor = "#FC0202";  
              }
                console.log('---------------------->>'+response.getReturnValue());
            }
            else {
                	console.log("Failed with state: " + state); 
            }
            
     });
     $A.enqueueAction(action);   
	}
})