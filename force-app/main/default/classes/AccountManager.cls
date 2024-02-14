@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
       // grab the Account from between of the URL
        String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');

        Account result =  [SELECT ID, Name, (SELECT ID, FirstName, LastName FROM Contacts) FROM Account WHERE Id = :accountId];
        System.debug('#### accountId ' + accountId + '###### result ' +result + 'contacts ' + result.Contacts );
        return result;
    }
}