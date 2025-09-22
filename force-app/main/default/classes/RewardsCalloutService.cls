public class RewardsCalloutService {
  public static Integer submitUsersForRewardCallout(String jsonBody) {
    HttpRequest req = new HttpRequest();
    String endpoint = 'callout:IntegrationSB__BalancedLiving/rewards';
    req.setMethod('POST');
    req.setEndpoint(endpoint);
    req.setHeader('Content-Type', 'application/json');
    req.setBody(jsonBody);

    HttpResponse res = new Http().send(req);

    System.debug('checkk jsonBody::' + jsonBody);
    System.debug('checkk endpoint::' + endpoint);
    System.debug('checkk res::' + res.getBody());
    System.debug('checkk stt code::' + res.getStatusCode());

    if (res.getStatusCode() == HttpStatusConstant.CREATED) {
      return HttpStatusConstant.OK;
    }

    return HttpStatusConstant.BAD_REQUEST;
  }
}