({
    doInit : function(cmp) {
        cmp.set("v.ObjName",cmp.get("v.sObjectName"));
        //alert('sdasdadsadasd');
        var action = cmp.get("c.GetPmtMethod");
        action.setParams({ "idVal": cmp.get("v.recordId")});
        action.setCallback(this, function(response) {
            var jsonString =response.getReturnValue();
            var jsonString_parse=JSON.parse(jsonString);
            //console.log(jsonString_parse.length);
            //console.log(jsonString_parse);
            var strr='';
            var opt=[];
            var temp = {};
            //opt.push({
            //    label: 'Please Select',
            //    value: ''
           // });
             var jsonString_parseval = '';
            for(var i = 0; i<jsonString_parse.length;++i ){
                if(jsonString_parse[i]['Type__c']==undefined){
                    var jsonString_parseval = '';
                }else{
                    var jsonString_parseval = '--'+jsonString_parse[i]['Type__c'];
                }
                opt.push({
                    label: jsonString_parse[i]['FourDegit__c']+jsonString_parseval,
                    value: jsonString_parse[i]['donor_payment_method_id__c']
                });
            }
        	cmp.find("InputSelectDynamic").set("v.options", opt);
            
        });
        
        $A.enqueueAction(action);
    },
	myAction : function(component, event, helper) {
        
            component.set("v.toggleSpinner", true);
            //alert('PmtMethodId');
           // return false;
            var action = component.get("c.RecurringDonations");
            action.setParams({ "idVal": component.get("v.recordId") });
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
                            title : 'Success!',
                            message: 'The recurring donation pledge has synced to GiveCentral',
                            messageTemplate: 'Record {0} created! See it {1}!',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                    }else if(serverResponse[0] ==503){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Warning',
                            message: 'Error In Sync - Service Unavailable',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'warning',
                            mode: 'sticky'
                        });
                        toastEvent.fire();
                    }else{
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Warning',
                            message: 'Error In Sync - '+errText,
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