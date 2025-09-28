global inherited sharing class ContactSelector {
  global static List<Contact> getContacts() {
    return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact];
  }

  global static Contact getContactById(Id contactId) {
    return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
  }

  global static List<Contact> findContactsByEmail(String email) {
    return [
      SELECT Id, FirstName, LastName, Email, Phone
      FROM Contact
      WHERE Email = :email
    ];
  }

  global static List<Contact> findContactsByName(String name) {
    return [
      SELECT Id, FirstName, LastName, Email, Phone
      FROM Contact
      WHERE FirstName LIKE :('%' + name + '%') OR LastName LIKE :('%' + name + '%')
    ];
  }
}