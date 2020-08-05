public with sharing class UtilsController {

    @AuraEnabled(Cacheable=true)
    public static Map<String, String> getPhoneNumberInfo(String countryCode, String userPhoneNumber) {
        noltic_libphone.PhoneNumberUtil phoneUtil = noltic_libphone.PhoneNumberUtil.getInstance();
        noltic_libphone.PhoneNumber pn = phoneUtil.parse(userPhoneNumber, countryCode);

        return new Map<String, String>{
            'E164'          => phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.E164),
            'INTERNATIONAL' => phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.INTERNATIONAL),
            'NATIONAL'      => phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.NATIONAL),
            'RFC3966'       => phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.RFC3966)
        };
    }

    @AuraEnabled(Cacheable=true)
    public static Map<String, String> getNumberType(String countryCode, String userPhoneNumber) {
        try {
            noltic_libphone.PhoneNumberUtil phoneUtil = noltic_libphone.PhoneNumberUtil.getInstance();
            noltic_libphone.PhoneNumber pn = phoneUtil.parse(userPhoneNumber, countryCode);

            return new Map<String, String>{
                'VALID' => String.valueOf(phoneUtil.isValidNumber(pn)),
                'TYPE'  => phoneUtil.getNumberType(pn).name()
            };
        } catch (Exception e) {
            return new Map<String, String>{
                'VALID' => 'false',
                'TYPE'  => noltic_libphone.PhoneNumberUtil.PhoneNumberTypeEnum.UNKNOWN.name()
            };
        }

    }
}