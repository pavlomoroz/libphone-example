public with sharing class ContactHandler {

    static noltic_libphone.PhoneNumberUtil phoneUtil = noltic_libphone.PhoneNumberUtil.getInstance();

    public static void handleTrigger (List<Contact> workingRecords, Map<Id, Contact> oldMapRecords, System.TriggerOperation triggerEvent) {
        switch on triggerEvent {
            when BEFORE_INSERT, BEFORE_UPDATE {
                try {

                    for (Contact theContact : workingRecords) {
                        noltic_libphone.PhoneNumber pn = phoneUtil.parse(theContact.Phone, 'US');

                        if (phoneUtil.isValidNumber(pn)) {
                            // Formatted numbers will be added to description
                            theContact.Description =
                                formatPhoneNumber('E164', phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.E164));
                            theContact.Description +=
                                formatPhoneNumber('INTERNATIONAL', phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.INTERNATIONAL));
                            theContact.Description +=
                                formatPhoneNumber('NATIONAL', phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.NATIONAL));
                            theContact.Description +=
                                formatPhoneNumber('RFC3966', phoneUtil.format(pn, noltic_libphone.PhoneNumberUtil.PhoneNumberFormat.RFC3966));

                        }
                    }
                } catch (Exception e) {
                    // Error handling
                    System.debug(e.getMessage());
                }

            }
        }
    }

    static String formatPhoneNumber(String title, String phoneNumber) {
        return String.format('{0}: {1} \n', new String[] { title, phoneNumber });
    }
}