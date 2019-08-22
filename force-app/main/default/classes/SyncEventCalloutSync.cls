public class SyncEventCalloutSync {
    @Future(callout=true)
	public static Void EventDataCallout(List<Id> idVal) {
        String ColumnName = 'Id,gc_event_id__c,Name,StartDate,EndDate,Type,ActualCost,Status,BudgetedCost,minimumAmounts__c,suggestedAmount__c,Merchant_Id__c';
        sObject DataVal = CommonClass.GetQueryData('Campaign',ColumnName,idVal[0]);
        Campaign CampaignData = (Campaign)DataVal;
        
        String MIDVal = CampaignData.Merchant_Id__c;
        Merchant_Id__c[] merchantData = [SELECT Id,MID__c FROM Merchant_Id__c where Id=:MIDVal];
        String MerchantId = string.valueOf(merchantData.get(0).MID__c);
        string minimumAmounts = (string.valueOf(CampaignData.minimumAmounts__c) == null) ? '' : string.valueOf(CampaignData.minimumAmounts__c);
        string suggestedAmount = (string.valueOf(CampaignData.suggestedAmount__c) == null) ? '' : string.valueOf(CampaignData.suggestedAmount__c);		
        
        String URL;
        String eventid='';
        String EventType='';
        if(string.valueOf(CampaignData.gc_event_id__c) != null && string.valueOf(CampaignData.gc_event_id__c) != ''){
            URL = Label.ApiCallUrl+'intregation/saveEventsDetails/'+string.valueOf(CampaignData.gc_event_id__c);
            eventid = ',"eventid":"'+string.valueOf(CampaignData.gc_event_id__c)+'"';
            EventType = '"sfEventType":"event",';
        }else{
            URL = Label.ApiCallUrl+'intregation/saveEventsDetails';
            EventType = '"sfEventType":"event",';
        }
        //String CampString = '{"Id":"'+idVal[0]+'","org_id": "'+CommonClass.OrgId()+'","eventTitle":"'+CampaignData.Name+'","eventStartDate":"'+CampaignData.StartDate+'","eventEndDate":"'+CampaignData.EndDate+'","eventType":"'+CampaignData.Type+'","eventFrequency":["Monthly","One-Time","Weekly","Bi-Weekly","Quarterly","Semi-Annually","Annually"],"minimumAmounts":["'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'"],"suggestedAmount":["'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'"],"accountsMerchantId":"'+MerchantId+'","displayOrder":"0","categoryId":"0","eventStatus":"'+CampaignData.Status+'","restrictDonationsBeyondEndDate":"0","sf_api_call":"0"}';

        String CampString = '{'+EventType+' "sfId":"'+idVal[0]+'","org_id": "'+CommonClass.OrgId()+'" '+eventid+',"eventTitle":"'+CampaignData.Name+'","eventStartDate":"'+CampaignData.StartDate+'","eventEndDate":"'+CampaignData.EndDate+'","eventType":"'+CampaignData.Type+'","eventFrequency":["Monthly","One-Time","Weekly","Bi-Weekly","Quarterly","Semi-Annually","Annually"],"minimumAmounts":["'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'","'+minimumAmounts+'"],"suggestedAmount":["'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'","'+suggestedAmount+'"],"accountsMerchantId":"'+MerchantId+'","displayOrder":"0","categoryId":"0","eventStatus":"'+CampaignData.Status+'","restrictDonationsBeyondEndDate":"0","sf_api_call":"0"}';
    	String StringVal= CampString;
        CommonClass.HTTPRequest(StringVal,URL);
    }

}