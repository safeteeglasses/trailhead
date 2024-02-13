@isTest
private class ParkLocatorTest {
    @isTest static void testCallout(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        String country = 'United States';
        String[] results = ParkLocator.country(country);
        System.assertEquals(new String[]{'park1'}, results);
    }
}