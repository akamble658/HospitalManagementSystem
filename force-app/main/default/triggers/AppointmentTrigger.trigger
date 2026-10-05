trigger AppointmentTrigger on Appointment__c (before insert, before update, before delete, after update, after undelete) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    AppointmentTriggerHandler.ConsultationFeesAsPerDepartment(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isDelete){
        AppointmentTriggerHandler.BlockDeleteionOfAppointment(Trigger.old);
    }

    if(Trigger.isafter && Trigger.isupdate){
        AppointmentTriggerHandler.UpdateCompletedAppointment(Trigger.new, Trigger.oldmap);
    }

    if(Trigger.isafter && Trigger.isUndelete){
        AppointmentTriggerHandler.createAudit(Trigger.old);
    }

}