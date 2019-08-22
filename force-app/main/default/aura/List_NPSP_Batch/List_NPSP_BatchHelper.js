({
        getContacts : function(component) {
            var action = component.get("c.PullBatch");
            var self = this;
            action.setCallback(this, function(actionResult){
                var state = actionResult.getState();
                if (state === "SUCCESS") {
               		console.log(actionResult.getReturnValue());
                    component.set("v.Batch", actionResult.getReturnValue());
                }            
            });
            $A.enqueueAction(action);
        }
	})