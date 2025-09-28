public with sharing class ReportSelector {
  public static void logReport(SObject acc) {
    System.debug('Account found: ' + (String) acc.get('Name'));
  }
}