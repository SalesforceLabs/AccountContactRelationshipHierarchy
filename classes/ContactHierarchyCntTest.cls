@isTest
public with sharing class ContactHierarchyCntTest {
    
    @testSetup
    static void setup() {
        Account ac = new Account(name ='Contact Hierarchy Test Account') ;
        insert ac; 
        
        Contact con = new Contact(LastName ='testCon',AccountId = ac.Id);
        insert con;  
        
        Contact con2 = new Contact(LastName ='testCon2',AccountId = ac.Id,ReportsToId = con.Id);
        insert con2;  
    }
    
    static testMethod void testgetAccount() {
        Id accid = [SELECT Id FROM Account WHERE Name = 'Contact Hierarchy Test Account'].Id;
        Account result = ContactHierarchyCnt.getAccount(accId);
        System.assertEquals('Contact Hierarchy Test Account', result.Name);
    }
    
    static testMethod void testgetContacts() {
        Id accid = [SELECT Id FROM Account WHERE Name = 'Contact Hierarchy Test Account'].Id;
        List<AccountContactRelation> result = ContactHierarchyCnt.getContacts(accId);
        System.assert(!result.isEmpty());
    }
    
    static testMethod void testhasChildren() {
        Id conId = [SELECT Id FROM Contact WHERE LastName = 'testCon'].Id;
        Id accid = [SELECT Id FROM Account WHERE Name = 'Contact Hierarchy Test Account'].Id;
        Integer result = ContactHierarchyCnt.hasChildren(conId, accId);
        System.assertEquals(1, result);
    }
    
    static testMethod void testcountAccounts() {
        Id conId = [SELECT Id FROM Contact WHERE LastName = 'testCon'].Id;
        Integer result = ContactHierarchyCnt.countAccounts(conId);
        System.assertEquals(1, result);
    }
    
    static testMethod void testgetAccounts() {
        Id conId = [SELECT Id FROM Contact WHERE LastName = 'testCon'].Id;
        List<AccountContactRelation> result = ContactHierarchyCnt.getAccounts(conId);
        System.assert(!result.isEmpty());
    }
}