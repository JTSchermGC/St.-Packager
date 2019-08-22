public class BatchAPexController {
    @AuraEnabled
    public static string CreateBatch(string Name,string ExpectedCount,string description,string amount,string Event_id){   
        string Batchname=Name.stripHtmlTags();
        integer count_batch=integer.valueof(ExpectedCount);
        string descp=description;
        integer amount_data=integer.valueof(amount);
        
        try{
           NPSPBatch__c DataInsert=new NPSPBatch__c (Name=Batchname,Description__c=descp,BatchCount__c=count_batch,Amount__c=amount_data,Campaign__c=Id.valueOf(Event_id));
           insert DataInsert;
           return 'record inserted';
            
        }catch(DmlException e) {
            return e.getMessage();
        }
        
    }
    @AuraEnabled
    /*
    public static List<List<String>> PullBatch(){
        
     	list<NPSPBatch__c> pulldata=new list<NPSPBatch__c>([select Id,Name,Batch_NUmber__c,Description__c,BatchCount__c,Amount__c,CreatedDate,Status__c,campaign__r.name from NPSPBatch__c order by CreatedDate DESC limit 5]);
        List<List<String>> mainarray= new List<List<String>>(); 
        if(pulldata!=null && pulldata.size()>0) {
             for(integer i =0;i< pulldata.size();i++){
                 mainarray.add(new List<String>{pulldata[i].Id, pulldata[i].Name,pulldata[i].Batch_NUmber__c,pulldata[i].Description__c,string.valueOf(pulldata[i].BatchCount__c),string.valueOf(pulldata[i].Amount__c),string.valueOf(pulldata[i].CreatedDate),pulldata[i].Status__c,pulldata[i].campaign__r.name});
             }
         }
         return mainarray;
         
        
    }
*/
     public static List<NPSPBatch__c> PullBatch(){
        
     	list<NPSPBatch__c> pulldata=new list<NPSPBatch__c>([select Id,Name,Batch_NUmber__c,Description__c,BatchCount__c,Amount__c,CreatedDate,Status__c,campaign__r.name from NPSPBatch__c order by CreatedDate DESC]);
         return pulldata;
         
        
    }
    @AuraEnabled
    public static List<NPSPBatch__c> PullBatchContact(){
     	list<NPSPBatch__c> pulldata=new list<NPSPBatch__c>([select Id,Name,Batch_NUmber__c,Description__c,BatchCount__c,Amount__c from NPSPBatch__c]);
        return pulldata;
    }
    @AuraEnabled
    public static List<NPSPBatch__c> checkBatch(string BatchId){
     	list<NPSPBatch__c> pullCheckdata=new list<NPSPBatch__c>([select Id,Name,Batch_NUmber__c,Description__c,BatchCount__c,Amount__c from NPSPBatch__c where Id=:BatchId]);
        return pullCheckdata;
    }
    @AuraEnabled
    public static list<Contact> checkContact(string arrayId){
        String alpha = arrayId;
        List<String> lstAlpha = alpha.split(',');
     	list<Contact> ContactPull=new list<Contact>([select Id from Contact where Id in:lstAlpha]);
        //system.debug(ContactPull);
        return ContactPull;
    }
     @AuraEnabled
    public static list<Account> checkAccount(string arrayId){
        String alpha = arrayId;
        List<String> lstAlpha = alpha.split(',');
     	list<Account> accountpull=new list<Account>([select Id from Account where Id in:lstAlpha]);
        //system.debug(ContactPull);
        return accountpull;
    }
     @AuraEnabled
   // public static string InsertDetaildBatch(string BatchId,string Event,string typedata,string Records,string ChequeNumber,string amount,string donationDate){
   public static string InsertDetaildBatch(string BatchId,string[] Records,string[] Event,string typedata,string[] ChequeNumber,string[] amount,string[] donationDate,string[] paymentmethod){
 		//system.debug('ranbir das');
        /*system.debug('Batchid---'+BatchId);
        system.debug('event---'+Event);
        system.debug('type---'+typedata);
        system.debug('Records---'+Records);
        system.debug('ChequeNumber---'+ChequeNumber);
        system.debug('amount---'+amount);
        system.debug('donationDate---'+donationDate);*/
        integer length_val=Records.size();
           if(length_val>0){
               try {
                   	List<BatchEntry__c> custList = new List<BatchEntry__c>();
                    for(integer i=0;i<length_val;i++){
                        BatchEntry__c obj_list=new BatchEntry__c ();
                        obj_list.BatchId__c= BatchId;
                        obj_list.Contact__c= Id.valueOf(Records[i]);
                        obj_list.Campaign__c= Id.valueOf(Event[i]);
                        obj_list.Type__c= typedata;
                        obj_list.ChequeNumber__c= ChequeNumber[i];
                        obj_list.Amount__c= decimal.valueOf(amount[i]);
                        obj_list.DonationDate__c= Date.valueOf(donationDate[i]);
                        obj_list.PaymentType__c	=paymentmethod[i];
                        custList.add(obj_list);
                    } 
                    insert custList;
                   	return '{"status":200,"message":"Batch Inserted Successfully"}';
                }catch(DmlException e) {
                 	return '{"status":500,"message":"'+e.getMessage()+'"}';   
                }
           }else{
               
           }
       

       return Records[1];
//return 'ff';
    }
}