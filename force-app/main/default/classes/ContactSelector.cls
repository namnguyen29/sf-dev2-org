global inherited sharing class ContactSelector {
  global static List<Contact> getContacts() {
    return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact];
  }

  global static Contact getContactById(Id contactId) {
    return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
  }
}