@Istest 
global class CallMergeContactHttpCallout implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {

        HttpResponse respost = new HttpResponse();
        respost.setHeader('Content-Type', 'application/json');

        String endPoint = String.valueOf(req.getEndpoint());
        if(endPoint.contains(Label.M))  
        {   
          	respost.setBody('test');
        }
        respost.setStatusCode(201);
        return respost;
    }
}