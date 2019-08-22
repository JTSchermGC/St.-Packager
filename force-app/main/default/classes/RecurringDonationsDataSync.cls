public class RecurringDonationsDataSync {
@AuraEnabled
	public static List<string>  RecurringDonations(Id idVal) {
        	system.debug('asdsd cccc');
        	String ColumnName = 'Id,npe03__Open_Ended_Status__c,DonorPaymentMethod__c,GcSignupId__c,npe03__Recurring_Donation_Campaign__c,npe03__Installment_Period__c,npe03__Date_Established__c,npe03__Next_Payment_Date__c,npe03__Last_Payment_Date__c,npe03__Amount__c,npe03__Contact__c,npe03__Schedule_Type__c,npe03__Installment_Amount__c,npe03__Installments__c,Households__c';
        	sObject DataVal = CommonClass.GetQueryData('npe03__Recurring_Donation__c',ColumnName,idVal);
        	npe03__Recurring_Donation__c RecurringData = (npe03__Recurring_Donation__c)DataVal;
        	
        	String ColumnNameEvent = 'Id,gc_event_id__c';
        	sObject EventDataVal = CommonClass.GetQueryData('Campaign',ColumnNameEvent,RecurringData.npe03__Recurring_Donation_Campaign__c);
        	Campaign EventData = (Campaign)EventDataVal;
        
        	String ColumnNameContact = 'Id,Name,Donor_Id__c';
        	sObject ContactDataVal = CommonClass.GetQueryData('Contact',ColumnNameContact,RecurringData.npe03__Contact__c);
        	Contact ContactData = (Contact)ContactDataVal;
        	
        	String PaymentName = 'donor_payment_method_id__c';
        	sObject PaymentDataVal = CommonClass.GetQueryData('DonorPaymentMethod__c',PaymentName,RecurringData.DonorPaymentMethod__c);
        	DonorPaymentMethod__c PaymentData = (DonorPaymentMethod__c)PaymentDataVal;
        
            String HParish = (RecurringData.Households__c == null) ? '' : RecurringData.Households__c;
            String parishid = CommonClass.GetParishId(HParish);
        	system.debug('parish Id '+parishid);
        
        	String payment_start_date;
        	if(RecurringData.npe03__Next_Payment_Date__c == Null || string.valueOf(RecurringData.npe03__Next_Payment_Date__c) == ''){
                Datetime dt = date.today();
				String formattedDate = dt.format('YYYY-MM-d');
                payment_start_date = formattedDate;
            }else{
                payment_start_date = string.valueOf(RecurringData.npe03__Next_Payment_Date__c);
            }
        	
         	String jsonString='{"Id":"'+idVal+'","org_id": "'+CommonClass.OrgId()+'","event_id":"'+EventData.gc_event_id__c+'","donor_type":"User","gcid":"'+ContactData.Donor_Id__c+'","payment_frequency":"'+RecurringData.npe03__Installment_Period__c+'","payment_start_date":"'+payment_start_date+'","pledge_amount":"'+RecurringData.npe03__Amount__c+'","pledge_creation_date":"'+RecurringData.npe03__Date_Established__c+'","payment_end_date":"","amount":"'+RecurringData.npe03__Installment_Amount__c+'","donor_payment_method_id":"'+PaymentData.donor_payment_method_id__c+'","never_end_date":"false","session_id":"","cartId":"","custom_field_id": "","custom_field_value": "","device_type":"Web","no_payment":"","memo":"","database_pledge_id":"","source_code":"2200221","parish_id":"'+parishid+'" ,"sf_api_call":"0","Installments":"'+RecurringData.npe03__Installments__c+'","ScheduleType":"'+RecurringData.npe03__Schedule_Type__c+'","sf_contactId":"'+ContactData.Id+'","sf_eventId":"'+EventData.Id+'","sf_contactName":"'+ContactData.Name+'"}';
 			String URL;
        	if(string.valueOf(RecurringData.GcSignupId__c) != null && string.valueOf(RecurringData.GcSignupId__c) !=''){
               URL = Label.ApiCallUrl+'recurring/saveSignupDetails/'+string.valueOf(RecurringData.GcSignupId__c);    
            }else{
               URL = Label.ApiCallUrl+'recurring/saveSignupDetails';  
            }
        	
        
        	HTTPResponse StatusVal = CommonClass.HTTPRequest(JsonString,URL);
       		system.debug(StatusVal);
            String valRes = String.valueOf(StatusVal.getStatusCode()); 
            List<string> returnstr = new List<string>();
            returnstr.add(valRes);
            return returnstr;
    }
}