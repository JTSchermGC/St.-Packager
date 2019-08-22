public class RecurringDonationsClass {
    @future(callout=true)
		public static void RecurringDonations(Id idVal) {
    	try{
            system.debug(idVal);
            String AccessToken = GetGcToken.TokenData();
            npe03__Recurring_Donation__c[] CampQuery = [select Id,npe03__Recurring_Donation_Campaign__c,npe03__Installment_Period__c,npe03__Date_Established__c,npe03__Next_Payment_Date__c,npe03__Last_Payment_Date__c,npe03__Amount__c,npe03__Contact__c,npe03__Schedule_Type__c,npe03__Installment_Amount__c,npe03__Installments__c from npe03__Recurring_Donation__c where Id=:idVal];
            String EventIdVal = CampQuery.get(0).npe03__Recurring_Donation_Campaign__c;
            String ContactId = CampQuery.get(0).npe03__Contact__c;
            Campaign[] eventData = [SELECT Id,gc_event_id__c FROM Campaign where Id=:EventIdVal];
            Contact[] contactData = [SELECT Id,Donor_Id__c FROM Contact where Id=:ContactId];
			String GcEventId = string.valueOf(eventData.get(0).gc_event_id__c);
            String gcid = string.valueOf(contactData.get(0).Donor_Id__c);
            string payment_frequency = (CampQuery.get(0).npe03__Installment_Period__c == null) ? '' : CampQuery.get(0).npe03__Installment_Period__c;
            string pledge_creation_date = (string.valueOf(CampQuery.get(0).npe03__Date_Established__c) == null) ? '' : string.valueOf(CampQuery.get(0).npe03__Date_Established__c);
            string payment_start_date = (string.valueOf(CampQuery.get(0).npe03__Next_Payment_Date__c) == null) ? '' : string.valueOf(CampQuery.get(0).npe03__Next_Payment_Date__c);
            string payment_end_date = (string.valueOf(CampQuery.get(0).npe03__Last_Payment_Date__c) == null) ? '' : string.valueOf(CampQuery.get(0).npe03__Last_Payment_Date__c);
            string pledge_amount = (string.valueOf(CampQuery.get(0).npe03__Amount__c) == null) ? '' : string.valueOf(CampQuery.get(0).npe03__Amount__c);
            string amount = (string.valueOf(CampQuery.get(0).npe03__Installment_Amount__c) == null) ? '' : string.valueOf(CampQuery.get(0).npe03__Installment_Amount__c);
            string ScheduleType = (CampQuery.get(0).npe03__Schedule_Type__c) == null ? '' : CampQuery.get(0).npe03__Schedule_Type__c;
            Integer Installments = Integer.valueOf(CampQuery.get(0).npe03__Installments__c);
            system.debug(payment_frequency);
            String StringJson;
            
            
            Integer StartYear = Date.valueOf(payment_start_date).year();
            Integer StartDay = Date.valueOf(payment_start_date).day();
            Integer StartMonth = Date.valueOf(payment_start_date).Month();
            date EndDate;
            String EndDateVal;
            Integer InstallmentsVal = Installments -1;
            if(payment_frequency=='Monthly'){
                date myDate = date.newInstance(StartYear, StartMonth, StartDay);
                EndDate = myDate.addMonths(InstallmentsVal);
                EndDateVal = EndDate.year() + '-' + EndDate.month() + '-' + EndDate.day();
                //system.debug(EndDate);
                
            }else if(payment_frequency=='Yearly'){
                date myDate = date.newInstance(StartYear, StartMonth, StartDay);
                EndDate = myDate.addYears(InstallmentsVal);
                EndDateVal = EndDate.year() + '-' + EndDate.month() + '-' + EndDate.day();
            }
            else if(payment_frequency=='Quarterly'){
                date myDate = date.newInstance(StartYear, StartMonth, StartDay);
                EndDate = myDate.addMonths(InstallmentsVal*3);
                EndDateVal = EndDate.year() + '-' + EndDate.month() + '-' + EndDate.day();
            }else if(payment_frequency=='Weekly'){
                date myDate = date.newInstance(StartYear, StartMonth, StartDay);
                EndDate = myDate.addDays(InstallmentsVal*7);
                EndDateVal = EndDate.year() + '-' + EndDate.month() + '-' + EndDate.day();
            }
            system.debug(EndDateVal);
            
            if(ScheduleType=='Divide By'){
             StringJson = '{"event_id":"'+GcEventId+'","donor_type":"User","gcid":"'+gcid+'","payment_frequency":"'+payment_frequency+'","payment_start_date":"'+payment_start_date+'","pledge_amount":"'+pledge_amount+'","pledge_creation_date":"'+pledge_creation_date+'","payment_end_date":"'+payment_end_date+'","amount":"'+amount+'","donor_payment_method_id":"11761","never_end_date":"false","session_id":"","cartId":"","custom_field_id": "","custom_field_value": "","device_type":"Web","no_payment":"no","memo":"","database_pledge_id":"" , "source_code":"110011", "parish_id":"10" }';
        
            }else{
            	 StringJson = '{"event_id":"'+GcEventId+'","donor_type":"User","gcid":"'+gcid+'","payment_frequency":"'+payment_frequency+'","payment_start_date":"'+payment_start_date+'","payment_end_date":"'+EndDateVal+'","amount":"'+amount+'","donor_payment_method_id":"0","never_end_date":"false","session_id":"","cartId":"","custom_field_id": "","custom_field_value": "","device_type":"Web","memo":"","allowAllStatus":""}';
            }
            system.debug(StringJson);
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Label.NewRecurringApi);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
            req.setHeader('Authorization', 'Bearer '+AccessToken);  
            req.setBody(StringJson);
            HttpResponse ResCreate = http.send(req);
            string strRes=ResCreate.getBody();
            
            
            system.debug(ResCreate);
            system.debug(strRes);
            JSONParser parserResult =JSON.createParser(strRes);
            List<String> DonorSignup=new List<String>();
            while(parserResult.nextToken() != null){
                if ((parserResult.getText() == 'donor_events_id')) {
                    //----------------Get the value.
                    parserResult.nextToken();
                    DonorSignup.add(parserResult.getText());
                }
            }
            system.debug(DonorSignup);
            List<String> TransactionDate=new List<String>();
            List<String> DonorPaymentScheduleId=new List<String>();
            JSONParser parserResult1 =JSON.createParser(strRes);
            while(parserResult1.nextToken() != null){
            if (parserResult1.getText() == 'schedules') {
                    while(parserResult1.nextToken()!= JSONToken.END_ARRAY) {
                        if(parserResult1.getCurrentToken() == JSONToken.FIELD_NAME) {
                            parserResult1.nextValue();
                            if(parserResult1.getCurrentName() == 'DonorPaymentScheduleId') {
                                DonorPaymentScheduleId.add(parserResult1.getText());
                            }else if(parserResult1.getCurrentName() == 'TransactionDate'){
                                TransactionDate.add(parserResult1.getText());
                            }  
                        } 
                    }
                }
            }
            
            system.debug(DonorPaymentScheduleId);
            system.debug(TransactionDate);
            
            Map<string,string> mapSchRes = new map<string,String>();
            for(Integer i=0;i<DonorPaymentScheduleId.size();i++){ 
                mapSchRes.put(TransactionDate[i],DonorPaymentScheduleId[i]);
            }
			system.debug(mapSchRes);
           //system.debug('sdasasdasd');
            
            List<npe03__Recurring_Donation__c> updateSignup = new List<npe03__Recurring_Donation__c>();
            List<npe03__Recurring_Donation__c> DataRec = [select Id,GcSignupId__c from npe03__Recurring_Donation__c where Id=:idVal];
            for(npe03__Recurring_Donation__c objRec:DataRec){
                objRec.GcSignupId__c = Decimal.valueOf(DonorSignup[0]);
                updateSignup.add(objRec);
            }
            system.debug(updateSignup);
            CheckUpdation.isfutureupdate=true;
            if(updateSignup.size() > 0){
                update updateSignup;
            }
            system.debug('sdasasdasd');
            List<Opportunity> updateOpp = new List<Opportunity>();
            List<Opportunity> DataOpp = [select Id,GcSignupId__c,CloseDate from Opportunity where npe03__Recurring_Donation__c =:idVal];
            for(Opportunity objOpp:DataOpp){
                
                objOpp.GcSignupId__c = Decimal.valueOf(DonorSignup[0]);
                updateOpp.add(objOpp);
            }
            if(updateOpp.size() > 0){
                update updateOpp;
            }
            
            List<Opportunity> updateOppDate = new List<Opportunity>();
            List<Opportunity> DataOppSch = [select Id,GcSignupId__c,GcScheduleId__c,CloseDate from Opportunity where GcSignupId__c =:Decimal.valueOf(DonorSignup[0])];
            for(Opportunity objOppSch:DataOppSch){
                String mapVal = mapSchRes.get(String.valueOf(objOppSch.CloseDate));
                if(mapVal !=Null){
                    objOppSch.GcScheduleId__c = Decimal.valueOf(mapVal);
                }
                updateOppDate.add(objOppSch);
            }
            
            if(updateOpp.size() > 0){
                update updateOppDate;
            }
            system.debug('sssssss');
            
        }catch(exception e){
            system.debug(String.valueOf(e));
            //List<string> returnstr = new List<string>();
           // returnstr.add('Issue');
            //return returnstr;
            //success='Issue with upload';                
        }
    }
}