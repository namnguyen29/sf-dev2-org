@IsTest
public with sharing class RewardsCalloutServiceTest {
  @IsTest
  static void testSubmitUsersForRewardCallout() {
    Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

    List<Map<String, Object>> usersList = new List<Map<String, Object>>();
    Map<String, Object> userObj = new Map<String, Object>{
      'userId' => '005XXXXXXXXXXXX',
      'fullName' => 'Test User',
      'email' => 'testuser@example.com',
      'username' => 'testuser'
    };
    usersList.add(userObj);
    String jsonBody = JSON.serialize(usersList);

    Test.startTest();
    Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
    Test.stopTest();

    System.assertNotEquals(HttpStatusConstant.OK, responseCode, 'The response code should not be OK');
  }
}