({
    doInit : function(component, event, helper) {
        var action = component.get('c.hasChildren');
        action.setParams({
            conId : component.get('v.contact').Contact.Id,
            accId : component.get('v.contact').AccountId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                console.log('count: ' + response.getReturnValue());
                component.set('v.conCount',response.getReturnValue());  
            } else {
                console.log('Failed with state: ' + state);   
            }
        });
        $A.enqueueAction(action);
                
        var action2 = component.get('c.countAccounts');
        action2.setParams({
            conId : component.get('v.contact').Contact.Id 
        });
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                component.set('v.accCount',response.getReturnValue());  
            } else {
                console.log('Failed with state: ' + state);   
            }
        });
        $A.enqueueAction(action2);
        
        var action3 = component.get('c.getAccounts');
        action3.setParams({
            conId : component.get('v.contact').Contact.Id 
        });
        action3.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                component.set('v.accounts',response.getReturnValue());  
            } else {
                console.log('Failed with state: ' + state);   
            }
        });
        $A.enqueueAction(action3);
    },
    
    hideChildren : function(component, event, helper) {
        var thisChild = event.getSource().get("v.value");
        $A.util.toggleClass(component.find('wank'), 'noShow');
    }
})