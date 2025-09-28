@IsTest
public with sharing class ReportSelectorTest {
  @IsTest
  static void testHeapOverflow() {
    List<Account> accs = new List<Account>();
    for (Integer i = 0; i < 10000; i++) {
      accs.add(new Account(Name = 'Acc ' + i, Description = 'x'.repeat(1000)));
    }
    insert accs;

    List<Account> result = [SELECT Id, Name, Description FROM Account];
    System.assertEquals(10000, result.size(), 'do something');
  }

  @IsTest(seeAllData=true)
  public static void testLogReport() {
    Account acc = new Account(Name = 'Test Account');
    insert acc;

    Account[] accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test%'];
    delete accounts;

    Account[] testAccs = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test%'];
    System.assertEquals(0, testAccs.size(), 'Test accounts should be deleted');
  }
}