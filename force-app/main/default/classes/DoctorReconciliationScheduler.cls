global class DoctorReconciliationScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        DoctorAppointmentReconciliationBatch batch = new DoctorAppointmentReconciliationBatch();
        Database.executeBatch(batch, 200);
    }
}
