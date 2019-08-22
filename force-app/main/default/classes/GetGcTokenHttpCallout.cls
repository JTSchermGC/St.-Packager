@isTest
global class GetGcTokenHttpCallout implements HttpCalloutMock {
	 // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals(Label.client_token_url	, req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
        res.setStatusCode(200);
        return res;
    }
}