public with sharing class FieldSetFormController {

    @AuraEnabled
    public static List<FieldSet> getForm(String objectName, List<String> fieldSetNames) {
        List<FieldSet> result = new List<FieldSet>();
        Map<String, Schema.FieldSet> fieldSetMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap();
        for (String fsName : fieldSetNames) {
            if (!String.isBlank(fsName)) {
                result.add(new FieldSet(fsName, fieldSetMap.get(fsName).getLabel(), getFieldNames(fieldSetMap, fsName)));
            }
        }
        return result;
    }
    
    private static List<String> getFieldNames(Map<String, Schema.FieldSet> fieldSetMap, String fieldSetName) {
        List<String> result = new List<String>();
        Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);
        if (fieldSet != null) {
            for (Schema.FieldSetMember fsm : fieldSet.getFields()) {
                result.add(fsm.getFieldPath());
            }
        }
        return result;
    }

    public class FieldSet {
        @AuraEnabled
        public String apiName { get; set; }
        @AuraEnabled
        public String label { get; set; }
        @AuraEnabled
        public List<String> fields { get; set; }

        public FieldSet(String apiName, String label, List<String> fields) {
            this.apiName = apiName;
            this.label = label;
            this.fields = fields;
        }
    }
}