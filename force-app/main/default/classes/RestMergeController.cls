@RestResource(urlMapping='/merge/merge_api/*')
global class RestMergeController {
    @HttpPost
    global static String doPost(String WinnerId,String MergeId) 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        system.debug('sasffsfsdf');
        system.debug(req);
        system.debug(req);
        system.debug('aaaaaaa');
        string str=WinnerId;
        string str1=MergeId;
        
        Contact masterAcct = [SELECT Id FROM Contact WHERE User_Id__c = :WinnerId LIMIT 1];
        Contact mergeAcct = [SELECT Id FROM Contact WHERE User_Id__c = :MergeId LIMIT 1];
        /*
        String str2 = 'Contact';
        sObject obj = Schema.getGlobalDescribe().get(str2).newSObject();
        obj.put('Id', str);
        
        String str_sobj = 'Contact';
        sObject obj1 = Schema.getGlobalDescribe().get(str_sobj).newSObject();
        obj1.put('Id', str1);
		system.debug(obj);system.debug(obj1);
        system.debug(MergeId);
		*/
        system.debug(masterAcct);system.debug(mergeAcct);
        Database.merge(masterAcct,mergeAcct, false);
        return '{"res": {"status": "success", "message": "MissingRequiredQueryParameter account_name"}}';
    }
    /*
    global static void getMergeAccount(string title) {
 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String jsonResponse = '';
        String accountName = req.params.get('title');
        //String accountName = 'ranbir';
        system.debug(title);
 
        if(accountName == null){
            res.statusCode = 400;
            jsonResponse = '{"res": {"status": "Failure", "message": "MissingRequiredQueryParameter account_name"}}';
            res.responseBody = blob.valueOf(jsonResponse);
            return;
        }else{
          res.statusCode = 400;
            jsonResponse = '{"res": {"status": "Failure", "message": "MissingRequiredQueryParameter account_name"}}';
            res.responseBody = blob.valueOf(jsonResponse);
            return;  
        }

  
    }
	*/
}