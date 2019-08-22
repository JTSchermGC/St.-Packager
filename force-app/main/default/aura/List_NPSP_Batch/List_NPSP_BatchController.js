({
	ListAction : function(component, event, helper) {
        //alert(component.get("v.accGetID"));
		helper.getContacts(component);
        
        
	},
    navigate : function(component, event, helper) {
        var navigateEvent = $A.get("e.force:navigateToComponent");
        if(event.getSource().get('v.value')==''){
          alert('No Record Found');  
        }else{
            var data_id=event.getSource().get('v.value');
        	navigateEvent.setParams({
                componentDef: "c:BatchNewGift",
                componentAttributes :{"dataId":data_id,"type":"1"}
        	});   
            navigateEvent.fire();
        }
    },
    createModal : function(component, event, helper) {
    $A.createComponent(
             "c:dynamicBatchForm",{"aura:id":"hello"},
             	function(myModal){
                     if (component.isValid()) {
                         var targetCmp = component.find('ModalDiv');
                         var body = targetCmp.get("v.body");
                         body.push(myModal);
                         targetCmp.set("v.body", body); 
                     }
             }
         );
    },
     doUpdate : function(component, event, helper){
    	
        //----------This is to get value from another componenet
        var parentCmp = component.find("ModalDiv");
		var parentBody = parentCmp.get("v.body");
       // alert(JSON.stringify(parentBody[1].find('findableAuraId').get('v.ContactselectedLookUpRecord')));
        var i=1;
       //alert(parentBody.length);
       //alert(parentBody[1].get('v.myString')); 
        //console.log(parentBody[1].find("findableAuraId"));
        //alert(JSON.stringify(parentBody[i].find('findableAuraId').get('v.ContactselectedLookUpRecord')));
        for(i=1;i<parentBody.length;i++){
          //  alert(parentBody[i].find('findableAuraId'));
        	//alert(JSON.stringify(parentBody[i].find('findableAuraId').get('v.ContactselectedLookUpRecord')));   
        	alert(parentBody[i].get('v.myString'));  
            alert(JSON.stringify(parentBody[i].get('v.ContactselectedLookUpRecord')));
        }
	},
})