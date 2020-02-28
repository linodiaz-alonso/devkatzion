public class TransactionCallout {
    public static String jsTransString;
    // Method to get the Transaction details parent object and convert it into JSON form
    public static void getTransactionDetails(List<sObject> transLst){
        List<sObject> transrelatedLst = new List<sObject>();
        transrelatedLst = [Select Id,Name,total_cost__c,transaction_count__c,total_transaction_count__c,
                           related_transaction_count__c from transaction__c where Id IN :transLst];
        Map<Id,sObject> transrelatedLstMap = new Map<Id,sObject>(transrelatedLst);
        jsTransString = JSON.serialize(transrelatedLstMap);
    }
    // Call out to a dummy service as the Rest Endpoint are not given
    public static HttpResponse transactionPostcallOut(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        //Commenting the endpoint as no End point was given this is a assumed Endpoint
        //req.setEndpoint('https://curious-shark-jtkh68-dev-ed.lightning.force.com/services/apexrest/transaction');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody(jsTransString);
        HttpResponse resp = http.send(req);
        //If First Callout Successful then call the Rest api call
        if(resp.getStatusCode()==200){
            System.debug('First Call is Successful');
            //A Rest request
            jsTransString = jsTransString + '{"TotalCost": "100.00","TotalDiscount": "10.00","TransactionDate": "2020-01-20","TotalCount": "3",}}';
            req.setBody(jsTransString);
        }
        else{
            System.debug('The status code returned was not expected: ' +
            resp.getStatusCode() + ' ' + resp.getStatus());
        }
        return resp;
    }
}