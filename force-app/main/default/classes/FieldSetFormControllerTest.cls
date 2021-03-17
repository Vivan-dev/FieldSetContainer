@isTest
public with sharing class FieldSetFormControllerTest {

    //If Account doesn't have Annual Fieldset you must change it here
    @isTest
    static void testGetForm(){
        List<FieldSetFormController.FieldSet> result = new List<FieldSetFormController.FieldSet>();
        Map<String, Schema.FieldSet> fieldSetMap = Schema.getGlobalDescribe().get('Account').getDescribe().fieldSets.getMap();
        List<String> fields = new List<String>();
        Schema.FieldSet fieldSet = fieldSetMap.get('Annual');
        if (fieldSet != null) {
            for (Schema.FieldSetMember fsm : fieldSet.getFields()) {
                fields.add(fsm.getFieldPath());
            }
        }   
        result.add(new FieldSetFormController.FieldSet('Annual','Annual Campaign Giving',fields));     
        List<String> testList = new List<String>();
        testList.add('Annual');
        System.assertEquals(result[0].ApiName,FieldSetFormController.getForm('Account',testList)[0].ApiName);
        System.assertEquals(result[0].Label,FieldSetFormController.getForm('Account',testList)[0].Label);  
        System.assertEquals(result[0].Fields.size(),FieldSetFormController.getForm('Account',testList)[0].Fields.size()); 

    }
}