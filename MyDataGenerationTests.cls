@IsTest
private class MyDataGenerationTests {
  @TestSetup
  static void loadOtherAccountDataFromStaticResourceFile(){
    //GIVEN
    List<sObject> accounts = Test.loadData(Account.SObjectType, 'otherAccountData');
  }
  @isTest
  static void testLoadOtherAccountsFromStaticResource() {
    // WHEN
    List<Account> accts = [SELECT ID FROM Account];
    // THEN
    Assert.isTrue(accts.size() == 15, 'Expecting 15 accounts from CSV file but only found' + accts.size());
  }
}