({
    doInit : function(component, event, helper) {
        helper.getAccountDetails(component,helper);
        
        var action = component.get('c.getContacts');
        action.setParams({
            accId : component.get('v.accountId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                console.log(response.getReturnValue());
                component.set('v.contacts',response.getReturnValue());
                console.log(component.get('v.contacts'));
                var spinner = component.find("mySpinner");
                $A.util.toggleClass(spinner, "slds-hide");
            } else {
                console.log('Failed with state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    
    zoomIn : function(component, event, helper) {
        var zoom = component.get('v.zoomLevel');
        if(zoom <= 99) {
            var newZoom = zoom + 1;
            component.set('v.zoomLevel',parseInt(newZoom));
            var tree = component.find('mainPatt').getElement().style.zoom=newZoom+'%';
        }
    },
    
    zoomOut : function(component, event, helper) {
        var zoom = component.get('v.zoomLevel');
        if(zoom >= 51) {
            var newZoom = zoom - 1;
            component.set('v.zoomLevel',newZoom);
            var tree = component.find('mainPatt').getElement().style.zoom=newZoom+'%';
        }
    },
    
    handleZoom : function(component, event, helper) {
        var test = component.find('shabba');
        component.set('v.zoomLevel',parseInt(test.get('v.value')));
        var tree = component.find('mainPatt').getElement().style.zoom= test.get('v.value') + '%';
    },
    
    navigateToAccount : function(cmp, e, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": cmp.get('v.accountId'),
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
})