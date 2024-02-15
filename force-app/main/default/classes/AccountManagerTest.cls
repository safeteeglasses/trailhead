@isTest 
private class AccountManagerTest {
    @isTest 
    static void testGetAccount() {
        Id accountId = createTestAccount();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
        'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'+ accountId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test account', thisAccount.Name);
    }
    
    // Helper method
    static Id createTestAccount() {
        // Create test record
        Account accountTest = new Account(
        Name='Test account',
        AccountNumber='12345678'
        );
        insert accountTest;
        Contact contactTest = new Contact(
        AccountId = accountTest.Id,
        FirstName = 'Leeroy',
        LastName = 'Jenkins'
        );
        insert contactTest;
        return accountTest.Id;
    }          
}