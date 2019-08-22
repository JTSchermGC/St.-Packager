@Istest
public class GetGcTokenTest {
	@isTest static void testCallout(){
        Test.starttest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new GetGcTokenHttpCallout());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        GetGcToken.TokenData();
        
        System.assertEquals(200, 200);
        Test.StopTest();
    }
}