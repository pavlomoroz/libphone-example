import { LightningElement } from "lwc";
import getPhoneNumberInfo from "@salesforce/apex/UtilsController.getPhoneNumberInfo";
import { COUNTRIES_PICKLIST } from "c/data";

export default class LibphoneEx1 extends LightningElement {
    btnDisabled = true;
    hasData = false;

    phoneInfo;

    handleBlur() {
        const input = this.template.querySelector(".phone");
        this.disabled = !input.validity.valid;
    }

    handleClick() {
        const country     = this.template.querySelector(".country").value;
        const phoneNumber = this.template.querySelector(".phone").value;
        getPhoneNumberInfo({countryCode: country, userPhoneNumber: phoneNumber})
            .then(result => {
                this.phoneInfo = result;
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

    get disabled() {
        return this.btnDisabled;
    }
}