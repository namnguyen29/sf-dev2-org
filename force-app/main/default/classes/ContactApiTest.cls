@IsTest
public with sharing class ContactApiTest {
  @TestSetup
  static void setupTestData() {
    Contact testContact = new Contact(
      FirstName = 'Test',
      LastName = 'Contact',
      Email = 'test@example.com',
      Phone = '1234567890'
    );
    insert testContact;
  }

  @IsTest
  static void testCreateContact() {
    Contact newContact = new Contact(
      FirstName = 'John',
      LastName = 'Doe',
      Email = 'john.doe@example.com',
      Phone = '555-1234'
    );
    String requestBody = JSON.serialize(newContact);

    RestRequest req = new RestRequest();
    req.requestBody = Blob.valueOf(requestBody);
    RestContext.request = req;

    Test.startTest();
    Contact result = ContactApi.createContact();
    Test.stopTest();

    System.assertNotEquals(null, result.Id, 'Contact should be created with an ID');
    System.assertEquals('John', result.FirstName, 'First name should match');
    System.assertEquals('Doe', result.LastName, 'Last name should match');
    System.assertEquals('john.doe@example.com', result.Email, 'Email should match');
    System.assertEquals('555-1234', result.Phone, 'Phone should match');
  }

  @IsTest
  static void testGetContactById() {
    Contact testContact = [SELECT Id FROM Contact LIMIT 1];

    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/Contact/' + testContact.Id;
    RestContext.request = req;

    Test.startTest();
    Contact result = ContactApi.getContactById();
    Test.stopTest();

    System.assertEquals(testContact.Id, result.Id, 'Should return the correct contact');
    System.assertEquals('Test', result.FirstName, 'First name should match');
    System.assertEquals('Contact', result.LastName, 'Last name should match');
    System.assertEquals('test@example.com', result.Email, 'Email should match');
    System.assertEquals('1234567890', result.Phone, 'Phone should match');
  }

  @IsTest
  static void testUpdateContact() {
    Contact testContact = [SELECT Id FROM Contact LIMIT 1];

    Contact updateData = new Contact(
      FirstName = 'Updated',
      LastName = 'Name',
      Email = 'updated@example.com',
      Phone = '999-9999'
    );
    String requestBody = JSON.serialize(updateData);

    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/Contact/' + testContact.Id;
    req.requestBody = Blob.valueOf(requestBody);
    RestContext.request = req;

    Test.startTest();
    Contact result = ContactApi.updateContact();
    Test.stopTest();

    System.assertEquals(testContact.Id, result.Id, 'Should return the same contact ID');
    System.assertEquals('Updated', result.FirstName, 'First name should be updated');
    System.assertEquals('Name', result.LastName, 'Last name should be updated');
    System.assertEquals('updated@example.com', result.Email, 'Email should be updated');
    System.assertEquals('999-9999', result.Phone, 'Phone should be updated');
  }

  @IsTest
  static void testDeleteContact() {
    Contact testContact = [SELECT Id FROM Contact LIMIT 1];
    Id contactId = testContact.Id;

    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/Contact/' + contactId;
    RestContext.request = req;

    System.assertEquals(1, [SELECT COUNT() FROM Contact WHERE Id = :contactId], 'Contact should exist before deletion');

    Test.startTest();
    ContactApi.deleteContact();
    Test.stopTest();

    System.assertEquals(0, [SELECT COUNT() FROM Contact WHERE Id = :contactId], 'Contact should be deleted');
  }
}