trigger CampaignTrigger on Campaign (after insert, after update) {
	if(Trigger.new.size() == 1){
        String RecordId = Trigger.new[0].Id;
       // GetGcDonorData.DonorData(RecordId);
    }
}