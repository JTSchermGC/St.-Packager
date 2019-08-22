trigger PullSignupTrigger on npe03__Recurring_Donation__c (before insert) {
    system.debug('wwwwwww');
    system.debug(Trigger.new);
}