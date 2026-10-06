import { LightningElement, wire } from 'lwc';
import getDoctorAppointments from '@salesforce/apex/AppointmentController.getDoctorAppointments';

export default class DoctorDashboard extends LightningElement {
    recordId; // Doctor Contact Id
    appointments;
    columns = [
        { label: 'Appointment', fieldName: 'Name' },
        { label: 'Date', fieldName: 'Appointment_Date__c', type: 'date' },
        { label: 'Status', fieldName: 'Status__c' },
        { label: 'Patient', fieldName: 'Patient__r.Name' }
    ];

    @wire(getDoctorAppointments, { doctorId: '$recordId' })
    wiredAppointments({ data }) {
        if (data) this.appointments = data;
    }
}
