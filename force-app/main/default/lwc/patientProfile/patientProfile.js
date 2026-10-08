import { LightningElement, wire ,api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import DOB_FIELD from '@salesforce/schema/Contact.Date_of_Birth__c';
import BLOOD_FIELD from '@salesforce/schema/Contact.Patient_Blood_Type__c';

const fields = [NAME_FIELD, DOB_FIELD, BLOOD_FIELD];

export default class PatientProfile extends LightningElement {
   @api recordId; // passed from page
    patient;

    @wire(getRecord, { recordId: '$recordId', fields })
wiredPatient({ error, data }) {
    if (data) {
        this.patient = {
            Name: data.fields.Name ? data.fields.Name.value : '',
            Date_of_Birth__c: data.fields.Date_of_Birth__c ? data.fields.Date_of_Birth__c.value : '',
            Patient_Blood_Type__c: data.fields.Patient_Blood_Type__c ? data.fields.Patient_Blood_Type__c.value : ''
        };
    } else if (error) {
        console.error(error);
    }
}

}
