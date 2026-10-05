global class DoctorAppointmentReconciliationBatch implements Database.Batchable<SObject>, Database.Stateful {

    global Integer correctedCount = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // TODO: add a WHERE clause to filter records
        return Database.getQueryLocator('SELECT Id, Total_Appointments_Completed__c ' +
            'FROM Contact WHERE Is_Doctor__c = TRUE');
    }

    global void execute(Database.BatchableContext bc, List<Contact> scope) {
        Set<Id> doctorIds = new Set<Id>();
            for(Contact c : scope) {
                doctorIds.add(c.Id);
        }
    
        Map<Id, Integer> doctorCounts = new Map<Id, Integer>();
        for(AggregateResult ar : [
            SELECT Doctor__c dId, COUNT(Id) cnt
            FROM Appointment__c
            WHERE Doctor__c IN :doctorIds
            AND Status_Of_The_Appointment__c = 'Completed'
            GROUP BY Doctor__c
        ]) {
            doctorCounts.put((Id)ar.get('dId'), (Integer)ar.get('cnt'));
        }
        List<Contact> toUpdate = new List<Contact>();
        for(Contact c : scope) {
            Integer newCount = doctorCounts.get(c.Id);
            if(newCount == null) newCount = 0;

            if(c.Total_Appointments_Completed__c != newCount) {
                c.Total_Appointments_Completed__c = newCount;
                toUpdate.add(c);
                correctedCount++;
            }
        }

        if(!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
    global void finish(Database.BatchableContext bc) {
        System.debug('Doctor counters reconciled. Corrected records: ' + correctedCount);

    }
}
