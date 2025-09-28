public with sharing class GooglePlacesService {
  public static GooglePlacesDTO.AddressSuggestion[] getAutocomplete(String query) {
    String apiKey = [SELECT Value__c FROM Google_Setting__mdt LIMIT 1].Value__c;
    String url =
      'callout:GoogleAutocompleteAPI' +
      '?key=' +
      apiKey +
      '&input=' +
      EncodingUtil.urlEncode(query, 'UTF-8');

    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('GET');
    req.setTimeout(5000);

    Http http = new Http();
    HttpResponse res;

    try {
      res = http.send(req);
    } catch (Exception e) {
      throw new AuraHandledException('Failed to call Google Places API: ' + e.getMessage());
    }

    if (res.getStatusCode() != HttpStatusConstant.OK) {
      throw new AuraHandledException('Google Places API error: ' + res.getStatus());
    }

    GooglePlacesDTO.AutocompleteResponse response = (GooglePlacesDTO.AutocompleteResponse) JSON.deserialize(
      res.getBody(),
      GooglePlacesDTO.AutocompleteResponse.class
    );

    List<GooglePlacesDTO.AddressSuggestion> suggestions = new List<GooglePlacesDTO.AddressSuggestion>();
    if (response != null && response.predictions != null) {
      for (GooglePlacesDTO.AutocompletePrediction prediction : response.predictions) {
        GooglePlacesDTO.AddressSuggestion suggestion = new GooglePlacesDTO.AddressSuggestion();
        suggestion.formattedAddress = prediction.description;
        suggestions.add(suggestion);
      }
    }

    return suggestions;
  }
}