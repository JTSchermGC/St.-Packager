public class CallMergeContact {
    @Future(callout=true)
    public static void callmerge(string winnerId,string userid_to_replace,string API_Url){
        
        String PostString='{"selected_userid":"'+winnerId+'","userid_to_replace":"'+userid_to_replace+'"}';
        system.debug(PostString);
        String AccessToken = GetGcToken.TokenData();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(API_Url);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setHeader('Authorization', 'Bearer '+AccessToken);  
        req.setBody(PostString);
        HttpResponse ResCreate = http.send(req);
        string strRes=ResCreate.getBody();
        JSONParser parserResult =JSON.createParser(strRes); 
        //system.debug(strRes);
    }
}