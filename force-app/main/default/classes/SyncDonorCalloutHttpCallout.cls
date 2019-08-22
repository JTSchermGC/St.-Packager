@Istest 
global class SyncDonorCalloutHttpCallout implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse respost = new HttpResponse();
        respost.setHeader('Content-Type', 'application/json');

        String endPoint = String.valueOf(req.getEndpoint());
        if(endPoint.contains(Label.NewDonorApi))  
        {   
          	respost.setBody('{"userid":"sffsdf","gcid":"1234","password":"","first_name":"first_name","last_name":"last_name","email":"email","address1":"address1","address2":"address2","city":"city","state":"state","country":"country","zip":"zip","phone":"phone","date_of_birth":"date_of_birth","phone2":"phone2","suppressConfirmationEmail":"0","sf_api_call":"0","StatusCode":"201"}');
        }
        else if(endPoint.contains(Label.client_token_url))
        { 
            respost.setBody('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
            
        }
          respost.setStatusCode(201);
        return respost;
    }
  
}