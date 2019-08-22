@Istest
public class GCDeleteAPITest {
	@Istest 
	static void testMethod1(){
    	List<sObject> records2 = new List<sObject>();
        
        records2.add(new Contact(firstname='TestFirstApi1',lastname='LastMiddle1',Email='TestEmailApi1@gmail.com',Donor_Id__c=123477));
        insert records2;
        List<Id> ContactId = new List<Id>();
        Contact ContactVal;
        ContactVal = [SELECT Id,Donor_Id__c FROM Contact];
        ContactId.add(ContactVal.Id);
        
        List<sObject> records3 = new List<sObject>();
        records3.add(new DonorPaymentMethod__c(Name='PMTTest1',Contact__c=ContactVal.Id,FourDegit__c='xxx1111',donor_payment_method_id__c=1111,donorId__c=1234));
        insert records3;
        DonorPaymentMethod__c DonorPaymentMethodVal;
        DonorPaymentMethodVal = [SELECT Id FROM DonorPaymentMethod__c];
        
        List<sObject> records5 = new List<sObject>();
        records5.add(new Merchant_Id__c(Name='Not Applicable1',MID__c='46',Type__C='CC'));
        insert records5;
        Merchant_Id__c MerchantVal;
        MerchantVal = [SELECT Id FROM Merchant_Id__c];
        
        List<sObject> records4 = new List<sObject>();
        records4.add(new Campaign(Name='EventName1',Type='Pledged Events',Status='Active',StartDate=date.valueOf('2019-05-22'),EndDate=date.valueOf('2022-07-22'),minimumAmounts__c=decimal.valueOf('1'),suggestedAmount__c=decimal.valueOf('2'),Merchant_Id__c=MerchantVal.Id));
        insert records4;
        Campaign CampaignVal;
        CampaignVal = [SELECT Id FROM Campaign];
       
        List<sObject> records = new List<sObject>();
        List<Id> recordsRecc = new List<Id>();
        records.add(new npe03__Recurring_Donation__c(Name='Rec1231',npe03__Contact__c=ContactVal.Id,npe03__Next_Payment_Date__c=date.valueOf('2019-05-22'),npe03__Installment_Period__c='Monthly',npe03__Amount__c=11,npe03__Installments__c=1,npe03__Schedule_Type__c='Multiply By',npe03__Recurring_Donation_Campaign__c=CampaignVal.Id,DonorPaymentMethod__c=DonorPaymentMethodVal.Id,GcSignupId__c=2312));
        insert records;
		npe03__Recurring_Donation__c RecVal;
        RecVal = [SELECT Id FROM npe03__Recurring_Donation__c where Name = 'Rec1231'];
        Id idValRec = RecVal.Id;
        List<Id> IdVall = new List<Id>();
        IdVall.add(idValRec);
        system.debug(IdVall);
        //Test.starttest();
        //GCDeleteAPI.DeleteCallout(IdVall);
        //Test.StopTest();
        
        String RecurringId = RecVal.Id;
        String DonorId = String.valueOf(ContactVal.Donor_Id__c);
        
        Test.starttest();
        Test.setMock(HttpCalloutMock.class, new GCDeleteAPIHttpCallout());
        GCDeleteAPI.DeleteCallout(IdVall);
        System.assertEquals(200, 200);
        
        Test.setMock(HttpCalloutMock.class, new GCDeleteAPIHttpCallout());
        GCDeleteAPI.DeleteOpporCallout(RecurringId,DonorId);
        System.assertEquals(200, 200);
        
        Test.setMock(HttpCalloutMock.class, new GCDeleteAPIHttpCallout());
        GCDeleteAPI.DeleteContactCallout(DonorId);
        System.assertEquals(200, 200);
        Test.StopTest();
    }
}