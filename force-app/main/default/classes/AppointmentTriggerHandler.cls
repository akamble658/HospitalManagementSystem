public with sharing class AppointmentTriggerHandler {
    public static void ConsultationFeesAsPerDepartment(List <Appointment__c>newrec) {

        for(Appointment__c app : newrec){
            if(app.Hospital_Department__c != null){

                if(app.Hospital_Department__c == 'Cardiology'){
                    app.Fee_Charged__c = 1500;
                }
                else if(app.Hospital_Department__c == 'Neurology'){
                    app.Fee_Charged__c = 1500;
                }
                else if(app.Hospital_Department__c == 'Orthopedics'){
                    app.Fee_Charged__c = 1000;
                }
                else if(app.Hospital_Department__c == 'Pediatrics'){
                    app.Fee_Charged__c = 800;
                }
                else{
                    app.Fee_Charged__c = 500;
                }

            }
        }
    }


    public static void BlockDeleteionOfAppointment(List <Appointment__c> oldrec){

        Set<Id> appointmentId = new Set<Id>();
        for(Appointment__c acc : oldrec){
                appointmentId.add(acc.Id);
            }
        Set<Id> medrec = new Set<Id>();
        List<Medical_Record__c> medrecord =[Select Id, Appointment__c from Medical_Record__c
                                where Status_Of_The_Record__c = 'Finalized' AND Appointment__c IN:appointmentId];
             for(Medical_Record__c mc : medrecord){
                medrec.add(mc.Appointment__c);
                }
        for(Appointment__c ap : oldrec){
            if(medrec.contains(ap.Id)){
                ap.AddError('Appointment cannot Be Deleted As Medical Report in Finalized State');
            }
        }
    }

    public static void UpdateCompletedAppointment(List<Appointment__c> newrec, Map<Id,Appointment__c> oldmap){

            Set<Id> doctorsId = new Set<Id>();
        if(newrec != null){    
            for(Appointment__c ap : newrec)
                if(ap.Doctor__c != null && ap.Status_Of_The_Appointment__c == 'Completed'
                    && oldmap.get(ap.Id).Status_Of_The_Appointment__c != 'Completed'){
                        doctorsId.add(ap.Doctor__c);
                }
        }

        if(doctorsId.isEmpty()){
            return;
        }

        List<AggregateResult> arlist =[SELECT Doctor__c doctorId, COUNT(Id) total
                                        FROM Appointment__c
                                        WHERE Doctor__c IN :doctorsId
                                        AND Status_Of_The_Appointment__c = 'Completed'
                                        GROUP BY Doctor__c];
        Map<Id,Integer> doctorlist = new Map<Id, Integer>();
        for(AggregateResult ar : arlist){
            doctorlist.put((Id)ar.get('doctorId'),(Integer)ar.get('total'));
        }

        List<Contact> conlist =[ SELECT Id, Total_Appointments_Completed__c
                                 FROM Contact
                                 WHERE Id IN :doctorsId];
             for(Contact con : conlist)
            {
                con.Total_Appointments_Completed__c = doctorlist.get(con.Id);
            }

            if(!conlist.isEmpty())
            {
                update conlist;
            }
    }

    public static void createAudit(List<Appointment__c> oldrec){

        List<Appointment_Audit__c> auditList = new List<Appointment_Audit__c>();
        for(Appointment__c app : oldrec){
            Appointment_Audit__c ap = new Appointment_Audit__c();
            ap.Appointment__c = app.Id;
            ap.Patient_Name__c = app.Patient__c;
            ap.Restored_By__c = UserInfo.getName();
            ap.Restored_Date__c =System.now();
            auditList.add(ap);
        }
        if(!auditList.isEmpty()){
            update auditList;
        }
    }
    
    public static void addDoctorToEmergencyGroup(List<Appointment__c> newrec){
     Set<Id> doctorIds = new Set<Id>();

        for(Appointment__c ap : Trigger.new) {
         if(ap.Priority__c == 'High' && ap.Doctor__c != null) {
            doctorIds.add(ap.Doctor__c);
            }
        }

        if(!doctorIds.isEmpty()) {
        EmergencyTeamHandler.addDoctorsToEmergencyTeam(doctorIds);
        }
    }
}