@Istest 
global class SyncEventCalloutHttpCallout implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {

        HttpResponse respost = new HttpResponse();
        respost.setHeader('Content-Type', 'application/json');

        String endPoint = String.valueOf(req.getEndpoint());
        if(endPoint.contains(Label.NewEventApi))  
        {   
          	respost.setBody('{"eventTitle":"test","event_id":"1234","eventStartDate":"2019-05-22","eventEndDate":"2022-07-22","eventType":"Pledged Events","eventFrequency":["Monthly","One-Time","Weekly","Bi-Weekly","Quarterly","Semi-Annually","Annually"],"minimumAmounts":"1","suggestedAmount":"2","accountsMerchantId":"46","displayOrder":"0","categoryId":"0","eventStatus":"Active","restrictDonationsBeyondEndDate":"0","sf_api_call":"0"}');
        }
        else if(endPoint.contains(Label.client_token_url))
        { 
            respost.setBody('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
            
        }
          respost.setStatusCode(201);
        return respost;
    }
}