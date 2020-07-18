var j$ =  jQuery.noConflict();
            var pgStructure1 =  '#IntakeForm\\:j_id5\\:';
            var uservalues = [];
            var enhancementbenefitother = [];
            var newimpactbenefitvalues =[];


            var disableEnterKey = function(){
                j$(window).keydown(function(event){
                    if(event.keyCode == 13) {
                        event.preventDefault();
                        return false;
                    }
                });
            };

            var hookFormSubmissionToForceValidation = function() {
                j$( "form" ).submit(function() {
                    return validateForm();
                });
            };

            var FormObj = function () {
                this.elementToScrollTo =    undefined;
                this.errorsFound =          false;
                this.firstErrorLoc =        100;
                this.curErrorIndex =        0;
                this.Requestorname = j$(pgStructure1+"Requestorname").val();
                this.phone =                j$( pgStructure1 + "phone" ).val();
                this.email =         j$( pgStructure1 + "email" ).val();
                this.SSO = j$(pgStructure1+"SSO").val();
                this.type = j$(pgStructure1+"type").val();
                this.Region = j$(pgStructure1+"Region").val();
                this.newIntakename = j$(pgStructure1+"newIntakename").val();
                this.newIntakeDescription = j$(pgStructure1+"newIntakeDescription").val();
                this.newIntakeFederalMandateResult = j$(pgStructure1+"newIntakeFederalMandateResult").val();
                this.newIntakeFederalMandateDescription =j$(pgStructure1+"newIntakeFederalMandateDescription").val();
                this.newIntakeBudget = j$(pgStructure1+"newIntakeBudget").val();
                this.NewManagementContact = j$(pgStructure1+"NewManagementContact").val();
                this.newIntakeCostInfo = j$(pgStructure1+"newIntakeCostInfo").val();
                this.newIntakeCostEstimate = j$(pgStructure1+"newIntakeCostEstimate").val();
                this.newIntakeusersImpacted = j$(pgStructure1+"newIntakeusersImpacted").val();
                this.NewUserImpact = j$(pgStructure1+"NewUserImpact").find('input[type="checkbox"]:checked');
                this.NewIntakebenefit = j$(pgStructure1+"NewIntakebenefit").find('input[type="checkbox"]:checked').length;
                this.enhancementIntakename = j$(pgStructure1+"enhancementIntakename").val();
                this.enhancementIntakecategory = j$(pgStructure1+"enhancementIntakecategory").val();
                this.enhancementIntakecategoryother = j$(pgStructure1+"enhancementIntakecategoryother").val();
                this.enhancementIntakeFederalMandateResult = j$(pgStructure1+"enhancementIntakeFederalMandateResult").val();
                this.enhancementIntakeFederalMandateDescription = j$(pgStructure1+
                                                                    "enhancementIntakeFederalMandateDescription").val();
                this.enhancementIntakeDescription = j$(pgStructure1+"enhancementIntakeDescription").val();
                this.enhancementIntakeBudget = j$(pgStructure1+"enhancementIntakeBudget").val();
                this.enhancementManagementContact = j$(pgStructure1+"enhancementManagementContact").val();
                this.enhancementIntakeCostInfo = j$(pgStructure1+"enhancementIntakeCostInfo").val();
                this.ehancementIntakeusersImpacted = j$(pgStructure1+"ehancementIntakeusersImpacted").val();
                this.EhancementUserImpact = j$(pgStructure1+"EhancementUserImpact").find('input[type="checkbox"]:checked');
                
                this.enhancementIntakebenefit = j$(pgStructure1+"enhancementIntakebenefit").find('input[type="checkbox"]:checked').length;
               
                this.propListOrder = ["Requestorname","phone","email","SSO","Region",
                                      "type","newIntakename","newIntakeDescription",
                                      "newIntakeFederalMandateResult",
                                      "newIntakeFederalMandateDescription",
                                      "newIntakeBudget","NewManagementContact",
                                      "newIntakeCostInfo","newIntakeCostEstimate",
                                      "newIntakeusersImpacted",
                                      "enhancementIntakename","enhancementIntakecategory",
                                      "enhancementIntakecategoryother",
                                      "enhancementIntakeFederalMandateResult",
                                      "enhancementIntakeFederalMandateDescription",
                                      "enhancementIntakeDescription",
                                      "enhancementIntakeBudget",
                                      "enhancementManagementContact",
                                      "enhancementIntakeCostInfo",
                                      "ehancementIntakeusersImpacted"];

                this.checkIfFieldsAreEmpty = function(){
                    for(var property in this){
                        if(this.hasOwnProperty(property)){
                            if(this[property] === ""){
                                this.setErrorsFound(property);
                            } else {
                                j$( "#" + property + "Error" ).hide();
                            }
                        }
                    }
                }

                this.setErrorsFound = function(propName){
                    j$( "#" + propName + "Error" ).show();
                    this.errorsFound = true;
                    this.curErrorIndex = this.getPropertyListIndex(propName);
                    if(this.firstErrorLoc > this.curErrorIndex){
                        this.firstErrorLoc = this.curErrorIndex;
                        this.setElementToScrollTo(propName);
                    }
                }


                this.getPropertyListIndex = function(propName){
                    var result = -1;
                    for(var i = 0; i < this.propListOrder.length; i++){
                        if(this.propListOrder[i] == propName){
                            result = i;
                        }
                    }
                    return result;
                }


                this.setElementToScrollTo = function(propName){
                    this.elementToScrollTo = j$( pgStructure1 + propName);
                }


                this.checkifNewUserImpactCheckboxfilled = function(){
                    if(this.NewUserImpact.length==0 && this.type=="New"){
                        this.setErrorsFound("NewUserImpact");
                        return false;
                    }  
                }

                this.checkifNewUserOtherchecked = function(){
                    uservalues = new Array();
                    var flag;
                    j$(pgStructure1+"NewUserImpact").find('input[type="checkbox"]:checked').each(function(){

                        uservalues.push(j$(this).val());
                        otherval = j$(pgStructure1+"otherimpactedUser").val();
                        if(j$.inArray("Other", uservalues) !== -1 && otherval.length==0){ 
                          flag = true;
                        }else if (j$.inArray("Other", uservalues) == -1){
                            flag = false;
                        }
                    });
                    if(flag==true){
                        //flag = false;
                        return true;
                    }
                    else{
                        return false;
                    }
                }

                
                this.checkifNewUserError = function(){
                    if(this.checkifNewUserOtherchecked()==true){
                        this.setErrorsFound("otherimpactedUser");
                        return false;
                    }else{
                         j$("#otherimpactedUserError").hide();
                        return true;
                    }  
                }
                

                this.checkifNewBenefitCheckboxfilled = function(){
                    if(this.NewIntakebenefit==0 && this.type=="New"){
                        this.setErrorsFound("NewIntakebenefit");
                        return false;
                    }     
                }

                
                this.checkBenefitotherchecked = function(){
                    var otherchecked = false;
                    newimpactbenefitvalues = new Array();
                    
                    j$(pgStructure1+"NewIntakebenefit").find('input[type="checkbox"]:checked').each(function(){


                        newimpactbenefitvalues.push(j$(this).val());
                        //var checkeduservals = uservalues.join (", ");
                        otherbenefitval = j$(pgStructure1+"newbenefitother").val();
                        if(j$.inArray("Other", newimpactbenefitvalues) !== -1 && otherbenefitval.length==0){
                            
                            otherchecked = true;
                        }else if(j$.inArray("Other", newimpactbenefitvalues) == -1){
                                otherchecked = false;
                            }
                    });

                    if(otherchecked){
                        return true;
                    }
                    else{
                        return false;
                    }
                }


                this.checkBenefitOtherError = function(){
                    if(this.checkBenefitotherchecked()==true){
                        this.setErrorsFound("newbenefitother");
                        return false;
                    }else{
                        j$("#newbenefitotherError").hide();
                        return true;
                    }  

                }


                this.checkifEnhancementBenefitCheckboxfilled = function(){
                    if(this.enhancementIntakebenefit==0 && this.type=="Enhancement"){
                        this.setErrorsFound("enhancementIntakebenefit");
                        return false;
                    }     
                }


                this.checkEnhancementBenefitotherchecked = function(){
                    var otherenhancementchecked = false;
                    enhancementimpactbenefitvalues = new Array();
                    
                    j$(pgStructure1+"enhancementIntakebenefit").find('input[type="checkbox"]:checked').each(function(){


                        enhancementimpactbenefitvalues.push(j$(this).val());
                        //var checkeduservals = uservalues.join (", ");
                        otherenhancementbenefitval = j$(pgStructure1+"enhancementbenefitother").val();
                        if(j$.inArray("Other", enhancementimpactbenefitvalues) !== -1 && otherenhancementbenefitval.length==0){
                            
                            otherenhancementchecked = true;
                        }else if(j$.inArray("Other", enhancementimpactbenefitvalues) == -1){
                                otherenhancementchecked = false;
                            }
                    });

                    if(otherenhancementchecked){
                        return true;
                    }
                    else{
                        return false;
                    }
                }

                 this.checkEnhancementBenefitOtherError = function(){
                    if(this.checkEnhancementBenefitotherchecked()==true){
                        this.setErrorsFound("enhancementbenefitother");
                        return false;
                    }else{
                        j$("#enhancementbenefitotherError").hide();
                        return true;
                    }  

                }

                this.checkifEnhancementUserImpactCheckboxfilled = function(){
                    if(this.EhancementUserImpact.length==0 && this.type=="Enhancement"){
                        this.setErrorsFound("EhancementUserImpact");
                        return false;
                    }  
                }

                this.checkifEnhancementUserOtherchecked = function(){
                    enhancementuservalues = new Array();
                    var flag;
                    j$(pgStructure1+"EhancementUserImpact").find('input[type="checkbox"]:checked').each(function(){
                        enhancementuservalues.push(j$(this).val());
                        otherenhancementval = j$(pgStructure1+"enhancementotherimpactedUser").val();
                        if(j$.inArray("Other", enhancementuservalues) !== -1 && otherenhancementval.length==0){ 
                          flag = true;
                        }else if (j$.inArray("Other", enhancementuservalues) == -1){
                            flag = false;
                        }
                       
                    });
                    if(flag==true){
                        //flag = false;
                        return true;
                    }
                    else{
                        return false;
                    }
                }

                
                this.checkifEnhancementUserError = function(){
                    if(this.checkifEnhancementUserOtherchecked()==true){
                        this.setErrorsFound("enhancementotherimpactedUser");
                        return false;
                    }else{
                         j$("#enhancementotherimpactedUserError").hide();
                        return true;
                    }  
                }


                this.checkIfValidPhoneNumber = function(){
                    if(!this.isValidUSPhoneNumber()) {
                        this.setErrorsFound("phone");
                        return false;
                    }
                }

                
                this.isValidUSPhoneNumber = function(){

                   return /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/.test(this.phone);
                }
                
                this.checkIfValidEmailAddress = function() {
                    if(!this.isValidEmail()){

                        this.setErrorsFound("email");
                        return false;
                    }
                }

                this.isValidEmail = function() {
                    return /^[a-zA-Z0-9._|\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\.gov|mil|us$/.test(this.email);
                }
                
                this.scrollToFirstError = function() {
                    try {
                        j$("html,body").animate({

                            scrollTop: this.elementToScrollTo.offset().top
                        });
                    } catch(err){
                        window.scrollTo(0,0);
                    }
                }
            };

            var validateForm = function () {
                var form = new FormObj();
                form.checkIfFieldsAreEmpty();
                form.checkIfValidPhoneNumber();
                form.checkIfValidEmailAddress();
                form.checkifNewUserImpactCheckboxfilled();
                form.checkifNewBenefitCheckboxfilled();
                form.checkifEnhancementBenefitCheckboxfilled();
                form.checkifEnhancementUserImpactCheckboxfilled();
                form.checkifNewUserError();
                form.checkBenefitOtherError();
                form.checkEnhancementBenefitOtherError();
                form.checkifEnhancementUserError();

                if(form.errorsFound){
                    form.scrollToFirstError();
                    return false;
                } else {
                    return true;
                }
            };

            (function(){
                disableEnterKey();
                hookFormSubmissionToForceValidation();    
            }());