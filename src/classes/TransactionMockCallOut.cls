@isTest
global class TransactionMockCallOut implements HttpCallOutMock {
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"ItemCost": "200.00","ItemName": "TI-01"}');
        response.setStatusCode(200);
        return response; 
    }
}
