({
	myAction : function(component, event, helper) {
        //alert("Asdsadsa");
		var action = component.get("c.OpportunityData");
        action.setParams({ "idVal": component.get("v.recordId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
               var serverResponse = response.getReturnValue();
                console.log(serverResponse[0]);
                if(serverResponse[0] ==201 || serverResponse[0] ==200){
                	var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success Message',
                        message: 'Sync Successfully',
                        messageTemplate: 'Record {0} created! See it {1}!',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }else{
        			var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message: 'Error In Sync',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'warning',
                        mode: 'sticky'
                    });
                    toastEvent.fire();
                }
                $A.get("e.force:closeQuickAction").fire()
            }
        });
        $A.enqueueAction(action);    
	}
})