@Istest
public class SyncDonorToGCTest {
    @Istest 
	static void testCallout(){
    	
        List<sObject> records = new List<sObject>();
        
        records.add(new Contact(firstname='TestFirstApi',lastname='LastMiddle',Email='TestEmailApi@gmail.com'));
        insert records;
        
        List<Id> ContactId = new List<Id>();
        Contact ContactVal;
        ContactVal = [SELECT Id FROM Contact];
        ContactId.add(ContactVal.Id);
     
        
        
        Test.starttest();
        Test.setMock(HttpCalloutMock.class, new SyncDonorCalloutHttpCallout());
        SyncDonorCallout.ContactDataCallout(ContactId);
        System.assertEquals(200, 200);
        Test.StopTest();
   
    }
    
}