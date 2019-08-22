@isTest
public class TestErrorLogClass {
	static testMethod void myTest() {
            String [] storeData = new List<String>();
            storeData.add('Donor');
            storeData.add('Test1');
            storeData.add('Test1');
            storeData.add('Test1');
            ErrorLogClass.ErrorLogClass(storeData);
     }
}