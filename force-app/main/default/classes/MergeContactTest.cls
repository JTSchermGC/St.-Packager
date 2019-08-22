@Istest
public class MergeContactTest {
	@Istest 
	static void testMethodMerge(){
        Test.starttest();
        /*
            List<sObject> records2 = new List<sObject>(); 
            records2.add(new Contact(firstname='TestFirstApi1',lastname='LastMiddle1',Email='TestEmailApi1@gmail.com',Donor_Id__c=123477,User_Id__c='wewe2323'));
            insert records2;
        
            List<Contact> ContactVal = [SELECT Id FROM Contact];
            delete ContactVal;
        */
        
        Contact master = new Contact(firstname='TestFirstApi1',lastname='LastMiddle1',Email='TestEmailApi1@gmail.com',Donor_Id__c=123477,User_Id__c='wewe2323');
        insert master;
        
        Contact[] duplicates = new Contact[]{new Contact(firstname='TestFirstApi1',lastname='LastMiddle1',Email='TestEmailApi1@gmail.com',Donor_Id__c=123477,User_Id__c='wewe2323'), new Contact(firstname='TestFirstApi111',lastname='LastMiddle1',Email='TestEmailApi1@gmail.com',Donor_Id__c=123477,User_Id__c='wewe2323')};
        insert duplicates;
        
        Database.MergeResult[] results = Database.merge(master, duplicates, false);
        
        
        Test.StopTest();
    }
}