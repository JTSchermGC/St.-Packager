public class CommonClass {
	public static String Token() {
        String AccessToken = GetGcToken.TokenData();
        return AccessToken;
    }
    
    public static String OrgId(){
        Organization[] OrgData = [SELECT Id,Name,City FROM Organization];	
        String orgId = string.valueOf(OrgData.get(0).Id);
        return orgId;
    }
    
    public static String ReplaceNull(String Values){
        string DataVal = (Values == null) ? '' : Values;
        return DataVal;
    }
    
    public static String uniqueId(){
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        String guid = '';
        while (guid.length() < 7) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            guid += chars.substring(idx, idx+1);
        }
        DateTime now = DateTime.now();
        Integer hours = now.hour(), minutes = now.minute(), seconds = now.second();
        string userkey = guid+''+hours+''+minutes+''+seconds;
        return userkey;
    }
    
    public static HTTPResponse HTTPRequest(String JsonString,String NewDonorApi){
        
        String AccessToken = CommonClass.Token();
        system.debug('salesforce dsdfsd');
        system.debug(AccessToken);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(NewDonorApi);
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
        return ResCreate;
    }
    
    public static String GetParishId(String ContactId){
        system.debug(ContactId);
        string parishid='';
        if( ContactId!=Null && ContactId!='' ){
            Account[] parishData = [select Id,Parish_Id__c from Account where Id=:ContactId];
            parishid = (parishData.get(0).Parish_Id__c == null) ? '' : parishData.get(0).Parish_Id__c; 
        }else{
            parishid ='';
        }
        return parishid;
    }
    
    public static String GetCountryCode(String country_val){
        string country='';
        if(country_val!='' && country_val.length()>2){
            Country_Codes__c[] CountryData = [select Id,Country_Code__c from Country_Codes__c where Name=:country_val];
            country = (CountryData.get(0).Country_Code__c == null) ? '' : CountryData.get(0).Country_Code__c;
        }else{
            country=country_val;
        }
        return country;
    }
    
    public static sObject GetQueryData(String TableName,String ColumnName,Id ContactId){
        String Qyeryval = 'SELECT '+ColumnName+' FROM '+TableName+' WHERE Id=\''+ContactId+'\'';
        sObject QueryData = Database.query(Qyeryval);
		//system.debug(QueryData);
        return QueryData;
    }
    
    public static List<Street_Address__c> GetStreet(List<Id> idVal){
        Street_Address__c[] streetData = [select Id,GC_Address_2__c,GC_Address_1__c,SF_Address__c from Street_Address__c where Donors__c=:idVal];
    	return streetData;
    }
    
}