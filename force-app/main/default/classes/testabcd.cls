public class testabcd {
    @Future(callout=true)
	public static Void ContactDataaa(List<Id> idVal) {
          system.debug('ssssss');
        /*
        if(updation.isfutureupdate!=true)
            {
        system.debug('asdsdsadsa');
              final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
               String guid = '';
               while (guid.length() < 7) {
               Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
               guid += chars.substring(idx, idx+1);
              }
            DateTime now = DateTime.now();
            Integer hours = now.hour(), minutes = now.minute(), seconds = now.second();
            string userkey = guid+''+hours+''+minutes+''+seconds;
             
//-------------Get GC Token------------------------------------------------------------------------------ 
             String AccessToken = GetGcToken.TokenData();  
             Http http = new Http();
//-----------End GC Token Code-----------------------------------------------------------------------------------------------             
//-----------Get New Doner Details-----------------------------------------------------------------------------------------------                          
             List<string> SetContactId = new List<string>();
             contact[] donorData = [select Id,User_Id__c,Donor_Id__c,Salutation,FirstName,LastName,Email,MailingAddress,OtherAddress,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,Phone,npe01__WorkEmail__c,Birthdate,OtherPhone,Title from contact where Id=:idVal];
             
             string first_name = (donorData.get(0).FirstName == null) ? '' : donorData.get(0).FirstName;
             string last_name = (donorData.get(0).LastName == null) ? '' : donorData.get(0).LastName;
             string email =  (donorData.get(0).email == null) ? '' : donorData.get(0).email;
             string address1 = string.valueOf(donorData.get(0).MailingStreet);
             string address2 = string.valueOf(donorData.get(0).MailingStreet);
             string city = (donorData.get(0).MailingCity == null) ? '' : donorData.get(0).MailingCity;
             string state = (donorData.get(0).MailingState == null) ? '' : donorData.get(0).MailingState;
             string zip = (donorData.get(0).MailingPostalCode == null) ? '' : donorData.get(0).MailingPostalCode;
             string country = (donorData.get(0).MailingCountry == null) ? '' : donorData.get(0).MailingCountry;
             string phone = (donorData.get(0).Phone == null) ? '' : donorData.get(0).Phone;
             string secondary_email = (donorData.get(0).npe01__WorkEmail__c == null) ? '' : donorData.get(0).npe01__WorkEmail__c;
             string date_of_birth = (string.valueOf(donorData.get(0).Birthdate) == null) ? '' : string.valueOf(donorData.get(0).Birthdate);
             string phone2 = (donorData.get(0).OtherPhone == null) ? '' : donorData.get(0).OtherPhone;
             string title = (donorData.get(0).Title == null) ? '' : donorData.get(0).Title;
             string gcidVal = (string.valueOf(donorData.get(0).Donor_Id__c) == null) ? '' : string.valueOf(donorData.get(0).Donor_Id__c);
             string recorduserid = (donorData.get(0).User_Id__c == null) ? '' : donorData.get(0).User_Id__c;
//----------Code End--------------------------------------------------------------------------------------------------             
             if(gcidVal != null && gcidVal !=''){
                 
                 //-------------Edit Doner Api Call-------------------------------------------------------
                 string stringjson = '{"token":"'+AccessToken+'" ,"Api_Link":"'+Label.NewDonorApi+'/'+gcidVal+'","first_name": "'+first_name+'","last_name": "'+last_name+'","email": "'+email+'","address1": "'+address1+'","address2": "'+address2+'", "city": "'+city+'","state": "'+state+'","country": "'+country+'","zip": "'+zip+'","phone":"'+phone+'","parishid": "","secondary_email": "", "gender": "", "date_of_birth": "'+date_of_birth+'","marital_status": "","marriage_date": "","deceased": "","current_employer": "", "gplink": "", "fblink": "","linkedin": "","personal_website": "","prefix_code": "","suffix_code": "","spouse_first_name": "","spouse_last_name": "","twitterlink":"","session_id":"","sf_api_call":"0"}';
                 system.debug(stringjson);
                 
                 HttpRequest req = new HttpRequest();
                 req.setMethod('POST');
                 req.setEndpoint('http://sfdc.myworkforce.org/SalesforceAPICall/GePatchRecord');
                  req.setTimeout(120000);
                 req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                 //req.setHeader('Authorization', 'Bearer '+AccessToken[0]); 
                 //req.setHeader('X-HTTP-Method-Override','PATCH');
                 req.setBody(stringjson);
                 HttpResponse ResCreate = http.send(req);
                 string strRes=ResCreate.getBody();
                 JSONParser errParserResult =JSON.createParser(strRes);
                 system.debug(strRes);
                  String valRes='';
                 if(ResCreate.getStatusCode() != 200){
                     List<String> errStatus=new List<String>();
                     while(errParserResult.nextToken() != null){
                         if ((errParserResult.getText() == 'errorstatus')) {
                             //----------------Get the value.
                             errParserResult.nextToken();
                             errStatus.add(errParserResult.getText());
                         }
                     }
                      valRes = String.valueOf(errStatus[0]); 
                 }else{
                      valRes = String.valueOf(ResCreate.getStatusCode()); 
                 }
                 
                 //List<string> returnstr1 = new List<string>();
                 //returnstr1.add(valRes);
                 //return returnstr1;

                 //-----------Edit Donor Code End-------------------------------------------------------------------
             }else{
                // system.debug('bbbb');
                 //-----------New Donor Api Call ---------------------------------------------------------------
               string testnitin = '{"userid":"'+userkey+'","password":"","first_name":"'+first_name+'","last_name":"'+last_name+'","email":"'+email+'","address1":"'+address1+'","address2":"'+address2+'","city":"'+city+'","state":"'+state+'","country":"'+country+'","zip":"'+zip+'","phone":"'+phone+'","date_of_birth":"'+date_of_birth+'","phone2":"'+phone2+'","suppressConfirmationEmail":"0","sf_api_call":"0"}';

 
                 system.debug(testnitin);
                 system.debug(AccessToken);
                 HttpRequest req = new HttpRequest();
                 req.setEndpoint(Label.NewDonorApi);
                 req.setTimeout(120000);
                 req.setMethod('POST');
                 req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                 req.setHeader('Authorization', 'Bearer '+AccessToken);  
                 req.setBody(testnitin);
                 HttpResponse ResCreate = http.send(req);
                 string strRes=ResCreate.getBody();
                 JSONParser parserResult =JSON.createParser(strRes);
                 
                 //system.debug(stringjson);
                 system.debug(strRes);
                 system.debug(ResCreate);
                 if(ResCreate.getStatusCode() == 201){
                     List<String> gcid=new List<String>();
                     while(parserResult.nextToken() != null){
                         if ((parserResult.getText() == 'gcid')) {
                             //----------------Get the value.
                             parserResult.nextToken();
                             gcid.add(parserResult.getText());
                         }
                     }
                     JSONParser parserResult1 =JSON.createParser(strRes);
                     List<String> userid=new List<String>();
                     while(parserResult1.nextToken() != null){
                         if ((parserResult1.getText() == 'userid')) {
                             //----------------Get the value.
                             parserResult1.nextToken();
                             userid.add(parserResult1.getText());
                         }
                     } 
                //system.debug(userid);
                //system.debug(gcid);
                List<contact> updateId = new List<contact>(); 
                List<contact> contactData = [select Id,User_Id__c,Donor_Id__c from contact where Id=:idVal];
                for(contact objUpdate: contactData){
                	objUpdate.User_Id__c = userid[0];
                    objUpdate.Donor_Id__c = decimal.valueOf(gcid[0]);
                    updateId.add(objUpdate);
                }
                     //system.debug(updateId);
                     if(updateId.size() > 0){
                         update updateId;
                     }
            	}
             
            //String valRes = String.valueOf(ResCreate.getStatusCode()); 
            //List<string> returnstr = new List<string>();
              //   returnstr.add(valRes);
                 //system.debug(returnstr);
           // return returnstr;
            
            //-----------------New Donor Api call End Code----------------------------------------------------------------------------- 
            //List<string> returnstr = new List<string>();
           // returnstr.add('Issue');
            //return returnstr;
           }
            } 
*/
    }
}