public class DoctorReconciliationEmailJob implements Queueable {
    private Integer correctedCount;

    // Constructor to accept the count from the batch
    public DoctorReconciliationEmailJob(Integer correctedCount) {
        this.correctedCount = correctedCount;
    }

    public void execute(QueueableContext qc) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { 'www.akamble658@gmail.com' }); // fixed Admin email
        mail.setSubject('Nightly Doctor Reconciliation Summary');
        mail.setPlainTextBody(
            'The nightly reconciliation job has completed.' + 
            '\nNumber of Doctor records corrected: ' + correctedCount
        );

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
