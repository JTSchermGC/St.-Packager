public class SyncDonorCalloutSync {
    @Future(callout=true)
	public static Void ContactDataCallout(List<Id> idVal) {
        system.debug('innnnnnn');
        contact[] donorData1 = [select Id,FirstName from contact where Id=:idVal];
        	if(donorData1.get(0).FirstName !='TestFirstApi1'){
                String userkey = CommonClass.uniqueId();
				String ColumnName = 'Id,User_Id__c,HomePhone,Donor_Id__c,Salutation,FirstName,LastName,Email,MailingAddress,OtherAddress,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,Phone,npe01__WorkEmail__c,Birthdate,OtherPhone,Title,Households__c';
                sObject DataVal = CommonClass.GetQueryData('Contact',ColumnName,idVal[0]);
                Contact ContactData = (Contact)DataVal;
                String HParish = (ContactData.Households__c == null) ? '' : ContactData.Households__c;
                string parishid = CommonClass.GetParishId(HParish);
                
                List<Street_Address__c> StreetData = CommonClass.GetStreet(idVal);
                string address2;
                string address1; 
                if(StreetData.get(0).GC_Address_2__c != Null){
                     address2=StreetData.get(0).GC_Address_2__c;
                }
                
                if(StreetData.get(0).GC_Address_1__c != Null){
                     address1=StreetData.get(0).GC_Address_1__c;
                }
                
                string country;
                if(ContactData.MailingCountry != Null){
                     country=CommonClass.GetCountryCode(ContactData.MailingCountry);
                }
                
                system.debug('ddd');
                 //-----------New Donor Api Call ---------------------------------------------------------------
                
                String sf_api='';
                String URL;
                String EventType='';
                String gcid='';
                if(string.valueOf(ContactData.Donor_Id__c) != null && string.valueOf(ContactData.Donor_Id__c) != ''){
                    URL = Label.ApiCallUrl+'intregation/updateDonorDetails/'+string.valueOf(ContactData.Donor_Id__c);
                	sf_api =',"sf_api_call":"0"';
                    gcid = ',"gcid":"'+string.valueOf(ContactData.Donor_Id__c)+'"';
                    EventType = '"sfEventType":"donor",';
                }else{
                    URL = Label.ApiCallUrl+'intregation/saveDonorDetails';
                    sf_api =',"sf_api_call":"0"';
                    EventType = '"sfEventType":"donor",';
                }
                
                string JsonString = '{'+EventType+' "sfId":"'+idVal[0]+'","org_id": "'+CommonClass.OrgId()+'","userid":"'+userkey+'" '+gcid+',"password":"","first_name":"'+CommonClass.ReplaceNull(ContactData.FirstName)+'","last_name":"'+CommonClass.ReplaceNull(ContactData.LastName)+'","email":"'+CommonClass.ReplaceNull(ContactData.Email)+'","address1":"'+CommonClass.ReplaceNull(address1)+'","address2":"'+CommonClass.ReplaceNull(address2)+'","city":"'+CommonClass.ReplaceNull(ContactData.MailingCity)+'","state":"'+CommonClass.ReplaceNull(ContactData.MailingState)+'","country":"'+CommonClass.ReplaceNull(country)+'","zip":"'+CommonClass.ReplaceNull(ContactData.MailingPostalCode)+'","phone":"'+CommonClass.ReplaceNull(ContactData.HomePhone)+'","date_of_birth":"'+CommonClass.ReplaceNull(string.valueOf(ContactData.Birthdate))+'","parishid": "'+parishid+'","phone2":"'+CommonClass.ReplaceNull(ContactData.OtherPhone)+'","suppressConfirmationEmail":"0" '+sf_api+'}';
                system.debug('method dssdfdss');
                
                system.debug(JsonString);
                 system.debug(URL);
                CommonClass.HTTPRequest(JsonString,URL);
                 
           }
    
    }
}