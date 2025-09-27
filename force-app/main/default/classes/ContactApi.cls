@RestResource(urlMapping='/owtvn/contactsApi/*')
global class ContactApi {
  @HttpPost
  global static Contact createContact() {
    RestRequest req = RestContext.request;
    String reqBody = req.requestBody.toString();
    Contact c = (Contact) JSON.deserialize(reqBody, Contact.class);
    insert c;
    return c;
  }

  @HttpGet
  global static Contact getContactById() {
    RestRequest req = RestContext.request;
    Id contactId = (Id) req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    Contact c = ContactSelector.getContactById(contactId);
    return c;
  }

  @HttpPatch
  global static Contact updateContact() {
    RestRequest req = RestContext.request;
    Id contactId = (Id) req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    Contact updates = (Contact) JSON.deserialize(req.requestBody.toString(), Contact.class);
    updates.Id = contactId;
    update updates;

    return ContactSelector.getContactById(contactId);
  }

  @HttpDelete
  global static void deleteContact() {
    RestRequest req = RestContext.request;
    Id contactId = (Id) req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    Contact c = ContactSelector.getContactById(contactId);

    delete c;
  }
}