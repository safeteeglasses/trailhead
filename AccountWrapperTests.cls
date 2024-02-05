@isTest
private class AccountWrapperTests {
  @TestSetup
  static void loadTestData() {
    // GIVEN
    Account acct = new Account(Name = 'ACME', accountNumber = '12345678');
    Account acct2 = new Account(Name = 'FRESH', accountNumber = '87654321');
    insert acct;
    insert acct2;
    List<Opportunity> opps = TestFactory.generateOppsForAccount(acct.id, 1000.00, 5);
    List<Opportunity> opps2 = TestFactory.generateOppsForAccount(acct.id, 10000000.00, 5);
    insert opps;
    insert opps2;
  }
  @isTest
  static void testPositiveRoundedAveragePrice() {
    // WHEN
    Account acct = [SELECT Id FROM Account LIMIT 1];
    AccountWrapper acctWrapper = new AccountWrapper(acct);
    // THEN
    Test.startTest();
    Assert.areEqual(
    acctWrapper.getRoundedAvgPriceOfOpps(),
    5001000.00,
    'Expected to get 5001000.00');
    Test.stopTest();
  }
  @isTest
  static void testIsHighPriority(){
    
    //Not taking this out because it also works. Salesforce just doesn't like it 
    
    //List<AccountWrapper> accounts = new List<AccountWrapper>();
    //for(Account a : [SELECT ID, Name FROM ACCOUNT]){
      //accounts.add(new AccountWrapper(a));
      //  }
      
      Account lowAccount = [SELECT Id FROM Account WHERE Name = 'ACME' LIMIT 1];
      AccountWrapper lowAccountWrapper = new AccountWrapper(lowAccount);
      
      // sanity check asserting that we have opportunities before executing our tested method.
      
      List<Opportunity> sanityCheckListOfOpps = [SELECT ID, Amount FROM Opportunity];
      
      System.assert(sanityCheckListOfOpps.size() > 0, 'You need an opportunity to continue');
      for(Opportunity opp : sanityCheckListOfOpps){
        opp.Amount = 1000000;
      }
      update sanityCheckListOfOpps;
      Test.startTest();
      
      Assert.areEqual(lowAccountWrapper.isHighPriority(), true, 'Expected isHighPriority method to return True');
      
      Test.stopTest();
    }
    
    @IsTest
    static void testNegativeAccountWrapperAvgPriceOfOpps() {
      // GIVEN
      Account acct = [SELECT Id FROM Account LIMIT 1];
      List<Opportunity> opps = [
      SELECT Amount
      FROM Opportunity
      WHERE accountId = :acct.Id
      ];
      for (Opportunity o : opps) {
        o.Amount = 0;
      }
      update opps;
      AccountWrapper acctWrapper = new AccountWrapper(acct);
      // WHEN
      try {
        Test.startTest();
        acctWrapper.getRoundedAvgPriceOfOpps();
        Test.stopTest();
        Assert.fail('An exception should have been thrown');
      } catch (AccountWrapper.AWException e) {
        // THEN
        Assert.isTrue(
        e.getMessage().equalsIgnoreCase('no won opportunities'),
        'Exception message does not match: ' + e.getMessage()
        );
      }
    }
  }