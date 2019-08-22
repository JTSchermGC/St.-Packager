@Istest 
public class SyncEventToGCTest {
	@Istest 
	static void testCallout(){
       
        List<sObject> records = new List<sObject>();
        List<sObject> records1 = new List<sObject>();
        
        records1.add(new Merchant_Id__c(Name='Not Applicable',MID__c='46',Type__C='CC'));
        insert records1;
        Merchant_Id__c MerchantVal;
        MerchantVal = [SELECT Id FROM Merchant_Id__c];
        
        records.add(new Campaign(Name='EventName',Type='Pledged Events',Status='Active',StartDate=date.valueOf('2019-05-22'),EndDate=date.valueOf('2022-07-22'),minimumAmounts__c=decimal.valueOf('1'),suggestedAmount__c=decimal.valueOf('2'),Merchant_Id__c=MerchantVal.Id));
        insert records;
        
        List<Id> CampaignId = new List<Id>();
        Campaign CampaignVal;
        CampaignVal = [SELECT Id FROM Campaign];
        CampaignId.add(CampaignVal.Id);
       
        
        Test.starttest();
        Test.setMock(HttpCalloutMock.class, new SyncEventCalloutHttpCallout());
        SyncEventCallout.EventDataCallout(CampaignId);
        System.assertEquals(200, 200);
        Test.StopTest();
    }
}