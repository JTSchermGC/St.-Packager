trigger MergeContact on Contact (After Insert,After update,After delete) {
    if (trigger.isAfter && trigger.isDelete) {
        //system.debug('deleted id');
        if(Trigger.old.size()>0){
            String[] stringList = new String[0];
            String WinnerId;
            for (Contact con : Trigger.old) {
                if(con.MasterRecordId==null){
                    system.debug('This is null');    
                }else{
                    
                    // DonorPaymentMethod__c Paymentmethod = [SELECT Id FROM DonorPaymentMethod__c WHERE Id = :con.Id];
                    //system.debug('hello');
                    //system.debug(con.Id);
                    //system.debug(Paymentmethod);
                    //return false;
                    //Paymentmethod.Contact__c= con.MasterRecordId;
                    stringList.add(String.valueOf(con.User_Id__c));
                     WinnerId=con.MasterRecordId;
                }
            }
            
            if(stringList.size()>0){
                String result = String.join(stringList, ',');
                system.debug(result);
                
                List<Contact> contactList =[SELECT ID,Donor_Id__c,User_Id__c FROM Contact WHERE ID=:WinnerId]; 
                if(contactList[0].User_Id__c!=''){
                    try{
                        CallMergeContact.callmerge(contactList[0].User_Id__c,result,Label.M);
                        //system.debug(returnval);
                           
                    }catch(exception e){
            			system.debug(String.valueOf(e));
        			}
					
                }
            }else{
                system.debug('no delete');
            }
            
        }
    }else{
        system.debug('hi');
    }
}