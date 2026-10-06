import { LightningElement, wire } from 'lwc';
import getAppointments from '@salesforce/apex/AppointmentController.getAppointments';

export default class AppointmentList extends LightningElement {
    appointments;
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Date', fieldName: 'Appointment_Date__c', type: 'date' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Priority', fieldName: 'Priority__c' },
        { label: 'Doctor', fieldName: 'Doctor__r.Name' },
        { label: 'Patient', fieldName: 'Patient__r.Name' }
    ];

    @wire(getAppointments)
    wiredAppointments({ data }) {
        if (data) this.appointments = data;
    }
}
