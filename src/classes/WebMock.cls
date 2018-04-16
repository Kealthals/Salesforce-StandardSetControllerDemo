global class WebMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{  "query" : "SELECT Name, Site, BillingState, Phone, toLabel(Type), Owner.Alias, CreatedDate, Id, RecordTypeId, LastModifiedDate, SystemModstamp, Owner.Id, OwnerId FROM Account ORDER BY CreatedDate DESC NULLS LAST, Id ASC NULLS FIRST"}');
        res.setStatusCode(200);
        return res;
    }
}