public with sharing class MedicalRecordHandler {
    public static void UpdateCheckboxForFolloUp(List<Medical_Record__c> newrec) {
        Set<Id> appointmentIds = new Set<Id>();

        for (Medical_Record__c med : newrec) {
            if (med.Appointment__c != null) {
                appointmentIds.add(med.Appointment__c);
            }
        }

        Map<Id, Appointment__c> apptMap = new Map<Id, Appointment__c>(
            [SELECT Id, Follow_Up__c FROM Appointment__c WHERE Id IN :appointmentIds]
        );

        for (Medical_Record__c med : newrec) {
            if (med.Appointment__c != null && apptMap.containsKey(med.Appointment__c)) {
                Appointment__c appt = apptMap.get(med.Appointment__c);
                appt.Follow_Up__c = (med.Date_for_follow_up__c != null);
            }
        }

        if (!apptMap.isEmpty()) {
            update apptMap.values();
        }
    }
}


