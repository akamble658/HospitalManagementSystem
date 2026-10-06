public with sharing class AppointmentController {

    // Get all appointments
    @AuraEnabled(cacheable=true)
    public static List<Appointment__c> getAppointments() {
        return [
            SELECT Id, Name,
                   Appointment_Schedule_Time__c,
                   Appointment_Summary__c,
                   Days_Since_Appointment__c,
                   Doctor__r.Name,
                   Fee_Charged__c,
                   Follow_Up__c,
                   Hospital_Department__c,
                   Patient__r.Name,
                   Patient_Blood_Type__c,
                   Reason_for_Visit__c,
                   Status_Of_The_Appointment__c,
                   Urgency_Level__c,
                   Is_Overdue__c,
                   Total_Medical_Records__c,
                   Total_Finalized_Records__c
            FROM Appointment__c
            ORDER BY CreatedDate DESC
        ];
    }

    // Get appointments for a specific doctor
    @AuraEnabled(cacheable=true)
    public static List<Appointment__c> getDoctorAppointments(Id doctorId) {
        return [
            SELECT Id, Name,
                   Appointment_Schedule_Time__c,
                   Status_Of_The_Appointment__c,
                   Urgency_Level__c,
                   Patient__r.Name
            FROM Appointment__c
            WHERE Doctor__c = :doctorId
            ORDER BY Appointment_Schedule_Time__c DESC
        ];
    }

    // Create a new appointment
    @AuraEnabled
    public static Id createAppointment(Date apptDate,
                                       String apptTime,
                                       String department,
                                       String priority,
                                       String reason,
                                       Id doctorId,
                                       Id patientId,
                                       Decimal fee) {
        Appointment__c appt = new Appointment__c();
        appt.Hospital_Department__c = department;
        appt.Urgency_Level__c = priority;
        appt.Reason_for_Visit__c = reason;
        appt.Status_Of_The_Appointment__c = 'Scheduled';
        appt.Doctor__c = doctorId;
        appt.Patient__c = patientId;
        appt.Fee_Charged__c = fee;
        insert appt;
        return appt.Id;
    }
}
