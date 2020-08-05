import { LightningElement } from "lwc";
import { COUNTRIES_PICKLIST } from "c/data";
import getNumberType from "@salesforce/apex/UtilsController.getNumberType";

export default class LibphoneEx2 extends LightningElement {
    btnDisabled = true;
    hasData = false;

    isPhoneNumberValid;
    phoneNumberType;

    handleBlur() {
        const input = this.template.querySelector(".phone");
        this.disabled = !input.validity.valid;
    }

    handleClick() {
        const country     = this.template.querySelector(".country").value;
        const phoneNumber = this.template.querySelector(".phone").value;
        getNumberType({countryCode: country, userPhoneNumber: phoneNumber})
            .then(result => {
                const {VALID, TYPE} = result;

                this.isPhoneNumberValid = VALID === 'true';
                this.phoneNumberType = TYPE;
                this.hasData = true;
            })
            .catch(error => console.log(error))
        ;
    }

    get countries() {
        return COUNTRIES_PICKLIST
    }

    set disabled(value) {
        this.btnDisabled = value;
    }
}