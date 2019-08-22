public class customLookUpController {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        //String searchKey = searchKeyWord + '%';
        
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        //String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC';
        //List < sObject > lstOfRecords = Database.query(sQuery);
        if(searchKeyWord.length()>0){
            String searchQuery='';
            if(ObjectName=='Contact'){
            	searchQuery = 'FIND \'' + searchKeyWord + '\' IN ALL FIELDS RETURNING '+ObjectName +' (id, Name,User_Id__c)';     
            }else{
            	searchQuery = 'FIND \'' + searchKeyWord + '\' IN ALL FIELDS RETURNING '+ObjectName +' (id, Name)';     
            }
        	
            List<List<sObject>> lstOfRecords = search.query(searchQuery);
            
            for (List<SObject> sobjs1 : lstOfRecords) {
                for (SObject sobj1 : sobjs1) {
                    system.debug(sobj1);
                    returnList.add(sobj1);   
                }
            }
        
        //for (sObject obj: lstOfRecords) {
           // returnList.add(obj);
       // }
        return returnList;    
        }else{
            String searchKey = searchKeyWord + '%';
            String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: '+searchKey+' order by createdDate DESC';
            //system.debug(sQuery);
        	List < sObject > lstOfRecords = Database.query(sQuery);
            for (sObject obj: lstOfRecords) {
           	 	returnList.add(obj);
       		}
			return returnList;   
        }
       
    }
    @AuraEnabled
    public static List < sObject > fetchLookUpValuesdefault(String searchKeyWord, String ObjectName) {
         List < sObject > returnList = new List < sObject > ();
        String sQuery =  'select id, Name,Campaign__c from NPSPBatch__c where Id =: searchKeyWord';
        sObject lstOfRecords = Database.query(sQuery);
        NPSPBatch__c getid=(NPSPBatch__c)lstOfRecords;
        Id cmpid=getid.Campaign__c;
        String sQuery1 =  'select id, Name from ' +ObjectName + ' where Id=: cmpid order by createdDate DESC';
        List < sObject > lstOfRecords1 = Database.query(sQuery1);
        for (sObject obj: lstOfRecords1) {
            returnList.add(obj);
        }
        return returnList;  
       
    }
}