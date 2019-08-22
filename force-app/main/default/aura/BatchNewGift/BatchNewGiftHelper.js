({
 PullData: function(component, helper) {
     //var batchId=component.get('v.Id');
     var batchId=component.get('v.dataId');
     
     //var type=component.find("type_contact").get('v.value');
     var type=component.get('v.type');
     //alert(component.find("type").get("v.value"));
     var parentCmp = component.find("ModalDiv");
     var parentBody = parentCmp.get("v.body");
     var batchId=component.get('v.dataId');
     var action_check = component.get("c.checkBatch");
     //-------This is to send data to server side controller
     /*var id=JSON.stringify(component.get('v.selectedLookUpRecord'));
     var Event_id_parse = JSON.parse(id);	
     var Event_id=Event_id_parse.Id;
     if(Event_id=='' || Event_id==undefined){
     	component.set("v.showErrors",true);
        component.set("v.errorMessage","Please select the Event");
        return false;     
     }*/
     action_check.setParams({
         "BatchId":batchId
     });
     action_check.setCallback(this, function(a){
         var state = a.getState(); // get the response state
         if(state == 'SUCCESS'){
             if(a.getReturnValue().length==1){
                 let result_set=a.getReturnValue();
                 if(result_set[0].BatchCount__c>(parentBody.length-1)){
                     if(type=='1' || type=='2'){
                         $A.createComponent(
                             "c:dynamicBatchForm",{"aura:id":"findableAuraId","BatchId":batchId,"autoval_Data":"true"},
                             function(findableAuraId,status, errorMessage){
                                 if (status === "SUCCESS") {
                                     if (component.isValid()) {
                                         var targetCmp = component.find('ModalDiv');
                                         var body = targetCmp.get("v.body");
                                         body.push(findableAuraId);
                                         targetCmp.set("v.body", body); 
                                         var addmore = component.find('addmore');
                                         $A.util.removeClass(addmore, 'display_none');
                                         $A.util.addClass(addmore, 'display_block');
                                     }
                                 }
                                 else if (status === "INCOMPLETE") {
                                     alert("No response from server or client is offline.")
                                     // Show offline error
                                 }
                                     else if (status === "ERROR") {
                                         alert("Error: " + errorMessage);
                                         // Show error message
                                     }
                             }
                         );	   	   
                     }else{
                         /*-----this is for account print
                                 $A.createComponent(
                                     "c:dynamicBatchAccountForm",{"aura:id": "findableAuraId"},
                                     function(myModal,status, errorMessage){
                                         if (status === "SUCCESS") {
                                             if (component.isValid()) {
                                                 var targetCmp = component.find('ModalDiv');
                                                 var body = targetCmp.get("v.body");
                                                 body.push(myModal);
                                                 targetCmp.set("v.body", body); 
                                                 var addmore = component.find('addmore');
                                                 $A.util.removeClass(addmore, 'display_none');
                                                 $A.util.addClass(addmore, 'display_block');
                                             }
                                         }
                                         else if (status === "INCOMPLETE") {
                                             alert("No response from server or client is offline.")
                                             // Show offline error
                                         }
                                             else if (status === "ERROR") {
                                                 alert("Error: " + errorMessage);
                                                 // Show error message
                                             }
                                     }
                                 );
                                 */
                     }
                 }else{
                     component.set("v.showErrors",true);
                     component.set("v.errorMessage","You have Reached the batch Batch Count");
                     return false;    
                 }    
             }else{
                 console.log('hello else');
             }    
         }else{
             
         }    
     });
     $A.enqueueAction(action_check);   
 },
 dataPush: function(component,event,helper) {
     var parentCmp = component.find("ModalDiv");
     var parentBody = parentCmp.get("v.body");
     var i=1;
     var array_amount=[];
     let array_amount_sum=[];
     let array_event=[];
     let array_id=[];
     let array_cheque=[];
     let array_date=[];
     let array_paymentmethod=[];
     for(i=1;i<parentBody.length;i++){
        // alert(parentBody[i].find('contact_data').get('v.id'));return false;
         //var id=JSON.parse(JSON.stringify(parentBody[i].get('v.ContactselectedLookUpRecord')));----this is to pull data from another component
         //alert(id.Id);
         //alert(parentBody[i].get('v.ContactselectedLookUpRecord'));
         var id=JSON.stringify(parentBody[i].get('v.ContactselectedLookUpRecord'));
     	 var Event_id_parse = JSON.parse(id);	
     	 var Event_id=Event_id_parse.Id;
         //-------------- COde to pull contact information
         var id_contact=JSON.stringify(parentBody[i].get('v.ContactIdselectedLookUpRecord'));
     	 var contact_id_parse = JSON.parse(id_contact);	
     	 var contact_id=contact_id_parse.Id;
         if(contact_id=='' || contact_id==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Enter the Donor Id");
             return false;
         }else{
         	array_id.push(contact_id);    
         }
         //-------------end of code pulling
         /*
         if(parentBody[i].get('v.id')=='' || parentBody[i].get('v.id')==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Enter the Account/Contact Id");
             return false;
         }else{
         	array_id.push(parentBody[i].get('v.id'));    
         }
         */
         if(parentBody[i].get('v.cheque')=='' || parentBody[i].get('v.cheque')==undefined){
             array_cheque.push(parentBody[i].get('v.cheque'));
         }else{
         	array_cheque.push(parentBody[i].get('v.cheque'));    
         }
         if(parentBody[i].get('v.amount')=='' || parentBody[i].get('v.amount')==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Enter the amount");
             return false;
         }else{
         	array_amount_sum.push(parentBody[i].get('v.amount'));    
         }
         
         if(Event_id=='' || Event_id==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Enter the Event");
             return false;
         }else{
         	array_event.push(Event_id);    
         }
         
         if(parentBody[i].get('v.today')=='' || parentBody[i].get('v.today')==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Enter the Donation Date");
             return false;
         }else{
         	array_date.push(parentBody[i].get('v.today'));    
         }
         if(parentBody[i].get('v.paymentType')=='' || parentBody[i].get('v.paymentType')==undefined){
             component.set("v.showErrors",true);
             component.set("v.errorMessage","Please Select the Payment Method");
             return false;
         }else{
         	array_paymentmethod.push(parentBody[i].get('v.paymentType'));    
         }
	}
     var batchId=component.get('v.dataId');
     //-------This is to send data to server side controller
     var action_check = component.get("c.checkBatch");
     action_check.setParams({
         "BatchId":batchId
     });
     action_check.setCallback(this, function(a){
         var state = a.getState(); // get the response state
         if(state == 'SUCCESS'){
 			if(a.getReturnValue().length==1){
                let result_set=a.getReturnValue();
                var a = array_amount_sum;
                var sum = a.reduce(function(a, b) { return Number(a) + Number(b); }, 0);
                if(result_set[0].Amount__c==sum){
                    if(result_set[0].BatchCount__c==(parentBody.length-1)){
                        var type=component.get('v.type');
                        if(type=='1'){
                        	var action_check_id = component.get("c.checkContact");    
                        }else{
                        	var action_check_id = component.get("c.checkAccount");    
                        }
                        let array_string_id=array_id.join(",");
                        action_check_id.setParams({
                            "arrayId":array_string_id
                        });
                        //----------This is check for contact and account
                        action_check_id.setCallback(this, function(action_check_id_data){
                            var state = action_check_id_data.getState(); // get the response state
                            if(state == 'SUCCESS'){
                                let result_contact=action_check_id_data.getReturnValue();
                                let array_val_apex=[];
                                for(let ii=0;ii<result_contact.length;ii++){
                                	array_val_apex.push(result_contact[ii].Id);    
                                }
                                //console.log(array_val_apex);
                                //console.log(array_id);
                                let difference = array_id.filter(x => !array_val_apex.includes(x));
                                if(difference.length>0){
                                	component.set("v.showErrors",true);
                                    component.set("v.errorMessage","These Records(Id) are not associate with our Org: "+difference);
                                	return false;    
                                }else{
                                    //var id=JSON.stringify(component.get('v.selectedLookUpRecord'));
                                    //var Event_id_parse = JSON.parse(id);	
                                    //var Event_id=Event_id_parse.Id;
                                	let action_Insert_data = component.get("c.InsertDetaildBatch");
                                    action_Insert_data.setParams({
                                        //"rrr":"hellllllooooo"
                                        "BatchId":batchId,
                                        "Records":array_id,
                                        "Event":array_event,
                                        "typedata":type,
                                        "ChequeNumber":array_cheque,
                                        "amount":array_amount_sum,
                                        "donationDate":array_date,
                                        "paymentmethod":array_paymentmethod
                                    });
                                     action_Insert_data.setCallback(this, function(action_Insert_data_response){
                                     	let state_res = action_Insert_data_response.getState(); // get the response state
                            			if(state_res == 'SUCCESS'){ 
                                            let data_get=action_Insert_data_response.getReturnValue();
                                            let response_data=JSON.parse(data_get);
                                            var resultToast = $A.get("e.force:showToast");
                                            resultToast.setParams({"title": "Success!","message": response_data.message});
                    						resultToast.fire();
                                            //$A.get('e.force:refreshView').fire();
                                        }else{
                                            let data_get=action_Insert_data_response.getReturnValue();
                                            let response_data=JSON.parse(data_get);
											var resultToast = $A.get("e.force:showToast");
                                            resultToast.setParams({"title": "Error!","message": response_data.message});
                    						resultToast.fire();
                                            return false;
                                        }
                                     });
                                    $A.enqueueAction(action_Insert_data);
                                    
                                }
                            }else{
                                component.set("v.showErrors",true);
                                component.set("v.errorMessage","There is an issue to get the Contact/Account");
                                return false;     
                            }
                            //console.log(action_check_id_data.getReturnValue());	 
                            //console.log('ranbir das'); 
                        });
                        $A.enqueueAction(action_check_id);
                    }else{
                        component.set("v.showErrors",true);
                        component.set("v.errorMessage","Batch Count is Different");
                        return false;    
                    }
                }else{
                    component.set("v.showErrors",true);
                    component.set("v.errorMessage","Total amount of batch is different");
                    return false;     
                }
                
            }else{
                component.set("v.showErrors",true);
                component.set("v.errorMessage","There is no record for this");
                return false;    
            }
         }else{
             console.log('hello'); 
         }
     });
     $A.enqueueAction(action_check);
         
         //alert(parentBody[i].get('v.id')); 
         //alert(parentBody[i].get('v.amount'));      

      
 } 
})