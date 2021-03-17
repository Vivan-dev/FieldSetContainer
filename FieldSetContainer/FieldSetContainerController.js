({
    init: function(cmp, event, helper) {
        var sobjectName = cmp.get('v.sObjectName');
        var fsNamesString = cmp.get("v.fieldSetName");
        if (!fsNamesString) return;
        var fsNamesRaw = fsNamesString.split(",");
        var fsNames = [];
        for (var i = 0; i < fsNamesRaw.length; i++) {
            var fsName = fsNamesRaw[i].trim();
            if (fsName) {
                fsNames.push(fsName);
            }
        }
        if (!fsNames || fsNames.length == 0) {
            console.error('No field sets');
            return;
        }
        cmp.set("v.fieldSetNameList", fsNames);

        var getFormAction = cmp.get('c.getForm');
        getFormAction.setParams({
            objectName: sobjectName,
            fieldSetNames: fsNames
        });

        getFormAction.setCallback(this,
            function(response) {
                var state = response.getState();
                if (cmp.isValid() && state === "SUCCESS") {
                    console.log(response.getReturnValue());
                    cmp.set("v.fieldSetsData", response.getReturnValue());
                } else {
                    console.error(response.getError());
                }
            }
        );
        $A.enqueueAction(getFormAction);
    }
})