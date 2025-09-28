public with sharing class GooglePlacesDTO {
  public class AutocompletePrediction {
    public String description;
    public String place_id;
  }

  public class AutocompleteResponse {
    public AutocompletePrediction[] predictions;
    public String status;
  }

  public class AddressComponent {
    public String long_name;
    public String[] types;
  }

  public class Geometry {
    public Location location;
  }

  public class Location {
    public Double lat;
    public Double lng;
  }

  public class PlaceDetailsResult {
    public AddressComponent[] address_components;
    public Geometry geometry;
    public String formatted_address;
  }

  public class PlaceDetailsResponse {
    public PlaceDetailsResult result;
    public String status;
  }

  public class AddressSuggestion {
    @AuraEnabled
    public String road;
    @AuraEnabled
    public String city;
    @AuraEnabled
    public String country;
    @AuraEnabled
    public String postcode;
    @AuraEnabled
    public String streetNumber;
    @AuraEnabled
    public String formattedAddress;
  }
}