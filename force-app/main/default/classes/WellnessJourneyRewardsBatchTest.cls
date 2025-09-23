@IsTest
public with sharing class WellnessJourneyRewardsBatchTest {
  @TestSetup
  static void setupData() {
    User u = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
    List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();

    Date today = Date.today();
    Integer currentMonth = today.month();
    Integer currentYear = today.year();
    Integer prevQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
    if (prevQuarterStartMonth <= 0) {
      prevQuarterStartMonth += 12;
      currentYear--;
    }
    Date startDate = Date.newInstance(currentYear, prevQuarterStartMonth, 1);

    for (Integer i = 0; i < 12; i++) {
      journeys.add(
        new Wellness_Journey__c(
          Name = 'Journey ' + i,
          Status__c = 'Complete',
          Completion_Date__c = startDate.addDays(i),
          OwnerId = u.Id
        )
      );
    }

    insert journeys;
  }

  @IsTest
  public static void testRewardBatch() {
    Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

    Test.startTest();
    WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
    Database.executeBatch(batch, 50);
    Test.stopTest();

    Integer journeyCount = [SELECT COUNT() FROM Wellness_Journey__c];
    System.assertEquals(12, journeyCount);
  }
}