Opportunity opp = new Opportunity(
  Name = 'Test Opportunity',
  StageName = 'Prospecting',
  CloseDate = Date.today().addDays(30)
);
ReportSelector.logReport();