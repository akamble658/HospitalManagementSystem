import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createMedicalRecord from '@salesforce/apex/MedicalRecordController.createMedicalRecord';

export default class MedicalRecordForm extends LightningElement {
    @api appointmentId; // passed from parent Appointment
    @track diagnosis;
    @track prescription;
    @track bp;
    @track temperature;
    @track weight;
    @track followUpDate;
    @track status = 'Draft';

    statusOptions = [
        { label: 'Draft', value: 'Draft' },
        { label: 'Finalized', value: 'Finalized' },
        { label: 'Archived', value: 'Archived' }
    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    saveRecord() {
        createMedicalRecord({
            appointmentId: this.appointmentId,
            diagnosis: this.diagnosis,
            prescription: this.prescription,
            bp: this.bp,
            temperature: this.temperature,
            weight: this.weight,
            followUpDate: this.followUpDate,
            status: this.status
        })
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Medical record saved successfully',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            console.error(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Failed to save medical record',
                    variant: 'error'
                })
            );
        });
    }
}
