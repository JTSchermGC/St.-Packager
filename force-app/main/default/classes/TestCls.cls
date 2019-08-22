public class TestCls {
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
                string address2=StreetData.get(0).GC_Address_2__c;
                string address1=StreetData.get(0).GC_Address_1__c;
                string country=CommonClass.GetCountryCode(ContactData.MailingCountry);
                 //-----------New Donor Api Call ---------------------------------------------------------------
                
                string JsonString = '{"Id":"'+idVal[0]+'","org_id": "'+CommonClass.OrgId()+'","userid":"'+userkey+'","password":"","first_name":"'+CommonClass.ReplaceNull(ContactData.FirstName)+'","last_name":"'+CommonClass.ReplaceNull(ContactData.LastName)+'","email":"'+CommonClass.ReplaceNull(ContactData.Email)+'","address1":"'+CommonClass.ReplaceNull(address1)+'","address2":"'+CommonClass.ReplaceNull(address2)+'","city":"'+CommonClass.ReplaceNull(ContactData.MailingCity)+'","state":"'+CommonClass.ReplaceNull(ContactData.MailingState)+'","country":"'+CommonClass.ReplaceNull(country)+'","zip":"'+CommonClass.ReplaceNull(ContactData.MailingPostalCode)+'","phone":"'+CommonClass.ReplaceNull(ContactData.HomePhone)+'","date_of_birth":"'+CommonClass.ReplaceNull(string.valueOf(ContactData.Birthdate))+'","parishid": "'+parishid+'","phone2":"'+CommonClass.ReplaceNull(ContactData.OtherPhone)+'","suppressConfirmationEmail":"0","sf_api_call":"0"}';
			    system.debug('method dssdfdss');
                String AccessToken = CommonClass.Token();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Label.ApiCallUrl+'intregation/saveDonorDetails');
        req.setTimeout(120000);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setHeader('Authorization', 'Bearer '+AccessToken);
        req.setBody(JsonString);
        HttpResponse ResCreate = http.send(req);
        string strRes=ResCreate.getBody();
        JSONParser parserResult =JSON.createParser(strRes);
        system.debug(ResCreate);
        system.debug(strRes);
                if(ResCreate.getStatusCode() == 201){
                    system.debug('success');
                }
        //return ResCreate.getStatusCode();
                
                //CommonClass.HTTPRequest(JsonString,Label.ApiCallUrl+'intregation/saveDonorDetails');
                 
           }
    
    }
}