({
    destroyModal : function(component, event, helper) {
        //alert(event.getSource());
		//alert(component.get("v.attributeName"));
		component.destroy();
		 component.set("v.messages", []); 
    },
    //ranbir code added
    doInit:function(component, event, helper) {
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
      //alert(component.get('v.BatchId'));  autoval_Data
      //component.find("contact_data").set(component.get('v.BatchId'));
    },
    onchangePayment:function(component, event, helper) {
        component.set('v.paymentType',component.find('paymentmethod').get('v.value'));
    }
    
})