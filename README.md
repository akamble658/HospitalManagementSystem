🏥 Hospital Management System (Salesforce Project)
Overview
This project is a Salesforce Admin hands‑on implementation of a Hospital Management System.
It was designed to simulate a real‑world healthcare CRM scenario, covering data modeling, automation, security, and user experience inside Salesforce.

🚀 Features Implemented
Phase 1 – Data Model
Created Appointment__c custom object with auto‑number naming (APT-0001).

Created Medical_Record__c custom object with auto‑number naming (MR-0001).

Added custom fields for appointment details (Date, Time, Status, Priority, Reason, Department, Consultation Fee, Follow‑Up flag).

Added medical record fields (Diagnosis, Prescription, Blood Pressure, Temperature, Weight, Follow‑Up Date, Status).

Extended Contact object with Patient fields (Blood Type, Date of Birth, Patient ID).

Phase 2 – Relationships
Lookup from Appointment → Doctor (Contact).

Lookup from Appointment → Patient (Contact).

Master‑Detail from Medical Record → Appointment (with roll‑up support).

Phase 3 – Formulas & Roll‑Ups
Formula field: Days Since Appointment.

Formula checkbox: Is Overdue.

Formula text: Appointment Summary (e.g., “Scheduled – High Priority”).

Roll‑Up Summary fields: Total Medical Records, Total Finalized Records.

Phase 4 – Record Types & Layouts
Record Types: In‑Person Visit and Telemedicine.

Separate Page Layouts mapped to each Record Type.

Phase 5 – Profiles & Field Security
Custom Profiles: HMS Doctor and HMS Receptionist.

Field‑Level Security: Consultation Fee hidden from Doctors, visible to Receptionists/Admins.

Phase 6 – Sharing & Security
OWD: Appointments = Private, Medical Records = Controlled by Parent, Contacts = Private.

Role Hierarchy: Chief Medical Officer → Department Head → Doctor/Receptionist.

Public Groups: All Doctors, Emergency Team.

Criteria‑Based Sharing Rules:

High Priority → shared with Emergency Team (Read/Write).

Non‑Cancelled → shared with All Doctors (Read Only).

Phase 7 – Data Quality
Matching Rule: Detect duplicate patients (First Name + Last Name + DOB).

Duplicate Rule: Warn on create, block on edit.

Validation Rules:

No past scheduling on create.

Completed requires a date.

High Priority requires a reason.

Cancelled cannot be reopened.

Phase 8 – Screen Flow
Built guided Book Appointment Flow launched from Patient Contact page.

Collects appointment details, creates Appointment record, updates Patient’s Last Appointment Date.

Phase 9 – Record‑Triggered Flows
Before‑Save Flow: Auto‑set Priority = High for Cardiology/Neurology.

After‑Save Flow: Create follow‑up Task for Doctor when Appointment marked Completed.

After‑Save Flow: Copy Patient Blood Type into Appointment.

🛠️ Tech Stack
Salesforce Developer Edition / Sandbox

Custom Objects, Fields, Relationships

Record Types & Page Layouts

Profiles & Field‑Level Security

OWD, Role Hierarchy, Sharing Rules

Validation Rules, Duplicate Rules

Screen Flows & Record‑Triggered Flows

📌 Purpose
This project demonstrates end‑to‑end Salesforce Admin capabilities in designing a healthcare CRM system.
It covers data modeling, automation, security, and user experience customization — all without relying on standard healthcare objects.
