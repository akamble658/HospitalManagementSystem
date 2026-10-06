import { LightningElement, wire } from 'lwc';
import getMedicalRecords from '@salesforce/apex/MedicalRecordController.getMedicalRecords';

export default class MedicalRecordList extends LightningElement {
    recordId; // Appointment Id
    records;
    columns = [
        { label: 'Diagnosis', fieldName: 'Diagnosis__c' },
        { label: 'Prescription', fieldName: 'Prescription__c' },
        { label: 'Blood Pressure', fieldName: 'Blood_Pressure__c' },
        { label: 'Temperature', fieldName: 'Temperature__c', type: 'number' },
        { label: 'Weight', fieldName: 'Weight__c', type: 'number' },
        { label: 'Follow-Up Date', fieldName: 'Date_for_follow_up__c', type: 'date' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getMedicalRecords, { appointmentId: '$recordId' })
    wiredRecords({ data }) {
        if (data) this.records = data;
    }
}
