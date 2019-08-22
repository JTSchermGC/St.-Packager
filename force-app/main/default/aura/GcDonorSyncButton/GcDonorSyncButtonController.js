({
    doInit : function(cmp) {
        //alert(cmp.get("v.sObjectName"));
        cmp.set("v.ObjName",cmp.get("v.sObjectName"));
    },
	myAction : function(component, event, helper) {
        component.set("v.toggleSpinner", true);
        //alert("Asdsadsa");
        var myIdVal = component.get("v.sObjectName")
        var myId;
        if(myIdVal == 'npe03__Recurring_Donation__c'){
             myId = 'RecurringDonation';
        }else{
             myId = myIdVal;
        }
        //alert(myId);
		var action = component.get("c."+myId+"Data");
        action.setParams({ "idVal": component.get("v.recordId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
               var serverResponse = response.getReturnValue();
                console.log(serverResponse);
                
                var i;
                var text = "";
                for (i = 0; i < serverResponse.length; i++) { 
                    console.log(i);
                    if(serverResponse[i] !='' && i !=0){
                        text += serverResponse[i]+", ";
                    }  
                }
                console.log(text);
                var errText = text.slice(0, -2);
                
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
                        message: 'Error In Sync- '+errText,
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
	},
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
   },
    hideSpinner : function(component,event,helper){
       component.set("v.Spinner", false);
    }
})