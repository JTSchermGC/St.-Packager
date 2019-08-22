({
	myAction : function(component, event, helper) {
		var myIdVal = component.get("v.sObjectName");
		var action = component.get("c.DonorDeleteData");
        action.setParams({ "idVal": component.get("v.recordId"),"paramType":"Pledge"});
        //action.setParams({ "paramType":"Recurring"});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                
               var serverResponse = response.getReturnValue();
                $A.get("e.force:closeQuickAction").fire();
                alert("Opportunity Deleted Successfully");
                window.history.back();
            }else{
                alert('false');
            }
        });
        $A.enqueueAction(action);    
	}
})