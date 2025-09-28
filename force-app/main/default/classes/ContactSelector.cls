global inherited sharing class ContactSelector {
  global static List<Contact> getContacts() {
    Schema.FieldSetMember[] fsm = Schema.SObjectType.Contact.FieldSets.PrimaryContact.getFields();

    String[] fieldNames = new List<String>();

    for (Schema.FieldSetMember f : fsm) {
      fieldNames.add(f.getFieldPath());
    }

    String query = 'SELECT Id, ' + String.join(fieldNames, ',') + ' FROM Contact LIMIT 10';
    List<Contact> contacts = Database.query(query);
    return contacts;
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