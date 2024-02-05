@IsTest
private class ExternalSearchTests {
    @IsTest
    static void testPositiveMocking() {
        // GIVEN
        HTTPMockFactory mock = new HTTPMockFactory(
        200,
        'OK',
        'I found it!',
        new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        // WHEN
        Test.startTest();
        String result = ExternalSearch.googleIt('epic search');
        Test.stopTest();
        // THEN
        Assert.areEqual('I found it!', result, 'Expected to receive mock response');
    }

    @isTest 
    static void testNegativeMocking() {
        Integer statusCode = 500;
        String result;
        HTTPMockFactory mock = new HTTPMockFactory(
            statusCode,
            'Not Ok',
            'Did not receive a 200 status code: ',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        try {
            result = ExternalSearch.googleIt('!');
        } catch (ExternalSearch.ExternalSearchException e) {
            System.assert(e.getMessage().equalsIgnoreCase('Did not receive a 200 status code: 500'));
        }
        Test.stopTest();
    }
}