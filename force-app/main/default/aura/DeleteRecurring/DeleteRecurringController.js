({
	myAction : function(component, event, helper) {
		var myIdVal = component.get("v.sObjectName");
		var action = component.get("c.DonorDeleteData");
        action.setParams({ "idVal": component.get("v.recordId"),"paramType":"Recurring"});
        //action.setParams({ "paramType":"Recurring"});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                alert(state);
               var serverResponse = response.getReturnValue();
                
                $A.get("e.force:closeQuickAction").fire();
                alert("Recurring Deleted Successfully");
                window.history.back();
            }else{
                alert('false');
            }
        });
        $A.enqueueAction(action);    
	}
})