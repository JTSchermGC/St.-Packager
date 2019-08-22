({
    doUpdate : function(component, event, helper){
    	//----------This is to get value from another componenet
    	//
    	
		helper.dataPush(component,helper);
        //alert(JSON.stringify(parentBody[i].find('findableAuraId').get('v.ContactselectedLookUpRecord')));
	},
     doInit : function(component, event, helper) {
        var batchId=component.get('v.dataId');
         	var action_check = component.get("c.checkBatch");

            //-------This is to send data to server side controller
            action_check.setParams({
                "BatchId":batchId
            });
            action_check.setCallback(this, function(a){
            	var state = a.getState(); // get the response state
                if(state == 'SUCCESS'){
                    if(a.getReturnValue().length==1){
                        let result_set=a.getReturnValue();
                        component.set("v.batch_name",result_set[0].Name);
						component.set("v.batch_desc",result_set[0].Description__c);  
                        component.set("v.batch_amount",result_set[0].Amount__c);
						component.set("v.batch_count",result_set[0].BatchCount__c);
                        component.set("v.batch_count",result_set[0].BatchCount__c);
                        component.set("v.type_contact",component.get('v.type'))
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
    },
    doAction : function(component, event, helper) {
		helper.PullData(component,helper);
	
	},
    createModal : function(component, event, helper) {
        helper.PullData(component,helper);
    },
    onchangeAction: function(component, event, helper) {
    	//var parentCmp = component.find("ModalDiv");
    	var navigateEvent = $A.get("e.force:navigateToComponent");
        var data_id=component.get('v.dataId');
        var type=component.find("type").get('v.value');
        
        navigateEvent.setParams({
            componentDef: "c:BatchNewGift",
            componentAttributes :{"dataId":data_id,"type":type}
        });   
        navigateEvent.fire();
		//var parentBody = parentCmp.get("v.body");
        //parentBody[i].destroy();
        //var i=1;
       // component.find('findableAuraId').destroy();
        //component.find("ModalDiv").set("v.body",[])
        //for(i=1;i<parentBody.length;i++){
            //alert(parentBody[i]);
        	//alert(JSON.stringify(parentBody[i].find('findableAuraId').get('v.ContactselectedLookUpRecord')));   
        	//alert(parentBody[1].find('findableAuraId').get('v.myString'));     
        //}
    }
})