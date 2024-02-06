trigger AccountAddressTrigger on Account (before insert, before update) {
    
   for(Account accnt : trigger.new){
        if(accnt.Match_Billing_Address__c && accnt.BillingPostalCode != NULL)
            accnt.ShippingPostalCode = accnt.BillingPostalCode;
    }
}