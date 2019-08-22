({     
   doAction : function(component, event,helper) {
        var inputName = component.find("inputName");
        var inputNamevalue = inputName.get("v.value");
        var inputCmp = component.find("inputCmp");
        var value = inputCmp.get("v.value");
        var inputAmount = component.find("inputAmount");
        var inputAmountvalue = inputAmount.get("v.value");
       	var inputDescription = component.find("inputDescription");
        var inputDescriptionvalue =inputDescription.get("v.value");
       	var id=JSON.stringify(component.get('v.selectedLookUpRecord'));
        var Event_id_parse = JSON.parse(id);	
        var Event_id=Event_id_parse.Id;
       	if (inputNamevalue=='' || inputNamevalue==undefined) {
            inputName.set("v.errors", [{message:"Name can not be empty "}]);
            return false;
        }else{
            inputName.set("v.errors", null);
        }
        if(isNaN(value)){
            inputCmp.set("v.errors", [{message:"It should be Number "}]);
            return false;
        }else{
            inputCmp.set("v.errors", null);
        }
        if(isNaN(inputAmountvalue)){
            inputAmount.set("v.errors", [{message:"Amount should be Number "}]);
            return false;
        }else{
            inputAmount.set("v.errors", null);
        }
       	alert(inputNamevalue);
        if(inputNamevalue!=undefined && inputCmp!=''){
        	var action = component.get("c.CreateBatch");
            //-------This is to send data to server side controller
            action.setParams({
                "Name":inputNamevalue,
                "ExpectedCount":value,
                "description":inputDescriptionvalue,
                "amount":inputAmountvalue,
                "Event_id":Event_id
            });
            action.setCallback(this, function(a){
            	var state = a.getState(); // get the response state
                if(state == 'SUCCESS') {
                   // alert(a.getReturnValue());
                 	var resultToast = $A.get("e.force:showToast");
                   	var evt = $A.get("e.force:navigateToURL");
                    //-----Redirect to list View
                    evt.setParams({
                        "url":"https://nonprofit-1-dev-ed.lightning.force.com/lightning/n/Batch_List"
                    });
                    evt.fire();
                    //-----Success message
                    resultToast.setParams({"title": "Success!","message": "Record Saved Successfully"});
                    resultToast.fire();
                }
        	});
   			$A.enqueueAction(action);
        }else{
            
        }
    },
    handleError: function(component, event,helper){
        /* do any custom error handling
         * logic desired here */
        // get v.errors, which is an Object[]
        var errorsArr  = event.getParam("errors");
        for (var i = 0; i < errorsArr.length; i++) {
            console.log("error " + i + ": " + JSON.stringify(errorsArr[i]));
        }
    },
    handleClearError: function(component, event,helper) {
        var src = event.getSource();
		//console.log(src.get("v.value"));
		var inputCmp=component.find("inputCmp");
		inputCmp.set("v.errors", null);
    }
    
    
	
})