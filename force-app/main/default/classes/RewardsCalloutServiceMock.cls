@IsTest
global with sharing class RewardsCalloutServiceMock implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest req) {
    String jsonString = '{"strict":true,"value":{"message":"Success"}}';
    HttpResponse res = new HttpResponse();

    res.setHeader('Content-Type', 'application/json');
    res.setBody(jsonString);
    res.setStatusCode(HttpStatusConstant.OK);
    return res;
  }
}