public with sharing class MedicalRecordController {
    
    // Get medical records for an appointment
    @AuraEnabled(cacheable=true)
    public static List<Medical_Record__c> getMedicalRecords(Id appointmentId) {
        return [
            SELECT Id, Diagnosis__c, Prescription__c, Blood_Pressure__c,
                   Body_Temperature__c, Patient_Weight__c, Date_for_follow_up__c, Status_Of_The_Record__c
            FROM Medical_Record__c
            WHERE Appointment__c = :appointmentId
            ORDER BY CreatedDate DESC
        ];
    }

    // Create a new medical record
    @AuraEnabled
    public static Id createMedicalRecord(Id appointmentId, String diagnosis,
                                         String prescription, String bp,
                                         Decimal temperature, Decimal weight,
                                         Date followUpDate, String status) {
        Medical_Record__c record = new Medical_Record__c();
        record.Appointment__c = appointmentId;
        record.Diagnosis__c = diagnosis;
        record.Prescription__c = prescription;
        record.Blood_Pressure__c = bp;
        record.Body_Temperature__c = temperature;
        record.Patient_Weight__c = weight;
        record.Date_for_follow_up__c = followUpDate;
        record.Status_Of_The_Record__c = status;
        insert record;
        return record.Id;
    }
}
