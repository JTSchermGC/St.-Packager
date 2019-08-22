trigger RecurringTrigger on npe03__Recurring_Donation__c (after insert, after update) {
    system.debug(Trigger.new);
    if(CheckUpdation.isfutureupdate!=true)
    {
        if(trigger.isAfter && Trigger.isUpdate){
            if(recusrssionPreventController.flag == true){
                recusrssionPreventController.flag = false;
                if(Trigger.new.size() == 1){
                    String RecordId = Trigger.new[0].Id;
                    system.debug('asdasd');
                    RecurringDonationsClass.RecurringDonations(RecordId);
                }
            }
        }
    }
}