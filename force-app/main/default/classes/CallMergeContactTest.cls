@Istest 
public class CallMergeContactTest {
    @Istest 
	static void testMethodMerge(){
        Test.starttest();
		Test.setMock(HttpCalloutMock.class, new GCDeleteAPIHttpCallout());
        CallMergeContact.callmerge('asdsad213321','312321',Label.M);
        System.assertEquals(200, 200);
        Test.StopTest();
    }
}