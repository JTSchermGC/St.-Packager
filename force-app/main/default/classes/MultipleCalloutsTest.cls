@isTest
public class MultipleCalloutsTest {
	    @isTest static void testCalloutWithStaticResources() {
        // Use StaticResourceCalloutMock built-in class to
        // specify fake response and include response body 
        // in a static resource.
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('{"access_token":"17261f623da5e3abf5ebd1275d94821e29258172","expires_in":18000,"token_type":"Bearer","scope":null,"refresh_token":"329d208b26e1900d47d418a27a06903c42ecbb54"}');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call the method that performs the callout
        GetGcToken.TokenData();
        
    }
}