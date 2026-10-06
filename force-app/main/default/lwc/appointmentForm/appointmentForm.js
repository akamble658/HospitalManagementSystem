import { LightningElement, track } from 'lwc';
import createAppointment from '@salesforce/apex/AppointmentController.createAppointment';
import getAppointments from '@salesforce/apex/AppointmentController.getAppointments';

export default class AppointmentForm extends LightningElement {
    @track date;
    @track time;
    @track department;
    @track priority;
    @track reason;

    departmentOptions = [
        { label: 'Cardiology', value: 'Cardiology' },
        { label: 'Orthopedics', value: 'Orthopedics' },
        { label: 'General', value: 'General' },
        { label: 'Pediatrics', value: 'Pediatrics' },
        { label: 'Neurology', value: 'Neurology' }
    ];

    priorityOptions = [
        { label: 'High', value: 'High' },
        { label: 'Medium', value: 'Medium' },
        { label: 'Low', value: 'Low' }
    ];

    handleChange(event) {
        this[event.target.label.toLowerCase()] = event.target.value;
    }

    saveAppointment() {
        createAppointment({
            date: this.date,
            time: this.time,
            department: this.department,
            priority: this.priority,
            reason: this.reason
        })
        .then(() => {
            // success toast
        })
        .catch(error => {
            console.error(error);
        });
    }
}
