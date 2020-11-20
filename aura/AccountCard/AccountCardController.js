({
	openAccount : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get('v.account').Account.Id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
})