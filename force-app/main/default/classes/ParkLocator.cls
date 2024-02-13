public class ParkLocator {
    
    public static String[] country(String location) {
        ParkService.ParksImplPort parkLocations = 
            new ParkService.ParksImplPort();
        return parkLocations.byCountry(location);
    }
}