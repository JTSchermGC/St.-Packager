public class GetGcEventData {
@AuraEnabled
	public static List<string> EventData(Id eventId) {
         try{
            String AccessToken = GetGcToken.TokenData();
            
             List<string> SetContactId = new List<string>();
             Campaign[] eventData = [SELECT Id,gc_event_id__c,Name,StartDate,EndDate,Type,ActualCost,Status,BudgetedCost,minimumAmounts__c,suggestedAmount__c FROM Campaign where Id=:eventId];
             
             string GcEventId = (string.valueOf(eventData.get(0).gc_event_id__c) == null) ? '' : string.valueOf(eventData.get(0).gc_event_id__c);
             string eventTitle = (eventData.get(0).Name == null) ? '' : eventData.get(0).Name;
             string eventStartDate = (string.valueOf(eventData.get(0).StartDate) == null) ? '' : string.valueOf(eventData.get(0).StartDate);
             string eventEndDate = (string.valueOf(eventData.get(0).EndDate) == null) ? '' : string.valueOf(eventData.get(0).EndDate);
             string eventType = (eventData.get(0).Type == null) ? '' : eventData.get(0).Type;
             string ticketAmount =  (string.valueOf(eventData.get(0).ActualCost) == null) ? '' : string.valueOf(eventData.get(0).ActualCost);
             string eventStatus = (eventData.get(0).Status == null) ? '' : eventData.get(0).Status;
             string suggestedAmount = (string.valueOf(eventData.get(0).suggestedAmount__c) == null) ? '' : string.valueOf(eventData.get(0).suggestedAmount__c);
             string minimumAmounts = (string.valueOf(eventData.get(0).minimumAmounts__c) == null) ? '' : string.valueOf(eventData.get(0).minimumAmounts__c);
             
             if(GcEventId !=Null && GcEventId !=''){
                 //-------------Edit Doner Api Call-------------------------------------------------------
                 String CampStringNormal = '{"token":"'+AccessToken+'" ,"Api_Link":"'+Label.NewDonorApi+'/'+GcEventId+'","eventTitle":"'+eventTitle+'","eventStartDate":"'+eventStartDate+'","eventEndDate":"'+eventEndDate+'","eventType":"'+eventType+'","eventFrequency":["One-Time"],"minimumAmounts":"'+minimumAmounts+'","suggestedAmount":"'+suggestedAmount+'","accountsMerchantId":"1","displayOrder":"0","categoryId":"0","eventStatus":"'+eventStatus+'","restrictDonationsBeyondEndDate":"0"}';
				 Http http = new Http();
                 HttpRequest req = new HttpRequest();
                 req.setMethod('POST');
                 req.setEndpoint('http://sfdc.myworkforce.org/SalesforceAPICall/GePatchRecord');
                 req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                 //req.setHeader('Authorization', 'Bearer '+AccessToken[0]); 
                 //req.setHeader('X-HTTP-Method-Override','PATCH');
                 req.setBody(CampStringNormal);
                 HttpResponse ResCreate = http.send(req);
                 string strRes=ResCreate.getBody();
                 JSONParser parserResult =JSON.createParser(strRes);
                 
                 String valRes = String.valueOf(ResCreate.getStatusCode()); 
                 List<string> returnstr1 = new List<string>();
                 returnstr1.add(valRes);
                 return returnstr1;
             }else{
                 String CampStringNormal = '{"eventTitle":"'+eventTitle+'","eventStartDate":"'+eventStartDate+'","eventEndDate":"'+eventEndDate+'","eventType":"'+eventType+'","eventFrequency":["One-Time"],"minimumAmounts":"'+minimumAmounts+'","suggestedAmount":"'+suggestedAmount+'","accountsMerchantId":"1","displayOrder":"0","categoryId":"0","eventStatus":"'+eventStatus+'","restrictDonationsBeyondEndDate":"0"}';

                 Http http = new Http();
                 HttpRequest req = new HttpRequest();
                 req.setEndpoint(Label.NewEventApi);
                 req.setMethod('POST');
                 req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                 req.setHeader('Authorization', 'Bearer '+AccessToken);  
                 req.setBody(CampStringNormal);
                 HttpResponse ResCreate = http.send(req);
                 string strRes=ResCreate.getBody();
                 JSONParser parserResult =JSON.createParser(strRes);
                 
                 system.debug(ResCreate);
                 system.debug(strRes);
                 if(ResCreate.getStatusCode() == 201){
                     List<String> event_id=new List<String>();
                     while(parserResult.nextToken() != null){
                         if ((parserResult.getText() == 'event_id')) {
                             //----------------Get the value.
                             parserResult.nextToken();
                             event_id.add(parserResult.getText());
                         }
                     } 
                    List<Campaign> updateId = new List<Campaign>(); 
                    List<Campaign> eventIds = [select Id,gc_event_id__c from Campaign where Id=:eventId];
                    for(Campaign objUpdate: eventIds){
                        objUpdate.gc_event_id__c = decimal.valueOf(event_id[0]);
                        updateId.add(objUpdate);
                    }
                     //system.debug(updateId);
                     if(updateId.size() > 0){
                         update updateId;
                     }
                 }
             }
            List<string> returnstr = new List<string>();
            returnstr.add('Issue');
            return returnstr;
         }catch(exception e){
            system.debug(String.valueOf(e));
            List<string> returnstr = new List<string>();
            returnstr.add('Issue');
            return returnstr;
            //success='Issue with upload';                
        }
    }
}