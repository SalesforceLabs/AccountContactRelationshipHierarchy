({
	hideChildren : function(component, event, helper) {
        $A.util.toggleClass(component.find('contactChildren'), 'hideTheKids');
	},
    
    openContact : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get('v.contact').Contact.Id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
})