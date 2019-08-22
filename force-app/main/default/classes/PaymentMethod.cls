public class PaymentMethod 
{
    public String id_val{get;set;}    
    
    public PageReference Show()
    {
        
        String ID_val = Apexpages.currentPage().getParameters().get('id');
        String contact_id = Apexpages.currentPage().getParameters().get('contact_id');
        String str =ID_val;
        system.debug(ID_val);
        if(String.isEmpty(str)){
        	PageReference pageRef = new PageReference('https://nonprofit-1-dev-ed.lightning.force.com/lightning/r/Contact/'+contact_id+'/view');	  
			//apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'Total Number of reloads: as');
        	//apexpages.addmessage(msg);
            return pageRef;
        }else{
            Integer Replaced = Integer.Valueof(ID_val.replace(',', ''));
            string return_url='https://nonprofit-1-dev-ed.lightning.force.com/lightning/r/Contact/'+contact_id+'/view';
            PageReference pageRef = new PageReference('https://gcadhoc.myworkforce.org/paymentMethod/core1.php?do=orderpage&donor_id='+Replaced+'&location_id=558&return_url='+return_url);	  
            return pageRef;
           // PageReference pageRef = new PageReference('http://13.228.196.1/test-sites/salesforce-test/abc.php?donor_id='+ID_val);	  
            //return pageRef;
        }  
        
    }
}