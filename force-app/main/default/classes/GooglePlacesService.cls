public with sharing class GooglePlacesService {
  public static List<GooglePlacesMapper.AddressSuggestion> getAutocomplete(String query) {
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

    GooglePlacesMapper.AutocompleteResponse response = (GooglePlacesMapper.AutocompleteResponse) JSON.deserialize(
      res.getBody(),
      GooglePlacesMapper.AutocompleteResponse.class
    );

    List<GooglePlacesMapper.AddressSuggestion> suggestions = new List<GooglePlacesMapper.AddressSuggestion>();
    if (response != null && response.predictions != null) {
      for (GooglePlacesMapper.AutocompletePrediction prediction : response.predictions) {
        GooglePlacesMapper.AddressSuggestion suggestion = new GooglePlacesMapper.AddressSuggestion();
        suggestion.formattedAddress = prediction.description;
        suggestions.add(suggestion);
      }
    }

    System.debug('Suggestions--' + suggestions);
    return suggestions;
  }
}