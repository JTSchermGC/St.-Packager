@Istest 
global class GCDeleteAPIHttpCallout implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {

        HttpResponse respost = new HttpResponse();
        respost.setHeader('Content-Type', 'application/json');

        String endPoint = String.valueOf(req.getEndpoint());
        if(endPoint.contains(Label.Delete_GC_Recurring+2312))  
        {   
          	respost.setBody('test');
        }else if(endPoint.contains(Label.UpdateOpp+2312))  
        {   
          	respost.setBody('test');
        }else if(endPoint.contains(Label.NewDonorApi+123477))  
        {   
          	respost.setBody('test');
        }else if(endPoint.contains(Label.client_token_url))
        { 
            respost.setBody('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
            
        }
        respost.setStatusCode(201);
        return respost;
    }
}