import { LightningElement } from 'lwc';

export default class DemoCard extends LightningElement {
  patient = {
    name: 'Marie Dupont',
    dob: '12/06/1980',
    gender: 'F',
    address: '12 Rue de la Santé, Paris',
    phone: '+33 1 23 45 67 89',
    avatarEmoji: '👩‍⚕️',
    contactName: 'Dr. Martin',
    contactPhone: '+33 1 98 76 54 32',
    // richer appointment dataset matching SLDS card layout
    appointments: [
      {
        id: 'a1',
        title: 'Consultation générale',
        provider: 'Dr. Martin',
        providerInitials: 'DM',
        location: 'GHOL - Bureau 12',
        date: '10 Oct 2025',
        time: '09:30',
        status: 'Confirmé',
        statusClass: 'slds-pill slds-pill_brand',
      },
      {
        id: 'a2',
        title: 'Imagerie - Radiographie',
        provider: 'Imagerie GHOL',
        providerInitials: 'IG',
        location: 'Imagerie - Rez-de-chaussée',
        date: '15 Oct 2025',
        time: '11:00',
        status: 'Planifié',
        statusClass: 'slds-pill slds-pill_outline-brand',
      },
    ],
  };

  get hasAppointments() {
    return Array.isArray(this.patient.appointments) && this.patient.appointments.length > 0;
  }

  get patientInitials() {
    const parts = this.patient.name.split(' ');
    return parts
      .map((p) => p[0])
      .slice(0, 2)
      .join('')
      .toUpperCase();
  }
}
