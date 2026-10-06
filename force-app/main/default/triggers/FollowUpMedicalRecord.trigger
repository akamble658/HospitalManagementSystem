trigger FollowUpMedicalRecord on Medical_Record__c (after insert) {

    if(Trigger.isafter && Trigger.isInsert){
        MedicalRecordHandler.UpdateCheckboxForFolloUp(Trigger.new);
    }
}