trigger TransactionItemTrigger on TransactionItem__c (after insert) {
    //Trigger is created whenever the transaction item count equals transaction related count it will fire
    List<TransactionItem__c> TransLst = new List<TransactionItem__c>();
    List<Transaction__c> relatedTransCountLst = new List<Transaction__c>();
    relatedTransCountLst=[Select related_transaction_count__c from Transaction__c];
    List<Transaction__c> rollupTransCountLst = new List<Transaction__c>();
    rollupTransCountLst=[Select total_transaction_count__c from transaction__c];
    Map<Id,Transaction__c> rollMap = new Map<Id,Transaction__c>(rollupTransCountLst);
    Map<Id,Transaction__c> relatedMap = new Map<Id,Transaction__c>(relatedTransCountLst);
    //Logic whenever total transaction count is equal to related transaction count field in SF it will the function 
    if(relatedMap.keySet().containsAll(rollMap.keySet())){
        System.debug('Lists are Equal');
        TransLst = [Select Id,Item_cost__c,Name from TransactionItem__c];
        TransactionCallout.getTransactionDetails(TransLst);
    }
    else{
        System.debug('Lists do not match');
    }
 }