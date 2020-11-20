({
	getAccountDetails : function(component, event) {
		var action = component.get('c.getAccount');
        action.setParams({
            accId : component.get('v.accountId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                component.set('v.account',response.getReturnValue());
            } else {
                console.log('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);
	}
})