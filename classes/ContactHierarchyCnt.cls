public with sharing class ContactHierarchyCnt {
    
    @AuraEnabled
    public static Account getAccount(Id accId) {
        if (Schema.sObjectType.Account.fields.Name.isAccessible() && 
            Schema.sObjectType.Account.fields.Id.isAccessible() && 
            Schema.sObjectType.User.fields.Name.isAccessible()) {
                return [SELECT Name, Owner.Name FROM Account WHERE Id = :accId];
            } else {
                return null;
            }
    }
    
    @AuraEnabled
    public static List<AccountContactRelation> getContacts(Id accId) {
        if (Schema.sObjectType.AccountContactRelation.fields.ContactId.isAccessible() && 
            Schema.sObjectType.AccountContactRelation.fields.AccountId.isAccessible() && 
            Schema.sObjectType.AccountContactRelation.fields.IsDirect.isAccessible() &&
            Schema.sObjectType.Contact.fields.Name.isAccessible() &&
            Schema.sObjectType.Contact.fields.Phone.isAccessible() &&
            Schema.sObjectType.Contact.fields.Email.isAccessible() &&
            Schema.sObjectType.Contact.fields.ReportsToId.isAccessible() &&
            Schema.sObjectType.Contact.fields.Title.isAccessible() &&
            Schema.sObjectType.Contact.fields.PhotoUrl.isAccessible()) {
                return [SELECT AccountId, ContactId, Contact.Name, Contact.Phone, Contact.Email, IsDirect, Contact.ReportsToId, Contact.Title, Contact.PhotoUrl FROM AccountContactRelation WHERE AccountId = :accId];
            } else {
                return null;
            }
    }
    
    @AuraEnabled
    public static Integer hasChildren(Id conId, Id accId) {
        if (Schema.sObjectType.Contact.fields.ReportsToId.isAccessible() &&
            Schema.sObjectType.Contact.fields.AccountId.isAccessible()) {
                return [SELECT COUNT() FROM Contact WHERE ReportsToId = :conId AND AccountId = :accId];
            } else {
                return null;
            }
    }
    
    @AuraEnabled
    public static Integer countAccounts(Id conId) {
        if (Schema.sObjectType.AccountContactRelation.fields.ContactId.isAccessible()) {
            return [SELECT count() FROM AccountContactRelation WHERE ContactId = :conId];
        } else {
            return null;
        }
    }
    
    @AuraEnabled
    public static List<AccountContactRelation> getAccounts(Id conId) {
        if (Schema.sObjectType.AccountContactRelation.fields.ContactId.isAccessible() && 
            Schema.sObjectType.AccountContactRelation.fields.AccountId.isAccessible() && 
            Schema.sObjectType.AccountContactRelation.fields.IsDirect.isAccessible() &&
            Schema.sObjectType.Account.fields.Name.isAccessible() &&
            Schema.sObjectType.User.fields.Name.isAccessible()) {
                return [SELECT AccountId,IsDirect,Account.Name,Account.Owner.Name FROM AccountContactRelation WHERE ContactId = :conId ORDER By Account.Name];
            } else {
                return null;
            }
    }
    
}